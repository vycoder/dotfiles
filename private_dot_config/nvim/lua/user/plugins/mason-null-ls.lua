return { -- overrides `require("mason-null-ls").setup(...)`
  automatic_installation = true,
  ensure_installed = {
    "stylua",
    "shfmt",
    "rustfmt",
    "eslint_d",
    "shellcheck",
  },
}
