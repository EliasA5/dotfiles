
vim.keymap.set("n", "<leader>vd", function()
  require('elixir-extras').elixir_view_docs({include_mix_libs=true})
end)

