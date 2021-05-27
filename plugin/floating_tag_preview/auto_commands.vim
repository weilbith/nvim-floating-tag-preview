augroup FloatingTagPreview
  autocmd!
  autocmd BufAdd * 
        \ lua require('floating_tag_preview.auto_commands').set_options_for_possible_preview_buffer(
        \   vim.g.floating_tag_preview_buffer_options or {
        \     buflisted = false,
        \     bufhidden = 'wipe',
        \   }
        \ )
augroup END
