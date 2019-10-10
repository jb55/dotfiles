# commands to ignore
cmdignore=(htop tmux top vim)


function sec_to_human () {
    local H=''
    local M=''
    local S=''

    local h=$(($1 / 3600))
    [ $h -gt 0 ] && H="${h} hour " && [ $h -gt 1 ] && H="${H}s"

    local m=$((($1 / 60) % 60))
    [ $m -gt 0 ] && M="${m} min " && [ $m -gt 1 ] && M="${M}s"

    local s=$(($1 % 60))
    [ $s -gt 0 ] && S="${s} sec" && [ $s -gt 1 ] && S="${S}s"

    echo $H$M$S
}

# Function taken from undistract-me, get the current window id
function active_window_id () {
    if [[ -n $DISPLAY ]] ; then
        xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}'
        return
    fi
    echo nowindowid
}

# end and compare timer, notify-send if needed
function notifyosd-precmd() {
    retval=$?
    if [[ ${cmdignore[(r)$cmd_basename]} == $cmd_basename ]]; then
        return
    else
        if [ ! -z "$cmd" ]; then
            cmd_end=`date +%s`
            ((cmd_time=$cmd_end - $cmd_start))
        fi
        if [ $retval -gt 0 ]; then
            icon="cross-mark"
        else
            icon="check-mark"
        fi
        if [ ! -z "$cmd" -a $cmd_time -gt 3 ] && [[ "$cmd_active_win" != "$(active_window_id)" ]]; then
            longtimeout="$(((cmd_time / 3) * 1000))"
            timeout="$(btcs -t 15000 $longtimeout min)"
            local human="$(sec_to_human $cmd_time)"
            if [ ! -z $SSH_TTY ] ; then
                notify-send -t $timeout -i $icon "Command took $human" "$cmd"
            else
                notify-send -t $timeout -i $icon "Command took $human" "$cmd"
            fi
        fi
        unset cmd
    fi
}

# make sure this plays nicely with any existing precmd
precmd_functions+=( notifyosd-precmd )

# get command name and start the timer
function notifyosd-preexec() {
    cmd=$1
    cmd_basename=${${cmd:s/sudo //}[(ws: :)1]}
    cmd_start=$(date +%s)
    cmd_active_win=$(active_window_id)
}

# make sure this plays nicely with any existing preexec
preexec_functions+=( notifyosd-preexec )
