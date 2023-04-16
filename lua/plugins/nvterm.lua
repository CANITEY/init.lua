return {
   {
      "NvChad/nvterm",
      lazy = false,
      keys = {
         { "<leader>h", function () require("nvterm.terminal").toggle("horizontal") end, "terminal" },
         { "<leader>v", function () require("nvterm.terminal").toggle("vertical") end, "terminal" },
         { "<leader>f", function () require("nvterm.terminal").toggle("float") end, "terminal" },
      },
      config = function ()
         require("nvterm").setup({
            float = {
               relative = 'editor',
               row = 0.3,
               col = 0.25,
               width = 0.5,
               height = 0.4,
               border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = .3, },
            vertical = { location = "rightbelow", split_ratio = .5 },
         })
      end
   }
}
