local helpers = {}

function helpers.in_vscode()
  if vim.g.vscode then
    return true
  else
    return false -- want to return a boolean, not 0
  end
end

function helpers.standalone()
  return not helpers.in_vscode()
end

function helpers.cmdify(thing)
  return "<cmd>"..thing.."<cr>"
end

return helpers


