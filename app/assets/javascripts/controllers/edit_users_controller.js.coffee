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
      promise.success (data, status, headers, config) ->
        console.log "great success.."
      $location.path('/admin/users')
]
