local window_utils = require('floating_tag_preview.window')
local tag_command_utils = require('floating_tag_preview.tag_command')
local auto_command_utils = require('floating_tag_preview.auto_commands')

return function(tag_command_options)
  vim.validate({['tag command options'] = { tag_command_options, 'table' }})

  window_utils.open_floating_preview_window()
  tag_command_utils.execute_command(tag_command_options)
  auto_command_utils.set_closing_auto_command()
end
