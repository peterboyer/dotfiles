local M = {
  config = function()
    require("telescope").setup{
      defaults = {
        file_ignore_patterns = {
          "%.git/",
          "%.yarn/",
        },
        path_display = { "truncate" }
      },
      pickers = {
        find_files = {
          follow = true, -- follow symlinks
          hidden = true, -- show dotfiles
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer"
            }
          }
        }
      },
    }
  end,
}

return M
