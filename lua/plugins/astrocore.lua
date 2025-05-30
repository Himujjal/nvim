-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local buffer_close_picker = function()
  require("astroui.status").heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start

      -- notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {

      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["}"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["{"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["zz"] = { "<cmd>:w!<cr>", desc = "Save files" },

        -- mappings seen under group name "Buffer"

        -- stylua: ignore
        ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<Leader>bD"] = { buffer_close_picker, desc = "Pick to close" },
        ["<Leader>b"] = { name = "Buffers" },

        -- stylua: ignore
        ["<Leader>nf"] = { function() require('astronvim.utils').new_file() end, desc = "New file" },

        ["<C-g>"] = { name = "Gp.nvim commands. " },
        ["<C-g><C-g>"] = { ":GpChatToggle vsplit<cr>", desc = "Toggle Chat (Normal)" },
        ["<C-g>r"] = { ":GpRewrite<cr>", desc = "Inline Assist (Rewrite)" },
        ["<C-g>R"] = { ":GpWhisperRewrite<cr>", desc = "Whisper Inline Assist" },
        ["<C-g>w"] = { ":GpWhisper<cr>", desc = "Whisper Inline Assist" },
        ["<C-g>a"] = { ":GpAppend<cr>", desc = "Append" },
        ["<C-g>A"] = { ":GpWhisperAppend<cr>", desc = "Whisper Append" },

        ["<leader>A"] = { name = "Augment commands" },
        ["<leader>AC"] = { "<cmd>Augment chat<cr>", desc = "Chat with Augment" },
        ["<leader>AN"] = { "<cmd>Augment chat-new<cr>", desc = "New Augment chat" },
        ["<leader>AT"] = { "<cmd>Augment chat-toggle<cr>", desc = "Toggle Augment chat" },

        ["<leader>aC"] = { "<cmd>AvanteClear<cr>", desc = "Clear Avante Chat Context" },

        ["<c-c>"] = { ":%y+<cr><cr>", desc = "Copy file content", silent = true }, -- copies the file contents and then returns back to the position it was in
        ["<leader>mp"] = { "<cmd>PeekOpen<cr>", desc = "Open markdown preview" },
      },
      v = {
        -- search in visual mode
        ["/"] = { [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], silent = true, desc = "Search in visual mode" },

        ["<leader>ge"] = {
          [[:<BS><BS><BS><BS><BS>ChatGPTEditWithInstructions<cr>]],
          desc = "ChatGPT Instruction for the code",
        },

        ["<C-g><C-g>"] = { ":GpChatToggle vsplit<cr>", desc = "Toggle Chat (Visual)" },
        ["<C-g>r"] = { ":GpRewrite<cr>", desc = "Inline Assist (Rewrite)" },
        ["<C-g>R"] = { ":GpWhisperRewrite<cr>", desc = "Whisper Inline Assist" },
        ["<C-g>w"] = { ":GpWhisper<cr>", desc = "Whisper Inline Assist" },
        ["<C-g>a"] = { ":GpAppend<cr>", desc = "Append" },
        ["<C-g>A"] = { ":GpWhisperAppend<cr>", desc = "Whisper Append" },

        ["<leader>AC"] = { "<cmd>Augment chat<cr>", desc = "Augment chat" },
      },
      i = {
        ["<C-g>w"] = { function() vim.cmd "GpWhisper<cr>" end, desc = "Whisper" },
        ["<C-l>"] = { "<cmd>call augment#Accept()<cr>", desc = "Accept suggestion" },
      },
    },
  },
}
