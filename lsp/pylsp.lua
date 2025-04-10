return {
  cmd = { 'pylsp' },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
  },
  settings = {
    pylsp = {
      plugins = {
        pyflakes = {enabled = false},
        pylint = {enabled = false},
        pycodestyle = {enabled = false}
      },
    },
  }
}
