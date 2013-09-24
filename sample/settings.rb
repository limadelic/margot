run 'cidev333',
  steps: [
    'include_recipe',
    'core_wait_for',
    'core_set'
  ],
  cookbooks: '../../work/current/Infrastructure/cookbooks',
  logs: '../../temp/results',
  nodes: {
    application: 'app',
    client: 'cli',
    company: 'co',
    dpm: 'dpm',
    hub_external: 'hx',
    hub_internal: 'hi',
    site: 'site',
    supersite: 'ss',
    web: 'web'
  }
