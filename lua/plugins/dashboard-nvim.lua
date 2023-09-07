function createFile()
   x = vim.fn.input("File Name: ", "") 
   cmd = "e " .. x
   if x ~= "" then
      vim.cmd(cmd)
      return
   end
   vim.cmd[[Dashboard]]
end

function emptyFile()
    vim.api.nvim_create_buf(false,false)
    vim.api.nvim_set_current_buf(2)
end

function tempFile()
    file = math.random(1, 999999)
    cmd = "e /tmp/" .. file
    vim.cmd(cmd)
end

return {
   {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
          require('dashboard').setup {
              theme = 'hyper',
              shortcut_type = 'number',
              change_to_vcs_root = true,
              disable_move = true,
              config = {
                  header = {
                      "           ▄ ▄                   ",
                      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
                      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
                      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
                      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
                      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
                      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
                      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
                      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
                      "                                 ",

                  },
                  shortcut = {
                      { desc = ' New', group = '@Number', action = 'lua createFile()', key = 'n' },
                      { desc = ' Empty', group = '@property', action = 'lua emptyFile()', key = 'e' },
                      { desc = ' Temporary', group = '@variable', action = 'lua tempFile()', key = 't' },
                      { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
                      {
                          icon = ' ',
                          icon_hl = '@variable',
                          desc = 'Files',
                          group = 'Label',
                          action = 'Telescope find_files',
                          key = 'f',
                      },
                      {
                          icon = ' ',
                          desc = 'Planets',
                          group = 'DiagnosticHint',
                          action = 'Telescope planets',
                          key = 'p',
                      },
                      {
                          desc = ' builtin',
                          group = 'Number',
                          action = 'Telescope builtin',
                          key = 'b',
                      },
                  },
              },
              -- after header
          }
      end,
  }
}
