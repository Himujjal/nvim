# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is an AstroNvim v4+ configuration that extends the base AstroNvim framework with custom plugins and AI integrations. The configuration follows AstroNvim's modular structure:

- `init.lua`: Bootstraps Lazy.nvim plugin manager and loads core configuration
- `lua/lazy_setup.lua`: Main Lazy.nvim configuration that imports AstroNvim, community plugins, and custom plugins
- `lua/community.lua`: Imports AstroCommunity plugins (colorschemes, language packs)
- `lua/plugins/`: Custom plugin configurations and overrides
- `lua/env.lua`: Environment file containing API keys for AI services (should be gitignored)

## Key AI Integrations

This configuration includes multiple AI tools for different use cases:

1. **gp.nvim** (`lua/plugins/gpnvim.lua`): Primary AI chat interface using Cerebras, Groq, SambaNova, and OpenAI providers
2. **Avante** (`lua/plugins/avante_conf.lua`): AI coding assistant (currently disabled) with Gemini, Claude, Groq, and Cerebras support
3. **Augment Code** (`lua/plugins/user.lua`): Code review tool with configurable workspace folders
4. **Claude Code** (`lua/plugins/user.lua`): This tool's Neovim integration with vertical window positioning

## Environment Configuration

The `lua/env.lua` file contains API keys and configuration for various AI services. This file should not be committed to version control and contains sensitive credentials for:
- OpenAI, Groq, Gemini, Anthropic, Cerebras, Brave API keys
- Augment workspace folder paths

## Plugin Management

- Uses Lazy.nvim as plugin manager
- AstroNvim provides the base framework
- Custom plugins are defined in `lua/plugins/` directory
- Community plugins imported through AstroCommunity

## Common Commands

Since this is a Neovim configuration, testing and building are handled through Neovim itself:

- Start Neovim: `nvim`
- Plugin management: `:Lazy` (sync, install, update plugins)
- AI chat: `:GpChat` (via gp.nvim)
- Code review: `:Augment` commands
- Toggle Claude Code: `<C-,>` keybinding

## Key Files to Modify

- `lua/plugins/user.lua`: Main custom plugin configurations
- `lua/plugins/gpnvim.lua`: AI chat provider configurations
- `lua/plugins/avante_conf.lua`: Avante AI assistant settings
- `lua/env.lua`: API keys and environment variables (keep secure)