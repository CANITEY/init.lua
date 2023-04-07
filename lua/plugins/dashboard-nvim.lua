return {
   {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
         require('dashboard').setup {
            theme = 'hyper',
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
         }
      end,
   }
}
