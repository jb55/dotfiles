# -*- coding: utf-8 -*-
###
# Copyright (c) 2010 by Elián Hanisch <lambdae2@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

###
#   Needs WeeChat 0.3.4
#
#   Commands:
#
#   Settings:
#   * plugins.var.python.znc-playback.timestamp:
#     Timestamp format used by ZNC during playback, default is "[%H:%M:%S]".
#     Only prepended timestamps supported.
#     
#     The default timestamp should be good enough in most cases, but since it lacks year, month and
#     day information, logs might end up with wrong dates if the day changed during playback. So is
#     advisable to configure ZNC and znc-playback to use timestamps like "[%y/%m/%d %H:%M:%S]"
#
#   * plugins.var.python.znc-playback.send_signals:
#     TODO
#
#   History:
#   <date>
#   version 0.1-dev: new script!
#
###

try:
    import weechat
    from weechat import WEECHAT_RC_OK, WEECHAT_HOOK_SIGNAL_STRING, prnt_date_tags, prnt
    import_ok = True
except ImportError:
    print "This script must be run under WeeChat."
    print "Get WeeChat now at: http://www.weechat.org/"
    import_ok = False

import re
import time
import datetime

SCRIPT_NAME    = "znc-playback"
SCRIPT_AUTHOR  = "Elián Hanisch <lambdae2@gmail.com>"
SCRIPT_VERSION = "0.1-dev"
SCRIPT_LICENSE = "GPL3"
SCRIPT_DESC    = "znc playback"

# -------------------------------------------------------------------------
# Config 

settings = {
        'timestamp': '[%H:%M:%S]',
        'send_signals' : 'off',
        }

boolDict = {'on':True, 'off':False}
def get_config_boolean(config):
    value = weechat.config_get_plugin(config)
    try:
        return boolDict[value]
    except KeyError:
        default = settings[config]
        error("Error while fetching config '%s'. Using default value '%s'." %(config, default))
        error("'%s' is invalid, allowed: 'on', 'off'" %value)
        return boolDict[default]

# -----------------------------------------------------------------------------
# Print Utils

script_nick = SCRIPT_NAME
def error(s, buffer=''):
    """Error msg"""
    prnt(buffer, '%s%s %s' %(weechat.prefix('error'), script_nick, s))
    if weechat.config_get_plugin('debug'):
        import traceback
        if traceback.sys.exc_type:
            trace = traceback.format_exc()
            prnt('', trace)

def say(s, buffer=''):
    """normal msg"""
    prnt(buffer, '%s\t%s' %(script_nick, s))

def catchExceptions(f):
    def function(*args, **kwargs):
        try:
            return f(*args, **kwargs)
        except Exception, e:
            error(e)
    return function

# -----------------------------------------------------------------------------
# Script Callbacks

buffer_playback = {}
nick_talked = set()

_hostmaskRe = re.compile(r':?\S+!\S+@\S+') # poor but good enough
def is_hostmask(s):
    """Returns whether or not the string s starts with something like a hostmask."""
    return _hostmaskRe.match(s) is not None

