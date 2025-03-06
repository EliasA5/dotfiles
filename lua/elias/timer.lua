
local function add_timer(fn, waitfirst)
  local function timedFn()
    local wait = fn()
    vim.defer_fn(timedFn, wait)
  end
  vim.defer_fn(timedFn, waitfirst)
end

if vim.g.savesession then
  add_timer(function ()
    vim.api.nvim_command("mks!")
    print("Saved session!")
    return 900000
  end, 10000)
end
