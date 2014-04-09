@baseControllers.controller "ShowUsersCtrl", [
  "$scope"
  "$http"
  "$stateParams"
  "$location"
  ($scope, $http, $stateParams, $location) ->
    promise = $http.get "/api/admin/users/#{$stateParams.id}"
    promise.success (data, status, headers, config) ->
      $scope.user = data
]
