-- Use the exact the custom close function instead of `wincmd z`, as else this
-- causes issues where the window disappears when cycling through tags.
local function set_closing_auto_command()
  if vim.g.floating_tag_preview_auto_close or true then
    vim.api.nvim_command(
      'autocmd! CursorMoved,WinScrolled <buffer> ++once silent! lua require("floating_tag_preview.window").close_floating_preview_window()'
    )
  end
end

return {
  set_closing_auto_command = set_closing_auto_command,
}
