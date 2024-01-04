local required_api_function_names = {
  'nvim_command',
  'nvim_create_buf',
  'nvim_buf_call',
  'nvim_buf_set_option',
  'nvim_buf_add_highlight',
  'nvim_open_win',
  'nvim_win_set_option',
  'nvim_win_get_option',
  'nvim_win_get_cursor',
  'nvim_win_get_buf',
  'nvim_tabpage_list_wins',
}

-- Return boolean to signal if further check make sense.
local function check_if_basic_api_exists()
  vim.health.start("Check that NeoVim's Lua API exists")

  if vim ~= nil and vim.api ~= nil then
    vim.health.ok('API exists')
    return true
  else
    vim.health.error("API is missing!")
    return false
  end
end

local function check_if_api_is_complete()
  vim.health.start('Check that all API is complete')

  local missing_api_function_names = {}

  for _, api_function_name in ipairs(required_api_function_names) do
    local api_function = vim.api[api_function_name]

    if api_function == nil or not vim.is_callable(api_function) then
      table.insert(missing_api_function_names, api_function_name)
    end
  end

  if #missing_api_function_names == 0 then
    vim.health.ok('All required API functions are available')
  else
    for _, api_function_name in ipairs(missing_api_function_names) do
      vim.health.error(
        "Missing API functions: '" .. api_function_name .. "'"
      )
    end
  end
end

local function check()
  local api_exists = check_if_basic_api_exists()

  if api_exists then
    check_if_api_is_complete()
  end
end

return {
  check = check,
}
