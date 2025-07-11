local env = require "env"

local GROQ_API_KEY = env.GROQ_KEY

---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  opts = {
    sources = {
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
    },
    adapters = {
      groq = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = GROQ_API_KEY,
            -- url = "https://api.groq.com/openai",
            -- chat_url = "/v1/chat/completions",
            -- models_endpoint = "/v1/models",
          },
          name = "Groq",
          url = "https://api.groq.com/openai/v1/chat/completions",
          schema = {
            model = {
              default = "qwen/qwen3-32b",
              choices = {
                "meta-llama/llama-4-maverick-17b-128e-instruct",
                "qwen/qwen3-32b",
                "llama-3.1-8b-instant",
                "llama-3.3-70b-versatile",
              },
            },
          },
          max_tokens = {
            default = 4096,
          },
          temperature = {
            default = 1,
          },
          handlers = {
            form_messages = function(_self, messages)
              for _, msg in ipairs(messages) do
                -- Remove 'id' and 'opts' properties from all messages
                msg.id = nil
                msg.opts = nil

                -- Ensure 'name' is a string if present, otherwise remove it
                if msg.name then
                  msg.name = tostring(msg.name)
                else
                  msg.name = nil
                end

                -- Ensure only supported properties are present
                local supported_props = { role = true, content = true, name = true }
                for prop in pairs(msg) do
                  if not supported_props[prop] then msg[prop] = nil end
                end
              end
              return { messages = messages }
            end,
          },
        })
      end,
    },
    strategies = {
      --NOTE: Change the adapter as required
      chat = { adapter = "groq" },
      inline = { adapter = "groq" },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
