@baseControllers.controller "ShowUsersCtrl", [
  "$scope"
  "$http"
  "$stateParams"
  "$location"
  ($scope, $http, $stateParams, $location) ->
    promise = $http.get "/api/admin/users/#{$stateParams.id}"
    promise.success (data, status, headers, config) ->
      $scope.user = data
    $scope.deleteUser = ->
      promise = $http.delete "/api/admin/users/#{$stateParams.id}"
      promise.success (data, status, headers, config) ->
        $('#deleteModal').modal('hide')
        $location.path "/admin/users"
]
