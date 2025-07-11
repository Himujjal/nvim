local env = require "env"
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
      luasnip.filetype_extend("typescript", { "typescriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- -- add more custom autopairs configuration such as custom rules
      -- local npairs = require "nvim-autopairs"
      -- local Rule = require "nvim-autopairs.rule"
      -- local cond = require "nvim-autopairs.conds"
      -- npairs.add_rules(
      -- {
      --   Rule("$", "$", { "tex", "latex" })
      --     -- don't add a pair if the next character is %
      --     :with_pair(cond.not_after_regex "%%")
      --     -- don't add a pair if  the previous character is xxx
      --     :with_pair(
      --       cond.not_before_regex("xxx", 3)
      --     )
      --     -- don't move right when repeat character
      --     :with_move(cond.none())
      --     -- don't delete if the next character is xx
      --     :with_del(cond.not_after_regex "xx")
      --     -- disable adding a newline when you press <cr>
      --     :with_cr(cond.none()),
      -- },
      -- -- disable for .vim files, but it work for another filetypes
      -- Rule("a", "a", "-vim")
      -- )
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["o"] = { "open", nowait = true },
        },
      },
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "BufRead",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<C-l>",
          accept_word = "<C-k>",
          clear_suggestion = "<C-c>",
        },
        disable_keymaps = false, -- disables built in keymaps for more manual control
        log_level = "off",
      }
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -- {
  --   "augmentcode/augment.vim",
  --   config = function()
  --     vim.g.augment_workspace_folders = env.AUGMENT_FOLDERS
  --       or {
  --         "~/projects/littlebird/Little-Bird-Client",
  --         "~/projects/littlebird/Little-Bird-Backend",
  --       }
  --   end,
  -- },
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      window = {
        position = "vertical",
      },
      keymaps = {
        toggle = {
          normal = "<C-.>",
          terminal = "<C-.>",
          window_navigation = true,
          scrolling = true,
        },
      },
    },
  },
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "codecompanion" },
    },
    ft = { "markdown", "codecompanion" },
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require "mini.diff"
      diff.setup {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
