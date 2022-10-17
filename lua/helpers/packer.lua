local packer = require('packer')
local packer_helpers = {}

function packer_helpers.compile_both(standalone_path, vscode_path)
  print("Hello from the compile stuff")
  local original_vscode_value = vim.g.vscode

  vim.g.vscode = nil
  packer.compile(standalone_path)
  vim.g.vscode = 1
  packer.compile(vscode_path)
  vim.g.vscode = original_vscode_value
end

return packer_helpers

