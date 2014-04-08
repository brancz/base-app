@baseControllers.controller "ManageUsersCtrl", [
  "$scope"
  "$http"
  ($scope, $http) ->
    promise = $http.get '/api/admin/users'
    promise.success (data, status, headers, config) ->
      $scope.users = data
]
