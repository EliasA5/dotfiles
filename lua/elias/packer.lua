-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'Mofiqul/dracula.nvim'
  use { 'echasnovski/mini.comment', config = function() require('mini.comment').setup() end }
  use { 'echasnovski/mini.surround',  config = function() require('mini.surround').setup() end }

end)

