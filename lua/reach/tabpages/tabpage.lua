local Tabpage = {}
local A = vim.api
local plenary = require('plenary')

function Tabpage:new(tabnr)
  local o = {}

  o.tabnr = tabnr
  o.wins = vim.api.nvim_tabpage_list_wins(tabnr)

  self.__index = self
  return setmetatable(o, self)
end

function Tabpage:title()
  local win = A.nvim_tabpage_get_win(self.tabnr)
  local buf = A.nvim_win_get_buf(win)
  local name = A.nvim_buf_get_name(buf)
  return plenary.path:new(name):shorten(1)
end
function Tabpage:number()
  return vim.api.nvim_tabpage_get_number(self.tabnr)
end

function Tabpage:handle()
  local number = self:number()
  return number > 9 and vim.fn.nr2char(number + 87) or tostring(number)
end

return Tabpage
