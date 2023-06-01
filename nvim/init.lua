require("config.keymap")
require("config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
	"--filter=blob:none",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = { notify = false },
	ui = { border = "rounded" }
})
