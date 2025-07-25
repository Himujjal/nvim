local env = require "env"

vim.env.GROQ_KEY = env.GROQ_KEY
vim.env.GEMINI_KEY = env.GEMINI_KEY
vim.env.ANTHROPIC_API_KEY = env.ANTHROPIC_KEY
vim.env.CEREBRAS_KEY = env.CEREBRAS_KEY
vim.env.BRAVE_API_KEY = env.BRAVE_API_KEY

local GROQ_HOST = "https://api.groq.com/openai/v1/"
local GROQ_MODEL = "llama-3.3-70b-versatile"
local GEMINI_MODEL = "gemini-2.5-flash-preview-05-20"
local CEREBRAS_MODEL = "llama-3.3-70b" -- "qwen-3-32b" -- "llama-4-scout-17b-16e-instruct"

---@class avante.Config
---@class avante.CoreConfig: avante.Config
local opts = {
  --- --------------- model and provider ---------------
  provider = "gemini",
  gemini = {
    api_key_name = "GEMINI_KEY",
    model = GEMINI_MODEL,
  },
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    temperature = 0,
    max_tokens = 8192,
  },
  vendors = {
    groq = {
      __inherited_from = "openai",
      api_key_name = "GROQ_KEY",
      endpoint = GROQ_HOST,
      model = GROQ_MODEL,
    },
    cerebras = {
      __inherited_from = "openai",
      api_key_name = "CEREBRAS_KEY",
      endpoint = "https://api.cerebras.ai/v1/",
      model = CEREBRAS_MODEL,
      max_tokens = 16382, -- 16k tokens
    },
  },
  web_search_engine = {
    provider = "brave",
    proxy = nil,
  },
}

---@type LazyPluginState
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  enabled = false,
  version = false, -- Never set this value to "*"! Never!
  opts = opts,

  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
