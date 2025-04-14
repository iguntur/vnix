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

local function execute_query(start_line, end_line)
	if start_line == nil and end_line == nil then
		return vim.cmd("SqlsExecuteQuery")
	end

	-- Execute the statement with the custom command
	vim.cmd(start_line .. "," .. end_line .. " SqlsExecuteQuery")
end

local function visual_selected_line(start_row, start_col, end_row, end_col)
	local bufnr = vim.api.nvim_get_current_buf()
	local higroup = "IncSearch"
	local start = { start_row, start_col or 0 }
	local finish = { end_row, end_col or -1 }
	local opts = { timeout = 150 }
	local ns_id = 1
	vim.hl.range(bufnr, ns_id, higroup, start, finish, opts)
end

local function exec_current_statement()
	local lineNumber, column = get_cursor_pos()

	-- move cursor at 0 column before get statement range
	set_cursor_pos(lineNumber, 0)

	local start_row, start_col, end_row, end_col = get_statement_range()

	if start_row == nil or start_col == nil then
		return
	end

	start_row = start_row + 1
	end_row = end_row + 1

	-- Visually select the statement
	visual_selected_line(start_row - 1, start_col, end_row, end_col)

	-- Execute the statement with the custom command
	execute_query(start_row, end_row)

	-- back to previous cursor position
	vim.schedule(function()
		set_cursor_pos(lineNumber, column)
	end)
end

function M.exec()
	local m = vim.fn.mode()

	if m ~= "n" and m ~= "V" and m ~= "\22" then
		return
	end

	if m == "V" or m == "\22" then
		return execute_query()
	end

	exec_current_statement()
end

-- vim.keymap.set({ "n", "v" }, "<leader>z", M.exec, {
-- 	silent = true,
-- 	-- buffer = vim.api.nvim_get_current_buf(),
-- 	desc = "Execute query",
-- })

return M
