return {
   {
      "nvim-tree/nvim-tree.lua",
      keys = {
         { "<leader>d", vim.cmd.NvimTreeToggle, "nvim tree" }
      },
      config = function()
         require("nvim-tree").setup({
            disable_netrw = false,
            update_cwd = true,
            sort_by = "case_sensitive",
            view = {
            centralize_selection = true,
            number = true,
         },
            renderer = {
               group_empty = true,
            },
            filters = {
               dotfiles = true,
            },
         })
      end
   }
}
