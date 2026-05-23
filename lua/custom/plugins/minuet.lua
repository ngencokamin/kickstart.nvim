return {
  'milanglacier/minuet-ai.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'InsertEnter',
  opts = {
    provider = 'openai_compatible',
    provider_options = {
      openai_compatible = {
        api_key = 'ANTHROPIC_AUTH_TOKEN', -- minuet reads this as os.getenv('ANTHROPIC_AUTH_TOKEN')
        end_point = 'https://llm.test.linearft.com/v1/chat/completions',
        model = 'bedrock-claude-sonnet-4-6',
        name = 'LiteLLM Claude',
        optional = {
          max_tokens = 256,
          top_p = 0.9,
        },
      },
    },

    -- Ghost text (virtual text) frontend
    virtualtext = {
      auto_trigger_ft = { '*' }, -- enable for all filetypes
      keymap = {
        -- <Tab> is handled via blink.cmp keymap override to avoid blink consuming it first
        accept_line = '<A-a>', -- accept one line
        prev = '<A-[>',
        next = '<A-]>',
        dismiss = '<A-e>',
      },
    },
  },
}
