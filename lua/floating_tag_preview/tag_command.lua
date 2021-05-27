local function validate_command_options(options)
  vim.validate({ ['command options'] = { options, 'table' }})
  vim.validate({ command = { options.command, 'string' }})
  vim.validate({ count = { options.count, 'number', true }})
  vim.validate({ range = { options.range, 'table', true }})

  if options.range ~= nil then
    vim.validate({ ['range.line1'] = { options.range.line1, 'number' }})
    vim.validate({ ['range.line2'] = { options.range.line2, 'number' }})
  end

  vim.validate({ bang = { options.bang, 'string', true }})
  vim.validate({ arguments = { options.arguments, 'string', true }})
end

local function execute_command(options)
  validate_command_options(options)

  local full_command = options.command

  if options.count ~= nil then
    full_command = options.count .. full_command
  elseif options.range ~= nil then
    full_command = options.range.line1 .. ',' .. options.range.line2 .. full_command
  end

  if options.bang ~= nil then
    full_command = full_command .. options.bang
  end

  if options.arguments ~= nil then
    full_command = full_command .. " " .. options.arguments
  end

  local success, error_message = pcall(vim.api.nvim_command, full_command)

  if not success then
    vim.api.nvim_command('silent! wincmd z')
    error(error_message)
  end
end

return {
  execute_command = execute_command,
}
