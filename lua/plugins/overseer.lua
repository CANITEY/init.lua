return {
  'stevearc/overseer.nvim',
  lazy = true,
  cmd = {"OverseerRun", "OverseerToggle"},
  config = function() 
      require('overseer').setup()
  end
}