@catchExceptions
def playback_cb(data, modifier, modifier_data, string):
    global COLOR_RESET, COLOR_CHAT_DELIMITERS, COLOR_CHAT_NICK, COLOR_CHAT_HOST, \
           COLOR_CHAT_CHANNEL, COLOR_CHAT, COLOR_MESSAGE_JOIN, COLOR_MESSAGE_QUIT, \
           COLOR_REASON_QUIT, SMART_FILTER
    global send_signals, znc_timestamp

    plugin, buffer_name, tags = modifier_data.split(';')
    if plugin != 'irc' or buffer_name == 'irc_raw':
        return string

    if tags:
        tags = set(tags.split(','))
    else:
        tags = set()
    
    global buffer_playback
    if 'nick_***' in tags:
        line = string.partition('\t')[2]
        if line == 'Buffer Playback...':
            weechat.hook_signal_send("znc-playback-start",
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     buffer_name)
            debug("* buffer playback for %s", buffer_name)
            get_config_options()
            nick_talked.clear()
            buffer = weechat.buffer_search(plugin, buffer_name)
            buffer_playback[buffer_name] = buffer
        elif line == 'Playback Complete.':
            buffer = buffer_playback[buffer_name]
            del buffer_playback[buffer_name]
            debug("* end of playback for %s", buffer_name)
            weechat.hook_signal_send("znc-playback-stop",
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     buffer_name)
        tags.discard('notify_message')
        tags.discard('irc_privmsg')
        prnt_date_tags(buffer, 0, ','.join(tags), string)
        return ''

    elif not (buffer_playback and buffer_name in buffer_playback):
        return string

    buffer = buffer_playback[buffer_name]

    #debug(string)

    def strip_timestamp(s):
        words = znc_timestamp.count(' ') + 1
        p = 0
        for i in range(words):
            p = s[p:].find(' ') + p + 1
        return s[:p - 1], s[p:]

    prefix, s, line = string.partition('\t')
    if 'irc_action' in tags or 'irc_notice' in tags:
        _prefix, _, line = line.partition(' ')
        timestamp, line = strip_timestamp(line)
        line = '%s %s' % (_prefix, line)
    else:
        timestamp, line = strip_timestamp(line)

    try:
        t = time.strptime(timestamp, znc_timestamp)
    except ValueError, e:
        # bad time format.
        error(e)
        #debug("%s\n%s" % (modifier_data, string))
        return string
    else:
        if t[0] == 1900:
            # only hour information, complete year, month and day with today's date
            # might be incorrect though if day changed during playback.
            t = datetime.time(*t[3:6])
            d = datetime.datetime.combine(datetime.date.today(), t)
        else:
            d = datetime.datetime(*t[:6])
        time_epoch = int(time.mktime(d.timetuple()))

    if 'nick_*buffextras' not in tags:
        # not a line coming from ZNC buffextras module.
        nick_talked.add((buffer, weechat.string_remove_color(prefix, '')))
        prnt_date_tags(buffer, time_epoch, ','.join(tags), "%s\t%s" % (prefix, line))
        return ''

    tags.discard('notify_message')
    tags.discard('irc_privmsg')
    tags.discard('nick_*buffextras')

    hostmask, s, line = line.partition(' ')
    nick = hostmask[:hostmask.find('!')]
    host = hostmask[len(nick) + 1:]
    server, channel = buffer_name.split('.', 1)

    s = None
    if line == 'joined':
        tags.add('irc_join')
        s = weechat.gettext("%s%s%s%s%s%s%s%s%s%s has joined %s%s%s")
        s = s %(weechat.prefix('join'),
                COLOR_CHAT_NICK, # TODO there's a function for use nick's color
                nick,
                COLOR_CHAT_DELIMITERS,
                ' (',
                COLOR_CHAT_HOST, # TODO host can be hidden in config
                host,
                COLOR_CHAT_DELIMITERS,
                ')',
                COLOR_MESSAGE_JOIN,
                COLOR_CHAT_CHANNEL,
                channel,
                COLOR_MESSAGE_JOIN)

        if send_signals:
            weechat.hook_signal_send(server + ",irc_in_JOIN",
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s JOIN :%s" % (hostmask, channel))

    elif line == 'parted':
        tags.add('irc_part')
        # buffextras doesn't seem to send the part's reason.
        s = weechat.gettext("%s%s%s%s%s%s%s%s%s%s has left %s%s%s")
        s = s %(weechat.prefix('quit'),
                COLOR_CHAT_NICK,
                nick,
                COLOR_CHAT_DELIMITERS,
                ' (',
                COLOR_CHAT_HOST,
                host,
                COLOR_CHAT_DELIMITERS,
                ')',
                COLOR_MESSAGE_QUIT,
                COLOR_CHAT_CHANNEL,
                channel,
                COLOR_MESSAGE_QUIT)

        if send_signals:
            weechat.hook_signal_send(server + ",irc_in_PART", 
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s PART %s" % (hostmask, channel))

    elif line.startswith('quit with message:'):
        tags.add('irc_quit')
        reason = line[line.find('[') + 1:-1]
        s = weechat.gettext("%s%s%s%s%s%s%s%s%s%s has quit %s(%s%s%s)")
        s = s %(weechat.prefix('quit'),
                COLOR_CHAT_NICK,
                nick,
                COLOR_CHAT_DELIMITERS,
                ' (',
                COLOR_CHAT_HOST,
                host,
                COLOR_CHAT_DELIMITERS,
                ')',
                COLOR_MESSAGE_QUIT,
                COLOR_CHAT_DELIMITERS,
                COLOR_REASON_QUIT,
                reason,
                COLOR_CHAT_DELIMITERS)

        # QUIT messages should be sent only once, but since there's
        # one quit per channel, use PART instead.
        if send_signals:
            weechat.hook_signal_send(server + ",irc_in_PART", 
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s PART %s :%s" % (hostmask, channel, reason))

    elif line.startswith('is now known as '):
        tags.add('irc_nick')
        new_nick = line.rpartition(' ')[-1]
        s = weechat.gettext("%s%s%s%s is now known as %s%s%s")
        s = s %(weechat.prefix('network'),
                COLOR_CHAT_NICK,
                nick,
                COLOR_CHAT,
                COLOR_CHAT_NICK,
                new_nick,
                COLOR_CHAT)

        # NICK messages should be sent only once, but since there's one
        # per every channel, we fake it with a PART/JOIN
        if send_signals:
            new_hostmask = new_nick + hostmask[hostmask.find('!'):]
            weechat.hook_signal_send(server + ",irc_in_PART", 
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s PART %s" % (hostmask, channel))
            weechat.hook_signal_send(server + ",irc_in_JOIN",
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s JOIN :%s" % (new_hostmask, channel))

    elif line.startswith('set mode: '):
        tags.add('irc_mode')
        modes = line[line.find(':') + 2:]
        s = weechat.gettext("%sMode %s%s %s[%s%s%s]%s by %s%s")
        s = s %(weechat.prefix('network'),
                COLOR_CHAT_CHANNEL,
                channel,
                COLOR_CHAT_DELIMITERS,
                COLOR_CHAT,
                modes,
                COLOR_CHAT_DELIMITERS,
                COLOR_CHAT,
                COLOR_CHAT_NICK,
                nick)
        
        if send_signals:
            # buffextras can send an invalid hostmask "nick!@" sometimes
            # fix it so at least is valid.
            if not is_hostmask(hostmask):
                nick = hostmask[:hostmask.find('!')]
                hostmask = nick + '!unknow@unknow'
            weechat.hook_signal_send(server + ",irc_in_MODE", 
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s MODE %s %s" % (hostmask, channel, modes))

    elif line.startswith('kicked'):
        tags.add('irc_kick')
        _, nick_kicked, reason = line.split(None, 2)
        reason = reason[reason.find('[') + 1:-1]
        s = weechat.gettext("%s%s%s%s has kicked %s%s%s %s(%s%s%s)")
        s = s %(weechat.prefix('quit'),
                COLOR_CHAT_NICK,
                nick,
                COLOR_MESSAGE_QUIT,
                COLOR_CHAT_NICK,
                nick_kicked,
                COLOR_MESSAGE_QUIT,
                COLOR_CHAT_DELIMITERS,
                COLOR_CHAT,
                reason,
                COLOR_CHAT_DELIMITERS)

        if send_signals:
            weechat.hook_signal_send(server + ",irc_in_KICK", 
                                     WEECHAT_HOOK_SIGNAL_STRING,
                                     ":%s KICK %s %s :%s" % (hostmask,
                                                             channel,
                                                             nick_kicked,
                                                             reason))

    elif line.startswith('changed the topic to: '):
        tags.add('irc_topic')
        topic = line[line.find(':') + 2:]
        s = weechat.gettext("%s%s%s%s has changed topic for %s%s%s to \"%s%s\"")
        s = s %(weechat.prefix('network'),
                COLOR_CHAT_NICK,
                nick,
                COLOR_CHAT,
                COLOR_CHAT_CHANNEL,
                channel,
                COLOR_CHAT,
                topic,
                COLOR_CHAT)
    
    # crude smart filter
    if SMART_FILTER and (buffer, nick) not in nick_talked \
            and ('irc_join' in tags \
                 or 'irc_part' in tags \
                 or 'irc_quit' in tags \
                 or 'irc_nick' in tags):
        tags.add('irc_smart_filter')
    
    if s is None:
        error('Unknown message from ZNC: %r' % string)
        return string
    else:
        prnt_date_tags(buffer, time_epoch, ','.join(tags), s)
        return ''

def get_config_options():
    global COLOR_RESET, COLOR_CHAT_DELIMITERS, COLOR_CHAT_NICK, COLOR_CHAT_HOST, \
           COLOR_CHAT_CHANNEL, COLOR_CHAT, COLOR_MESSAGE_JOIN, COLOR_MESSAGE_QUIT, \
           COLOR_REASON_QUIT, SMART_FILTER
    global send_signals, znc_timestamp 

    config_get_string = lambda s: weechat.config_string(weechat.config_get(s))
    COLOR_RESET           = weechat.color('reset')
    COLOR_CHAT_DELIMITERS = weechat.color('chat_delimiters')
    COLOR_CHAT_NICK       = weechat.color('chat_nick')
    COLOR_CHAT_HOST       = weechat.color('chat_host')
    COLOR_CHAT_CHANNEL    = weechat.color('chat_channel')
    COLOR_CHAT            = weechat.color('chat')
    COLOR_MESSAGE_JOIN    = weechat.color(config_get_string('irc.color.message_join'))
    COLOR_MESSAGE_QUIT    = weechat.color(config_get_string('irc.color.message_quit'))
    COLOR_REASON_QUIT     = weechat.color(config_get_string('irc.color.reason_quit'))

    SMART_FILTER = weechat.config_boolean(weechat.config_get("irc.look.smart_filter"))
        
    send_signals = get_config_boolean('send_signals')
    znc_timestamp = weechat.config_get_plugin('timestamp')

# -----------------------------------------------------------------------------
# Main

print_hook = ''
if __name__ == '__main__' and import_ok and \
        weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE,
                         SCRIPT_DESC, '', ''):

    get_config_options()

    # pretty [SCRIPT_NAME]
    script_nick = '%s[%s%s%s]%s' % (COLOR_CHAT_DELIMITERS, 
                                    COLOR_CHAT_NICK,
                                    SCRIPT_NAME, 
                                    COLOR_CHAT_DELIMITERS,
                                    COLOR_RESET)

    # settings
    for opt, val in settings.iteritems():
        if not weechat.config_is_set_plugin(opt):
            weechat.config_set_plugin(opt, val)

    print_hook = weechat.hook_modifier('weechat_print', 'playback_cb', '')

    # -------------------------------------------------------------------------
    # Debug

    if weechat.config_get_plugin('debug'):
        try:
            # custom debug module I use, allows me to inspect script's objects.
            import pybuffer
            debug = pybuffer.debugBuffer(globals(), '%s_debug' % SCRIPT_NAME)
        except:
            def debug(s, *args):
                if not isinstance(s, basestring):
                    s = str(s)
                if args:
                    s = s %args
                prnt('', '%s\t%s' %(script_nick, s))
    else:
        def debug(*args):
            pass


# vim:set shiftwidth=4 tabstop=4 softtabstop=4 expandtab textwidth=100:
