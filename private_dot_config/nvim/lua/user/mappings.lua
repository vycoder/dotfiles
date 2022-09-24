-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    ["<leader>Q"] = { ":qa!<cr>", desc = "Force Quit" },
    ["<leader>a"] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  -- Insert mode
  i = {
    ["<C-b>"] = { "<ESC>^i", desc = "Beginning of line" },
    ["<C-e>"] = { "<End>", desc = "End of line" },
    ["<C-s>"] = { "<esc>:w!<cr>", desc = "Save File" },
    ["<C-h>"] = { "<left>", desc = "Move left" },
    ["<C-l>"] = { "<right>", desc = "Move right" },
    ["<C-j>"] = { "<down>", desc = "Move down" },
    ["<C-k>"] = { "<up>", desc = "Move up" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
