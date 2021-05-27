local window_utils = require('floating_tag_preview.window')
local tag_command_utils = require('floating_tag_preview.tag_command')
local auto_command_utils = require('floating_tag_preview.auto_commands')

return function(tag_command_options)
  vim.validate({['tag command options'] = { tag_command_options, 'table' }})

  auto_command_utils.clear_closing_auto_command()
  window_utils.open_floating_preview_window()
  tag_command_utils.execute_command(tag_command_options)

  if vim.g.floating_tag_preview_auto_close or true then
    auto_command_utils.set_closing_auto_command()
  end
end
