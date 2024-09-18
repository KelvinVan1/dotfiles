return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  config = function()

    local bg_transparent = false

    -- Loading Color Scheme
    require('catppuccin').setup({
      flavour = "mocha",
      transparent_background = false
    })

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      require('catppuccin').setup({
        transparent_background = bg_transparent
      })
      vim.cmd [[colorscheme catppuccin]]
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })

    vim.cmd.colorscheme "catppuccin"
  end,
}