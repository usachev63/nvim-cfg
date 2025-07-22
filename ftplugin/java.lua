local home_dir = os.getenv('HOME')

local function is_file_exist(path)
  local f = io.open(path, 'r')
  return f ~= nil and io.close(f)
end

local function get_lombok_javaagent()
  local lombok_dir = home_dir .. '/.m2/repository/org/projectlombok/lombok/'
  local lombok_versions = io.popen('ls -1 "' .. lombok_dir .. '" | sort -r')
  if lombok_versions ~= nil then
    local lb_i, lb_versions = 0, {}
    for lb_version in lombok_versions:lines() do
      lb_i = lb_i + 1
      lb_versions[lb_i] = lb_version
    end
    lombok_versions:close()
    if next(lb_versions) ~= nil then
      local lombok_jar = vim.fn.expand(string.format('%s%s/*.jar', lombok_dir, lb_versions[1]))
      if is_file_exist(lombok_jar) then
        return string.format('--jvm-arg=-javaagent:%s', lombok_jar)
      end
    end
  end
  return ''
end

local function get_cmd()
  local cmd = { 'jdtls' }
  local lombok_javaagent = get_lombok_javaagent()
  if lombok_javaagent ~= nil then
    table.insert(cmd, lombok_javaagent)
  end
  return cmd
end

local config = {
  cmd = get_cmd(),
  cmd_env = {
    JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
  }
}
require('jdtls').start_or_attach(config)
