return {
    'navarasu/onedark.nvim',
    config = function()
        require('onedark').setup {
            style = 'darker',
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'bold',
                strings = 'none',
                variables = 'bold,italic',
            },
        }
    end
}
