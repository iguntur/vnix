local a = vim.api

local function vnix_terminal_window(opts)
	opts = opts or {}

	local height = opts.win_height or 15 -- Set your custom height here
	local width = a.nvim_get_option_value("columns", {})

	local buf = opts.buffer or -1

	if not a.nvim_buf_is_valid(buf) then
		buf = a.nvim_create_buf(false, true)
	end

	local win_config = {
		-- relative = "editor",
		width = width,
		height = height,
		-- row = row,
		-- col = col,
		-- style = "minimal",
		-- border = "rounded",
		-- win = 0,
		split = "below",
	}

	local window = a.nvim_open_win(buf, true, win_config)

	return {
		buffer = buf,
		window = window,
	}
end

local state = {
	buffer = -1,
	window = -1,
}

local default_opts = {
	win_height = 10,
}

local function toggle_window_terminal()
	if a.nvim_win_is_valid(state.window) then
		a.nvim_win_hide(state.window)
		return
	end

	local term = vnix_terminal_window({
		buffer = state.buffer,
		win_height = default_opts.win_height,
	})

	state.buffer = term.buffer
	state.window = term.window

	-- attach to terminal mode
	if vim.bo[state.buffer].buftype ~= "terminal" then
		vim.cmd.terminal()
	end

	vim.b[state.buffer].focus_disable = true

	vim.cmd.wincmd("J") -- put the window on the bottom
	a.nvim_win_set_height(state.window, default_opts.win_height)
	vim.cmd.startinsert()
end

vim.keymap.set({ "n", "t" }, "<C-c><C-_>", toggle_window_terminal, {
	silent = true,
	desc = "Toggle Terminal",
})
