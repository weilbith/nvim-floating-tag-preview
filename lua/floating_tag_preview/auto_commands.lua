local auto_close_command_group_name = 'FloatingTagPreviewAutoClose'

local function set_closing_auto_command()
  vim.api.nvim_command('augroup ' .. auto_close_command_group_name)
  vim.api.nvim_command('autocmd! CursorMoved,WinScrolled <buffer> ++once wincmd z')
  vim.api.nvim_command('augroup END')
end

local function clear_closing_auto_command()
  vim.api.nvim_command('silent! autocmd! ' .. auto_close_command_group_name)
end

return {
  clear_closing_auto_command = clear_closing_auto_command,
  set_closing_auto_command = set_closing_auto_command,
}
