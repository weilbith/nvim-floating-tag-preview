-- The return value of -1 indicates that there is no preview window open.
local function get_preview_window_number()
  local all_window_numbers = vim.api.nvim_tabpage_list_wins(0)

  for _, window_number in ipairs(all_window_numbers) do
    local is_preview_window = vim.api.nvim_win_get_option(window_number, 'previewwindow')

    if (is_preview_window) then
      return window_number
    end
  end

  return -1
end

local function open_floating_preview_window(window_open_options)
  vim.validate({['preview window open options'] = { window_open_options, 'table' }})
  vim.validate({['window window width'] = { window_open_options.width, 'number' }})
  vim.validate({['window window height'] = { window_open_options.height, 'number' }})
  -- Can not validate border as it can be either string or table.

  local old_window_number = get_preview_window_number()

  if old_window_number ~= -1 then
    return old_window_number
  end

  local window_options = vim.lsp.util.make_floating_popup_options(
    window_open_options.width,
    window_open_options.height,
    { border = window_open_options.border }
  )
  local buffer_number = vim.api.nvim_create_buf(false, true)
  local window_number = vim.api.nvim_open_win(buffer_number, false, window_options)

  vim.api.nvim_win_set_option(window_number, 'previewwindow', true)

  return window_number
end

return {
  open_floating_preview_window = open_floating_preview_window,
}
