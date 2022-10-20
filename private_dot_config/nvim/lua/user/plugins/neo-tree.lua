return {
  close_if_last_window = true,
  enable_diagnostics = true,
  window = {
    position = "left",
    width = 35,
  },
  filesystem = {
    filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
}
