local window_utils = require('floating_tag_preview.window')
local highlight_utils = require('floating_tag_preview.highlight')
local tag_command_utils = require('floating_tag_preview.tag_command')
local auto_command_utils = require('floating_tag_preview.auto_commands')

return function(tag_command_options)
  vim.validate({['tag command options'] = { tag_command_options, 'table' }})

  auto_command_utils.clear_closing_auto_command()
  highlight_utils.determine_and_cache_tag_word(tag_command_options.arguments)

  local preview_window_open_options = {
    width = vim.g.floating_tag_preview_width or (vim.o.textwidth > 0 and vim.o.textwidth) or 70,
    height = vim.g.floating_tag_preview_height or vim.o.previewheight,
    border = vim.g.floating_tag_preview_border or 'single',
  }

  local preview_window_set_options = vim.g.floating_tag_preview_window_options or {
    foldlevel = 100
  }

  local window_number = window_utils.open_floating_preview_window(
    preview_window_open_options,
    preview_window_set_options
  )

  tag_command_utils.execute_command(tag_command_options)

  if vim.g.floating_tag_preview_highlight_tag_word or true then
    highlight_utils.highlight_tag_word_in_preview_window(window_number)
  end

  local auto_closing_events = vim.g.floating_tag_preview_auto_closing_events or {
    'CursorMoved',
    'WinScrolled',
  }

  auto_command_utils.set_closing_auto_command(auto_closing_events)
end
