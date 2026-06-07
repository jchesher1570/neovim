-- ~/.config/nvim/lua/config/init.lua

-- Provide a non-deprecated implementation WITHOUT referencing the old one
vim.tbl_flatten = function(t)
  return vim.iter(t):flatten(math.huge):totable()
end

