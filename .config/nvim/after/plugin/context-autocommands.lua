vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	command = "ContextActivate",
})
-- autocmd BufAdd       * call context#update('BufAdd')
-- autocmd BufEnter     * call context#update('BufEnter')
-- autocmd CursorMoved  * call context#update('CursorMoved')
-- autocmd VimResized   * call context#update('VimResized')
-- autocmd CursorHold   * call context#update('CursorHold')
-- autocmd User GitGutter call context#update('GitGutter')
-- autocmd OptionSet number,relativenumber,numberwidth,signcolumn,tabstop,list
--             \          call context#update('OptionSet')
--
-- if exists('##WinScrolled')
--     autocmd WinScrolled * call context#update('WinScrolled')
-- endif
