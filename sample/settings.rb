STEPS = [
  'include_recipe',
  'core_wait_for'
]

NODE = {
  servers: {
    hub_internal: 'hub_internal',
    hub_external: 'hub_internal'
  }
}

SERVERS = {
  app: '../sample/application'
}
