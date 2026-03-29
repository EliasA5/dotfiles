return {
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
