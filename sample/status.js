angular
  .module('status', [])
  .controller('Servers', function ($scope) {
    $scope.servers = servers;
  })
  .filter('step_style', function () {

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

    return function (step) {
      return styles[step.type][step.status];
    }
  })
  .filter('step_type', function () {
    return function (type) {
      var tokens = type.split('_');
      tokens.shift();
      return tokens.join(' ');
    }
  })
  .filter('step_type_icon', function () {
    var icons = {
      include_recipe: 'wrench',
      core_wait_for: 'time',
      core_set: 'cog'
    };

    return function (type) {
      return icons[type];
    }
  })
  .filter('step_name', function () {
    return function (name) {
      return name.replace(/\_/g,' ');
    }
  });
