if !get(g:, 'floating_tag_preview_overwrite_mappings', v:false)
  nnoremap <C-W>}   <cmd>execute 'Ptag ' . expand('<cword>')<CR>
  nnoremap <C-W>g}  <cmd>execute 'Ptjump ' . expand('<cword>')<CR>
endif
