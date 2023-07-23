local status, which_key = pcall(require, "which-key")
if not status then
	return
end

which_key.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
})
