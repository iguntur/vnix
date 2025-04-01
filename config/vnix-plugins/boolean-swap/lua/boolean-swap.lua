local a = vim.api
local esc = a.nvim_replace_termcodes("<esc>", true, false, true)

local function get_cursor_pos()
	local cursor = vim.fn.getpos(".") -- current cursor position
	local lineNumber = cursor[2]
	local column = cursor[3]

	return lineNumber, column
end

local function replace(value)
	a.nvim_feedkeys("ciw", "n", false)
	a.nvim_feedkeys(value, "n", false)
	a.nvim_feedkeys(esc, "n", true)
end

local M = {}

function M.toggle()
	local _, column = get_cursor_pos()
	local char = a.nvim_get_current_line():sub(column, column)

	if not string.match(char, "[a-zA-Z]") then
		return
	end

	local word = vim.fn.expand("<cword>")

	if word == "true" then
		return replace("false")
	end

	if word == "false" then
		return replace("true")
	end

	if word == "True" then
		return replace("False")
	end

	if word == "False" then
		return replace("True")
	end

	if word == "TRUE" then
		return replace("FALSE")
	end

	if word == "FALSE" then
		return replace("TRUE")
	end
end

return M
