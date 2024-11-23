-- with animations
-- return {
--   {
--     "anuvyklack/windows.nvim",
--     dependencies = {
--       "anuvyklack/middleclass", -- Required dependency
--       "anuvyklack/animation.nvim", -- Optional dependency for animations
--     },
--     config = function()
--       require('windows').setup({
--         -- Configuration options for the plugin
--         autowidth = {
--           enable = true,
--           winwidth = 20, -- Minimum window width
--           filetype = { help = 30 }, -- Custom width for specific filetypes
--         },
--         ignore = { -- Filetypes to ignore
--           "NvimTree",
--           "Outline",
--         },
--       })
--     end,
--   },
-- }

return {
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass', -- Required dependency
      'anuvyklack/animation.nvim', -- Optional dependency for animations
    },
    config = function()
      require('windows').setup {
        ignore = { -- Filetypes to ignore
          'neo-tree',
          'NvimTree',
          'Outline',
        },
      }
    end,
  },
}
