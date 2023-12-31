local map = vim.keymap.set

-- Unmap arrow keys in all modes >:
map({ "n", "v", "i" }, "<Up>", "<Nop>")
map({ "n", "v", "i" }, "<Down>", "<Nop>")
map({ "n", "v", "i" }, "<Left>", "<Nop>")
map({ "n", "v", "i" }, "<Right>", "<Nop>")


-- Shift + j/k to move lines up and down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- save file
map("n", "<C-s>", ":w<CR>")

-- Copy to Clipboard
map({ "v", "n" }, "<leader>y", '"+y')
map("n", "<leader>yy", '"+yy') -- Copy line

-- Paste from Clipboard
map({ "v", "n" }, "<leader>p", '"+p')
map({ "v", "n" }, "<leader>P", '"+P')
