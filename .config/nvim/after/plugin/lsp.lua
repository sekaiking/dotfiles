require("trouble").setup({
  auto_close = true,
})

require("lsp_signature").setup({})

require("corn").setup({
  sort_method = "severity",

  icons = {
    error = " ",
    warning = " ",
    info = " ",
    hint = " ",
  },

  item_preprocess_func = function(item)
    return item
  end,
})

vim.keymap.set("n", "<leader>fE", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>fe", function() require("trouble").toggle("document_diagnostics") end)
