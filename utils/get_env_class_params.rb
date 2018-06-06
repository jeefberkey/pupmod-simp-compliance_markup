require 'puppet_pal'
require 'pry'

conf_root = File.expand_path('~/.puppetlabs')
Puppet.settings.parse_config(<<-CONF)
    codedir = #{conf_root}/etc/code
    confdir = #{conf_root}/etc/puppet
    logdir = #{conf_root}/var/log
    statedir = #{conf_root}/opt/puppet/cache/state
    vardir = #{conf_root}/opt/puppet/cache
    rundir = #{conf_root}/var/run
  CONF

pal_conf = {
  modulepath: ['/var/nmillerl/simpdev/simp-core/src/puppet/modules'],
  facts: {},
}
result = Puppet::Pal.in_tmp_environment('pal_env', pal_conf) do |pal|
  # pal.evaluate_script_string('1+2+3')
  c = pal.with_script_compiler do |compiler|
    binding.pry
    compiler.evaluate_string(<<-CODE)
      1+2+3
      CODE
    end
  binding.pry
  puts c
end

binding.pry
puts result
# Puppet.parse_config
#
# resources = Puppet::Face[:resource_type, :current] \
#   .search(filter,
#     { extra:
#       { 'environment' => opts[:environment] }
#     }
#   )
#
# data = {}
# resources.each do |resource|
#   data[resource.name] = resource.arguments
# end
# puts data.to_json
