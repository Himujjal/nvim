-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    env = "sh",
    ignore = "gitignore",
  },
  filename = {
    [".env"] = "sh",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
}

vim.g.zig_fmt_autosave = 0

if vim.g.neovide then vim.o.guifont = "FiraCode Nerd Font:h13" end
