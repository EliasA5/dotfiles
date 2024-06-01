
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  group = misc_augroup,
  pattern = '*',
  command = 'silent! normal! g`"zv'
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local function write(osc52)
  local success = false

  if vim.fn.filewritable('/dev/fd/2') == 1 then
    success = vim.fn.writefile({osc52}, '/dev/fd/2', 'b') == 0
  else
    success = vim.fn.chansend(vim.v.stderr, osc52) > 0
  end

  return success
end

vim.api.nvim_create_autocmd({ 'TermRequest' }, {
  desc = 'Handles OSC 52',
  callback = function(args)
    if args.data:match('\027]52;c;') then
      local to_copy = args.data:gsub('\027]52;c;', '')
      local osc52 = string.format('\27]52;c;%s\7', to_copy)
      if os.getenv("TMUX")
          or os.getenv("TERM"):match("^tmux")
          or os.getenv("TERM"):match("^screen") then
        osc52 = string.format('\27Ptmux;\27%s\27\\', osc52)
      end
      write(osc52)
    end
  end
})
