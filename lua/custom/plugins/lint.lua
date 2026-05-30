-- Extend nvim-lint with eslint_d for JS/TS projects and gherkin-lint for .feature files
-- (kickstart.plugins.lint handles the plugin setup + markdownlint)
return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft['javascript'] = { 'eslint_d' }
    lint.linters_by_ft['javascriptreact'] = { 'eslint_d' }
    lint.linters_by_ft['typescript'] = { 'eslint_d' }
    lint.linters_by_ft['typescriptreact'] = { 'eslint_d' }
    lint.linters_by_ft['cucumber'] = { 'gherkin_lint' }
    lint.linters_by_ft['swift'] = { 'swiftlint' }
    lint.linters_by_ft['make'] = { 'checkmake' }

    -- gherkin-lint: use project-local binary via npx
    lint.linters.gherkin_lint = {
      cmd = 'npx',
      args = { 'gherkin-lint', '-f', 'json' },
      stdin = false,
      append_fname = true,
      stream = 'stdout',
      parser = function(output)
        if output == '' then return {} end
        local ok, results = pcall(vim.json.decode, output)
        if not ok or not results then return {} end
        local diagnostics = {}
        for _, file_result in ipairs(results) do
          for _, err in ipairs(file_result.errors or {}) do
            table.insert(diagnostics, {
              lnum = (err.line or 1) - 1,
              col = 0,
              message = err.message,
              severity = err.rule and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
              source = 'gherkin-lint',
            })
          end
        end
        return diagnostics
      end,
    }
  end,
}
