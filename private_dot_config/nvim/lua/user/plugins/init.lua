return {
  { "wakatime/vim-wakatime" },
  ["gen740/SmoothCursor.nvim"] = {
    config = function() require("smoothcursor").setup(require "user.plugins.smoothcursor") end,
  },
  ["ThePrimeagen/refactoring.nvim"] = {
    config = function() require("refactoring").setup() end,
  },
  ["EdenEast/nightfox.nvim"] = {
    config = function() require("nightfox").setup(require "user.plugins.nightfox") end,
  },
}
