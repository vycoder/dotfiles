return {
  { "wakatime/vim-wakatime" },
  { "ThePrimeagen/refactoring.nvim" },
  { "declancm/cinnamon.nvim" },
  ["gen740/SmoothCursor.nvim"] = {
    config = function() require("smoothcursor").setup(require "user.plugins.smoothcursor") end,
  },
  ["EdenEast/nightfox.nvim"] = {
    config = function() require("nightfox").setup(require "user.plugins.nightfox") end,
  },
}
