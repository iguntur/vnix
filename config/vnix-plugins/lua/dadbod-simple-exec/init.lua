local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

M.supported_ft = {
	"mysql",
	"plsql",
	"sql",
}

local function get_statement_range()
	local node = ts_utils.get_node_at_cursor()

	while node do
		if node:type() == "statement" then
			return node:range()
		end

		node = node:parent()
	end

	return nil
end

local function get_cursor_pos()
	local cursor = vim.fn.getpos(".") -- current cursor position
	local lineNumber = cursor[2]
	local column = cursor[3]

	return lineNumber, column
end

local function set_cursor_pos(lineNumber, column)
	vim.fn.setpos(".", { 0, lineNumber, column, 0 })
end

local function exec_query()
	-- Execute the statement with the custom command
	vim.cmd([[execute "normal! \<Plug>(DBUI_ExecuteQuery)"]])
end

local function exec_current_statement()
	local lineNumber, column = get_cursor_pos()

	-- move cursor at 0 column before get statement range
	set_cursor_pos(lineNumber, 0)

	local start_row, start_col, end_row, end_col = get_statement_range()

	if start_row == nil or start_col == nil then
		return
	end

	-- Visually select the statement
	vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
	vim.cmd("normal! V")
	vim.api.nvim_win_set_cursor(0, { end_row + 1, end_col })

	exec_query() -- Execute the statement with the custom command

	-- back to previous cursor position
	set_cursor_pos(lineNumber, column)
end

function M.exec()
	local m = vim.fn.mode()

	if m ~= "n" and m ~= "V" and m ~= "\22" then
		return
	end

	if m == "V" or m == "\22" then
		return exec_query()
	end

	exec_current_statement()
end

-- vim.keymap.set({ "n", "v" }, "<leader>z", M.exec, {
-- 	silent = true,
-- 	desc = "Execute query",
-- })

return M
