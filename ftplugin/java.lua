-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = { 'jdtls' },
  cmd_env = {
    JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
  }
}
require('jdtls').start_or_attach(config)

