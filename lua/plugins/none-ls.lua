-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Custom Swift formatter using swift-format
    local swift_format = {
      method = null_ls.methods.FORMATTING,
      filetypes = { "swift" },
      generator = null_ls.formatter({
        command = "swiftformat",
        args = { "$FILENAME" },
        to_stdin = false,
        from_stderr = false,
        format = "raw",
        check_exit_code = function(code)
          return code <= 1
        end,
      }),
    }

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Set a formatter
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd.with {
        condition = function(utils)
          local is_biome = utils.root_has_file "biome.json"
          return utils.root_has_file {
            ".prettierrc",
            ".prettierrc.js",
            ".prettierrc.json",
            ".prettierrc.toml",
            ".prettierrc.yaml",
            ".prettierrc.yml",
          } or not is_biome
        end,
      },
      null_ls.builtins.formatting.biome.with {
        condition = function(utils) return utils.root_has_file "biome.json" end,
      },
      -- Swift formatter
      swift_format,
    })
  end,
  disabled = false,
}
