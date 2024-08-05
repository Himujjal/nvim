local env = require "env"

local API_KEY = env.OPENAI_KEY
local MODEL = "gpt-3.5-turbo"
local API_HOST = "https://api.openai.com"

-- Calling this function is more than enough to enable Groq
local enableGroq = function()
  API_HOST = "https://api.groq.com/openai"
  API_KEY = env.GROQ_KEY
  MODEL = "llama3-8b-8192"
  -- MODEL = "mixtral-8x7b-32768"
end

return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    -- enableGroq() -- comment/uncomment this line to use Groq

    vim.env.OPENAI_API_KEY = API_KEY
    vim.env.OPENAI_API_HOST = API_HOST

    require("chatgpt").setup {
      keymaps = {
        close = "q",
        delete_session = "<leader>dd",
      },
      api_key_cmd = "echo $OPENAI_API_KEY",
      openai_params = {
        model = MODEL,
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = MODEL,
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    }
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
