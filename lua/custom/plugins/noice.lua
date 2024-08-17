-- lazy.nvim

return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
      'hrsh7th/nvim-cmp',
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },

    config = function()
      require('noice').setup {

        -- WARN: [START] LSP not yet ready
        -- lsp = {
        --   -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        --   override = {
        --     ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        --     ['vim.lsp.util.stylize_markdown'] = true,
        --     ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        --   },
        -- },
        -- WARN: [END] LSP not yet ready

        -- -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  vim.keymap.set('n', '<Leader>nd', '<cmd>NoiceDismiss<CR>', { desc = 'Dismiss Noice Message' }),
}
