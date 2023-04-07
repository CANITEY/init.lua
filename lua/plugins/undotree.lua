return {
    { 
        "mbbill/undotree",
        event = "BufEnter"
    },
	vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
}
