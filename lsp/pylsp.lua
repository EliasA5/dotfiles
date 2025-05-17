return {
  root_dir = function(fname)
    local util = require('lspconfig.util')
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
    }
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
  settings = {
    pylsp = {
      configurationSources = {"flake8"},
      plugins = {
        flake8 = {
          enabled = false,
          extendIgnore = {"E501", "W504", "E402"}
        },
        autopep8 = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
      }
    }
  }
}
