-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "typescript",
      "javascript",
      "go",
      "rust",
      "json",
      "zig",
      "elixir",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
