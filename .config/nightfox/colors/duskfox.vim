lua << EOF
-- Useful when debugging
if vim.g.nightfox_debug then
  require("nightfox.util.reload")()
end

require("nightfox.config").set_fox("duskfox")
require("nightfox").load()
EOF
