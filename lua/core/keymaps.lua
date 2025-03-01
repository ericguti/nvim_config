vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

------------------------------------------
------          PLUGINS        -----------
------------------------------------------
---Open neotree with \
vim.keymap.set("n", "<Leader>\\", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- Keymap for Telescope pickers
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true }) -- Find files
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true }) -- Live grep
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })   -- Buffers
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true }) -- Help tags
vim.api.nvim_set_keymap('n', '<Leader>tl', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
