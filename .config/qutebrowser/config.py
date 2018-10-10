# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
import socket
hostname = socket.gethostname()

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

if hostname == 'quiver':
  config.set('zoom.default', 125)

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Editor (and arguments) to use for the `open-editor` command. The
# following placeholders are defined: * `{file}`: Filename of the file
# to be edited. * `{line}`: Line in which the caret is found in the
# text. * `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = ['edit', '{file}']

# This setting can be used to map keys to other keys. When the key used
# as dictionary-key is pressed, the binding for the key used as
# dictionary-value is invoked instead. This is useful for global
# remappings of keys, for example to map Ctrl-[ to Escape. Note that
# when a key is bound (via `bindings.default` or `bindings.commands`),
# the mapping is ignored.
# Type: Dict
c.bindings.key_mappings = {'<Ctrl+6>': '<Ctrl+^>', '<Ctrl+Enter>': '<Ctrl+Return>', '<Ctrl+j>': '<Return>', '<Ctrl+m>': '<Return>', '<Ctrl+[>': '<Escape>', '<Enter>': '<Return>', '<Shift+Enter>': '<Return>', '<Shift+Return>': '<Return>'}

# Bindings for normal mode
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('e', 'open-editor')
config.bind('co', 'tab-only --keep-pinned')
config.bind('gl', 'tab-move +')
config.bind('gh', 'tab-move -')

config.set('tabs.select_on_remove', 'last-used')

config.set('url.default_page', 'about:blank')

config.set('url.searchengines', {
  'DEFAULT': 'https://google.com/search?q={}',
  'd': 'http://duckduckgo.com/?q={}',
  'star': 'https://github.com/stars?utf8=%E2%9C%93&q={}',
  'so': 'https://google.com/search?q=site:stackoverflow.com {}',
  'call': 'https://phabricator.monstercat.com/diffusion/r{}',
  'gl': 'http://www.google.com/search?q={}&btnI=Im+Feeling+Lucky',
  'ghi': 'https://github.com/{}/issues',
  'wa': 'http://www.wolframalpha.com/input/?i={}',
  'ha': 'https://google.com/search?q=site:hackage.haskell.org {}',
  'gamedev': 'http://gamedev.stackexchange.com/search?q={}',
  'diff': 'https://phabricator.monstercat.com/diffusion/{}',
  'npm': 'https://npmjs.org/search?q={}',
  'crate': 'https://crates.io/search?q={}',
  'zen': 'http://brandalliance.zendesk.com/search?query={}',
  'g': 'https://www.google.com/search?q={}',
  'ud': 'http://www.urbandictionary.com/define.php?term={}',
  'alert': 'http://alrt.io/{}',
  'hackage': 'http://hackage.haskell.org/package/{}',
  'travis': 'https://travis-ci.org/{}',
  'ttx': 'https://testnet.smartbit.com.au/tx/{}/',
  'e': 'https://www.google.com/search?q=site%3Apackage.elm-lang.org+{}&btnI=Im+Feeling+Lucky',
  'key': 'https://www.npmjs.org/browse/keyword/{}',
  'y': 'http://www.youtube.com/results?search_query={}',
  'h': 'http://holumbus.fh-wedel.de/hayoo/hayoo.html?query={}',
  'lh': 'http://localhost:8080/?hoogle={}',
  'hoogle': 'http://www.haskell.org/hoogle/?hoogle={}',
  'github': 'http://github.com/search?q={}',
  'r': 'https://old.reddit.com/r/{}',
  'a': 'http://blockchain.info/address/{}',
  'bgg': 'http://www.boardgamegeek.com/metasearch.php?searchtype=game&search={}',
  'pgp': 'http://pgp.mit.edu/pks/lookup?search={}&op=index',
  'task': 'https://phabricator.monstercat.com/{}',
  'phab': 'https://phabricator.monstercat.com/r{}',
  'gh': 'https://github.com/{}',
  'c': 'http://component.io/search/{}',
  'repo': 'http://npmrepo.com/{}',
  'ec': 'http://package.elm-lang.org/packages/elm-lang/{}/latest',
  'tx': 'https://blockchain.info/tx/{}'
})



