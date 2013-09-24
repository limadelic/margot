angular
  .module('status', [])
  .controller('Servers', function ($scope) {
    $scope.servers = servers;
  })
  .filter('status_style', function(){
    return function(is_done) {
      return is_done ? 'success' : 'default'
    }
  });
