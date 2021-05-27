if !get(g:, 'floating_tag_preview_disable_default_mapping', v:false)
  nnoremap <C-W>}   <cmd>execute 'Ptag ' . expand('<cword>')<CR>
  nnoremap <C-W>g}  <cmd>execute 'Ptjump ' . expand('<cword>')<CR>
endif
