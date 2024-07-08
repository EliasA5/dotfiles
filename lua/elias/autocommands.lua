
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

-- add the following to .bashrc and launch nvim with nvims
-- nvims () {
--     if [[ -z "$@" ]]; then
--         if [[ -f "./Session.vim" ]]; then
--             nvim -S Session.vim -c 'lua vim.g.savesession = true'
--         else
--             nvim -c 'lua vim.g.savesession = true' .
--         fi
--     else
--         nvim "$@"
--     fi
-- }

vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    if vim.g.savesession then
      vim.api.nvim_command("mks!")
    end
  end
})

