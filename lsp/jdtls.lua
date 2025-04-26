local env = {
  HOME = vim.uv.os_homedir(),
  XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
  JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
}

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or env.HOME .. '/.cache'
end

local function get_jdtls_cache_dir()
  return get_cache_dir() .. '/jdtls'
end

local function get_jdtls_config_dir()
  return get_jdtls_cache_dir() .. '/config'
end

local function get_jdtls_workspace_dir()
  return get_jdtls_cache_dir() .. '/workspace'
end

local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

local my_jars = {
  '/Users/n1v3x/hadoop-3.4.0/share/hadoop/**/*.jar',
}

---@type vim.lsp.Config
return {
  cmd = {
    'jdtls',
    '-configuration',
    get_jdtls_config_dir(),
    '-data',
    get_jdtls_workspace_dir(),
    get_jdtls_jvm_args(),
  },
  filetypes = { 'java' },
  root_markers = { '.git', 'build.gradle', 'build.gradle.kts', 'build.xml', 'pom.xml', 'settings.gradle', 'settings.gradle.kts' },
  init_options = {
    workspace = get_jdtls_workspace_dir(),
    jvm_args = {},
    os_config = nil,
  },
  settings = {
    java = {
      project = {
        referencedLibraries = my_jars,
      },
      referencesCodeLens = {
        enabled = false,
      },
      implementationsCodeLens = {
        enabled = false,
      },
    },
  },
}
