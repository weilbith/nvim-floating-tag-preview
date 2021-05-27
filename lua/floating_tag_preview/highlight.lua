local function save_tag_word_to_cache(word)
  vim.validate({['tag word'] = { word, 's' }})

  vim.g.floating_tag_preview_cached_tag_word = word
end

local function load_tag_word_from_cache()
  return vim.g.floating_tag_preview_cached_tag_word
end

local function determine_and_cache_tag_word(command_arguments)
  vim.validate({['command arguments'] = { command_arguments, 'string', true }})

  if command_arguments ~= nil and #command_arguments > 0 then
    local first_argument = string.gmatch(command_arguments, "%w+")()
    save_tag_word_to_cache(first_argument)
  end

  -- Else we stick to the last cached word as the command is a follow up for
  -- the last one with and argument. (e.g. `Ptnext`)
end

local function highlight_tag_word_in_preview_window(window_number)
  vim.validate({ ['preview window number'] = { window_number, 'number' }})

  local tag_word = load_tag_word_from_cache()

  if tag_word == nil or #tag_word == 0 then
    return
  end

  local buffer_number = vim.api.nvim_win_get_buf(window_number)

  vim.api.nvim_buf_call(buffer_number, function()
    vim.api.nvim_call_function('search', { tag_word, 'c' })
  end)

  local cursor = vim.api.nvim_win_get_cursor(window_number)
  local line = cursor[1] - 1
  local column_start = cursor[2]
  local column_end = column_start + #tag_word

  vim.api.nvim_buf_add_highlight(
    buffer_number,
    -1,
    'FloatingTagPreviewTagWord', line,
    column_start,
    column_end
  )
end

return {
  determine_and_cache_tag_word = determine_and_cache_tag_word,
  highlight_tag_word_in_preview_window = highlight_tag_word_in_preview_window,
}
