run steps: [
    'include_recipe',
    'core_wait_for',
    'core_set'
  ],
  cookbooks: '../../work/current/Infrastructure/cookbooks',
  nodes: [
    :application,
    :client,
    :company,
    :dpm,
    :hub_external,
    :hub_internal,
    :site,
    :supersite,
    :web
  ]
