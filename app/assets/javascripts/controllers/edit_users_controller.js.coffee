@baseControllers.controller "EditUsersCtrl", [
  "$scope"
  "$http"
  "$stateParams"
  "$location"
  ($scope, $http, $stateParams, $location) ->
    promise = $http.get "/api/admin/users/#{$stateParams.id}"
    promise.success (data, status, headers, config) ->
      $scope.user = data

    $scope.updateUser = ->
      promise = $http.put "/api/admin/users/#{$stateParams.id}", {"user":$scope.user}
      $location.path('/admin/users')
]
