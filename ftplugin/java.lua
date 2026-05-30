local jdtls = require 'jdtls'

-- Find the project root
local root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', '.git' }) or vim.fn.getcwd()

-- Workspace directory per project (jdtls needs a unique workspace per project)
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls/workspace/' .. project_name

-- Find the jdtls binary installed by Mason
local jdtls_bin = vim.fn.stdpath 'data' .. '/mason/bin/jdtls'

-- jdtls requires Java 21+ to run (your project can still target older Java)
local java21_home = vim.fn.expand '$HOME/.sdkman/candidates/java/21.0.6-amzn'
if vim.fn.isdirectory(java21_home) == 0 then
  -- Try any 21.x version installed via sdkman
  local glob = vim.fn.glob(vim.fn.expand '$HOME/.sdkman/candidates/java/21.*', false, true)
  if #glob > 0 then
    java21_home = glob[1]
  else
    vim.notify('jdtls requires Java 21+. Install via: sdk install java 21.0.6-amzn', vim.log.levels.WARN)
    return
  end
end

local config = {
  cmd = {
    jdtls_bin,
    '--java-executable',
    java21_home .. '/bin/java',
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.Assume.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.junit.jupiter.api.Assumptions.*',
          'org.junit.jupiter.api.DynamicContainer.*',
          'org.junit.jupiter.api.DynamicTest.*',
          'org.mockito.Mockito.*',
          'org.mockito.ArgumentMatchers.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
}

jdtls.start_or_attach(config)
