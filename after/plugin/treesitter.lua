require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "erlang", "python", "scheme", "ocaml", "lua", "vim", "vimdoc", "query"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  textobjects = {
      move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = { ["[["] = "@parameter.inner", },
          goto_next_start = { ["]]"] = "@parameter.inner", },
      },
      select = {
          enable = true,
          lookahead = true,
          keymaps = {
              ["iq"] = {query = "@parameter.inner", desc = "Select inner part of function parameter" },
              ["aq"] = {query = "@parameter.outer", desc = "Select outer part of function parameter" },
          },
      },
	  swap = {
		  enable = true,
		  swap_next = {
			  ["<leader>q"] = "@parameter.inner",
		  },
		  swap_previous = {
			  ["<leader>Q"] = "@parameter.inner",
		  },
	  },
  },

}

