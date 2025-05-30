local env = require "env"

local OPENAI_KEY = env.OPENAI_KEY
local OPENAI_HOST = "https://api.openai.com/v1/chat/completions"

local GROQ_KEY = env.GROQ_KEY
local GROQ_HOST = "https://api.groq.com/openai/v1/chat/completions"

local GROQ_MODEL = "llama-3.2-11b-text-preview"
-- local GROQ_MODEL = "deepseek-r1-distill-llama-70b"
local GROQ_AUDIO = "https://api.groq.com/openai/v1/audio/transcriptions"
local GROQ_WHISPER_MODEL = "distil-whisper-large-v3-en"

local SAMBANOVA_KEY = env.SAMBANOVA_KEY
local SAMBANOVA_HOST = "https://api.sambanova.ai/v1/chat/completions"
local SMABANOVAL_MODEL = "Meta-Llama-3.2-3B-Instruct"

local CEREBRAS_KEY = env.CEREBRAS_KEY
local CEREBRAS_HOST = "https://api.cerebras.ai/v1/chat/completions"
-- local CEREBRAS_MODEL = "qwen-3-32b"
local CEREBRAS_MODEL = "llama-4-scout-17b-16e-instruct"

-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.nvim/

--------------------------------------------------------------------------------
-- Default config
--------------------------------------------------------------------------------
---@class GpConfig
-- README_REFERENCE_MARKER_START
local config = {
  default_chat_agent = CEREBRAS_MODEL,

  providers = {
    openai = {
      endpoint = OPENAI_HOST,
      secret = OPENAI_KEY,
    },
    groq = {
      endpoint = GROQ_HOST,
      secret = GROQ_KEY,
    },
    sambanova = {
      endpoint = SAMBANOVA_HOST,
      secret = SAMBANOVA_KEY,
    },
    cerebras = {
      endpoint = CEREBRAS_HOST,
      secret = CEREBRAS_KEY,
    },
  },

  chat_shortcut_respond = { modes = { "n", "v", "x" }, shortcut = "<CR>" },
  chat_confirm_delete = false,

  -- prefix for all commands
  cmd_prefix = "Gp",

  whisper = {
    endpoint = GROQ_AUDIO,
    secret = GROQ_KEY,
    model = GROQ_WHISPER_MODEL,
    store_dir = "/tmp/gp_whisper",
  },

  agents = {
    {
      provider = "cerebras",
      name = "Cerebras",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = CEREBRAS_MODEL, temperature = 0.2, top_p = 1 },
      system_prompt = "Given a task or problem, please provide a concise and well-formatted solution or answer.\n\n",
    },
    {
      provider = "groq",
      name = "DeepSeek-R1-OSS",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = GROQ_MODEL, temperature = 0.2, top_p = 1 },
      system_prompt = "Given a task or problem, please provide a concise and well-formatted solution or answer.\n\n"
        .. "Please keep your response within a code snippet, and avoid unnecessary commentary.\n",
    },
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
    -- {
    --   provider = "groq",
    --   name = "GroqLLAMA_8B",
    --   chat = true,
    --   command = true,
    --   -- string with model name or table with model name and parameters
    --   model = { model = "llama-3.1-70b-versatile", temperature = 0.8, top_p = 1 },
    --   system_prompt = "You are an AI helping the user with code and other tasks\n\n"
    --     .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n",
    -- },
    {
      provider = "sambanova",
      name = "Sambanova_90B",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = SMABANOVAL_MODEL, temperature = 0.5, top_p = 1 },
      system_prompt = "Given a task or problem, please provide a concise and well-formatted solution or answer.\n\n"
        .. "Please keep your response within a code snippet, and avoid unnecessary commentary.\n",
    },
  },
}

--
return {
  "Himujjal/gp.nvim",
  event = "BufEnter",
  config = function() require("gp").setup(config) end,
}
