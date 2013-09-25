angular
  .module('status', [])
  .controller('Servers', function ($scope) {
    $scope.servers = servers;
  })
  .filter('step_style', function(){

    var default_style = {
      done: 'success',
      pending: 'default',
      skipped: 'default',
      current: 'success striped active'
    };

    var styles = {
      core_wait_for: {
        done: 'warning',
        pending: 'default',
        skipped: 'default',
        current: 'warning striped active'
      },
      include_recipe: default_style,
      core_set: default_style
    };

    return function(step) {
      return styles[step.step][step.status];
    }
  });
