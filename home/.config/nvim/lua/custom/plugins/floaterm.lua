vim.keymap.set('n', '<C-t>', ':FloatermToggle<CR>', { desc = 'Toggle [T]erminal' })

local g = vim.g
g.floaterm_wintype = "split"
g.floaterm_height = 0.3

return {
  "voldikss/vim-floaterm",
  config = function()
  end,
}

