angular
  .module('status', [])
  .controller('Servers', function ($scope) {
    $scope.servers = servers;
  })
  .filter('status_style', function(){

    var styles = {
      done: 'success',
      pending: 'default',
      skipped: 'warning',
      current: 'success striped active'
    };

    return function(status) {
      return styles[status];
    }
  });
