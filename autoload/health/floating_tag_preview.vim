function! health#floating_tag_preview#check() abort
  call health#report_start('Check if running inside NeoVim')

  if has('nvim')
    call health#report_ok('Confirmed to run with NeoVim')
    lua require('floating_tag_preview.health').check()

  else
    call health#report_error('NeoVim is required but could not be found')
  end
endfunction
