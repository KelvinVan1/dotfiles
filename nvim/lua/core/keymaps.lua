-- Set leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable space key's default behavior in Normal and Visual mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness (mapping cant be redefined and wont show in the command line)
local opts = { noremap = true, silent = true }

-- Save file with ctrl-s if needed
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting if needed
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- Exits out of a file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- Delete single character without copying into register (Using x to remove a character no longer overrides the paste command)
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize Vim splits using arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffer Navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- closes buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window Management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertical
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontal
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width-height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Split Navigation
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) -- goto next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) -- goto previous tab

-- Line Wrap Toggle
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in visual after indent
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yank when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' }, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' }, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' }, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Open diagnostics list' }, opts)
