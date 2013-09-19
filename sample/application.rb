include_recipe 'windows::reboot_handler'
include_recipe 'ultimate_windows::enable_static_ip'
include_recipe 'ultipro'

core_wait_for node[:servers][:hub_internal]
core_wait_for node[:servers][:hub_external]

include_recipe 'ultipro::features'

include_recipe 'tests'
include_recipe 'core::cleanup'