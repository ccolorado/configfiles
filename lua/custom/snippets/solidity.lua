local ls = require 'luasnip'

ls.add_snippets('solidity', {

  -- NOTE: way better snippets (func, funcr, funcrview)
  -- ls.parser.parse_snippet('fn', 'function ${1:name}(${2:args})\n  ${3}\nend'),
  --
  -- funcrview  | returns View Function declaration
  -- funcr      | returns function declaration
  -- func       | function declaration

  -- NOTE: NAT DOC
  -- ///nat_statevariable | statevariable getter
  -- ///nat_function      | function nat
  -- ///nat_event         | event nat
  -- ///nat_contract      | contract nat

  ls.parser.parse_snippet('@p', '/// @param ${1:name} ${2:description}\n$3'),

  ls.parser.parse_snippet('txcall', '(bool sent, ${3:bytes data}) = ${1:recipient}.call{value: ${2:amount}}("");'),
  -- Reference: https://solidity-by-example.org/sending-ether/

  -- ls.add_snippets({ 'solidity', 'typescript', 'javascript' }, {
  ls.add_snippets('solidity', {
    -- Console log variable
    ls.snippet('lv', {
      ls.text_node { 'console.log(' },
      ls.function_node(function(_, snip)
        return tostring(snip.env.TM_LINE_NUMBER)
      end, {}),
      ls.text_node { ', "' },
      ls.dynamic_node(2, function(args)
        return ls.snippet_node(nil, {
          ls.text_node(args[1][1] or 'var_name'),
        })
      end, { 1 }),
      ls.text_node { '", ' },
      ls.insert_node(1, ''),
      ls.text_node { ');' },
    }),

    ls.snippet('ll', {
      ls.text_node 'console.log(">>',
      -- Function node to get the full file path
      ls.function_node(function(_, snip)
        -- Get the full file path
        local file_path = vim.api.nvim_buf_get_name(0)
        return file_path
      end, {}),
      ls.text_node ': ',
      -- Function node to get the current line number
      ls.function_node(function(_, snip)
        -- Get the current line number
        return tostring(vim.fn.line '.')
      end, {}),
      ls.text_node '");',
    }),
  }),
})
