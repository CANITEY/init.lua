return {
  'projekt0n/github-nvim-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
        options = {
            compile_path = '/home/mohammed/.local/share/nvim/github-theme',
            compile_file_suffix = '_compiled', -- Compiled file suffix
            styles = {
                comments = "italic",
                functions = "bold",
                variables = "italic",
                types = "italic,bold",
            }
        }
    })
  end,
}
