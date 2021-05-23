-- NOTES:
-- There is the following issue with the preview window handling. In theory it
-- would be more efficient/ straight forward to check if there is already one
-- open and if so, re-use it. Basically the same as NeoVim does it itself.
-- Unfortunately does this approach lead to issues with the auto command to
-- close the window. As this is bound to the `CursorMoved`, it will be
-- triggered while the procedure runs. As result this code here does not open a
-- new window as there is already one open. And also th native preview command
-- still recognizes the old preview window. But for unknown reason the practise
-- has shown that the window disappears in the meantime. So while no error pops
-- up nothing happens visually for the user. To make this working or the
-- moment, it will always close the old window if there is one and then open a
-- new one. While not perfect it is working reliably.

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

local function close_floating_preview_window()
  local window_number = get_preview_window_number()

  if window_number ~= -1 then
    vim.api.nvim_win_close(window_number, true)
  end
end

local function open_floating_preview_window()
  close_floating_preview_window() -- See details in module header.

  local width = vim.g.floating_tag_preview_width or (vim.o.textwidth > 0 and vim.o.textwidth) or 70
  local height = vim.g.floating_tag_preview_height or vim.o.previewheight
  local border = vim.g.floating_tag_preview_border or 'single'
  local window_options = vim.lsp.util.make_floating_popup_options(width, height, { border = border })
  local buffer_number = vim.api.nvim_create_buf(false, true)
  local window_number = vim.api.nvim_open_win(buffer_number, false, window_options)

  vim.api.nvim_win_set_option(window_number, 'previewwindow', true)

  return window_number
end

return {
  open_floating_preview_window = open_floating_preview_window,
  close_floating_preview_window = close_floating_preview_window
}
