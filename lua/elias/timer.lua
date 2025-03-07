
local function add_timer(fn, waitfirst)
  local function timedFn()
    local wait = fn()
    vim.defer_fn(timedFn, wait)
  end
  vim.defer_fn(timedFn, waitfirst)
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

if vim.g.savesession then
  add_timer(function ()
    vim.api.nvim_command("mks!")
    vim.notify("Saved session!", vim.log.levels.INFO)
    return 900000
  end, 10000)
end
