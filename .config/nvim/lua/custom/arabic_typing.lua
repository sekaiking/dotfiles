local M = {}

local arabic_enabled = false

local arabic_mappings = {
  -- I don't use Qwerty, so it will stay empty for now
}

local arabic_mappings_dvorak = {
  ['\''] = 'ض',
  [','] = 'ص',
  ['.'] = 'ث',
  ['p'] = 'ق',
  ['y'] = 'ف',
  ['f'] = 'غ',
  ['g'] = 'ع',
  ['c'] = 'ه',
  ['r'] = 'خ',
  ['l'] = 'ح',
  ['/'] = 'ج',
  ['='] = 'د',
  ['a'] = 'ش',
  ['o'] = 'س',
  ['e'] = 'ي',
  ['u'] = 'ب',
  ['i'] = 'ل',
  ['d'] = 'ا',
  ['h'] = 'ت',
  ['t'] = 'ن',
  ['n'] = 'م',
  ['s'] = 'ك',
  ['-'] = 'ط',
  ['\\'] = 'ذ',
  [';'] = 'ئ',
  ['q'] = 'ء',
  ['j'] = 'ؤ',
  ['k'] = 'ر',
  ['x'] = 'لا',
  ['b'] = 'ى',
  ['m'] = 'ة',
  ['w'] = 'و',
  ['v'] = 'ز',
  ['z'] = 'ظ',
}


function M.toggle_arabic_typing()
  if arabic_enabled then
    -- Disable Arabic typing
    for key, _ in pairs(arabic_mappings_dvorak) do
      vim.api.nvim_del_keymap('i', key)
    end
    vim.opt.arabicshape = true
    vim.opt.rightleft = false
    vim.opt.guicursor = ''
    arabic_enabled = false
  else
    -- Enable Arabic typing
    for key, arabic_char in pairs(arabic_mappings_dvorak) do
      vim.api.nvim_set_keymap('i', key, arabic_char, { noremap = true, silent = true })
    end
    vim.opt.arabicshape = false
    vim.opt.rightleft = true
    vim.opt.guicursor = 'i-ci-ve:hor20'
    arabic_enabled = true
  end
end

return M
