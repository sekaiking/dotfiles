require "config"

vim.api.nvim_create_user_command('Arabic', function()
  require('custom/arabic_typing').toggle_arabic_typing()
end, {})
