local ls = require 'luasnip'

ls.add_snippets('lua', {
  ls.parser.parse_snippet('fn', 'function ${1:name}(${2:args})\n  ${3}\nend'),
  ls.parser.parse_snippet('req', "local ${1:module} = require('${1:module}')"),
})
