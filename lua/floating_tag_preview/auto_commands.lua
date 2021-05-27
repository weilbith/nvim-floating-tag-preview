local auto_close_command_group_name = 'FloatingTagPreviewAutoClose'
local auto_close_command_options = ' <buffer> ++once wincmd z'

local function set_closing_auto_command(event_names)
  vim.validate({['auto closing event name'] = { event_names, 'table' }})

  vim.api.nvim_command('augroup ' .. auto_close_command_group_name)

  for _, event in ipairs(event_names) do
    vim.api.nvim_command('autocmd! ' .. event .. auto_close_command_options)
  end

  vim.api.nvim_command('augroup END')
end

local function clear_closing_auto_command()
  vim.api.nvim_command('silent! autocmd! ' .. auto_close_command_group_name)
end

-- Acts on current window and buffer (meant to be called for buffer events).
local function set_options_for_possible_preview_buffer(options)
  vim.validate({['preview buffer options'] = { options, 'table' }})

  local is_preview_window = vim.api.nvim_win_get_option(0, 'previewwindow')

  if is_preview_window then
    for name, value in pairs(options) do
      vim.api.nvim_buf_set_option(0, name, value)
    end
  end
end

return {
  clear_closing_auto_command = clear_closing_auto_command,
  set_closing_auto_command = set_closing_auto_command,
  set_options_for_possible_preview_buffer = set_options_for_possible_preview_buffer,
}
