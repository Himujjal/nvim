local env = require "env"

local API_KEY = env.OPENAI_KEY
local GROQ_KEY = env.GROQ_KEY
local API_HOST = "https://api.openai.com/v1/chat/completions"
local GROQ_HOST = "https://api.groq.com/openai/v1/chat/completions"

-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.nvim/

--------------------------------------------------------------------------------
-- Default config
--------------------------------------------------------------------------------

-- README_REFERENCE_MARKER_START
local config = {
  providers = {
    openai = {
      disable = false,
      endpoint = API_HOST,
      secret = API_KEY,
    },
    groq = {
      disable = false,
      endpoint = GROQ_HOST,
      secret = GROQ_KEY,
    },
  },

  -- prefix for all commands
  cmd_prefix = "Gp",
  agents = {
    {
      provider = "openai",
      name = "ChatGPT4o",
      chat = false,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
        .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
        .. "START AND END YOUR ANSWER WITH:\n\n```",
    },
    {
      provider = "openai",
      name = "ChatGPT4o-mini",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "gpt-4o-mini", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = "You are an AI working as a code editor.\n\n"
        .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
        .. "START AND END YOUR ANSWER WITH:\n\n```",
    },
    {
      provider = "groq",
      name = "GroqLLAMA_8B",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "llama-3.1-70b-versatile", temperature = 0.8, top_p = 1 },
      system_prompt = "You are an AI helping the user with code and other tasks\n\n"
        .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n",
    },
  },

  default_chat_agent = "ChatGPT4o",
}

return {
  "robitx/gp.nvim",
  event = "BufEnter",
  config = function() require("gp").setup(config) end,
}
