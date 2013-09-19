NODES = [
  'include_recipe',
  'core_wait_for'
]

def node
{
  servers: {
    hub_internal: 'hub_internal',
    hub_external: 'hub_internal'
  }
}
end
