@baseControllers.controller "UserAccountCtrl", [
  "$scope"
  "userService"
  "$location"
  ($scope, userService, $location) ->
    $scope.deleteAccount = ->
      $('#deleteModal').modal('hide')
      promise = userService.deleteAccount()
      promise.success (data, status, headers, config) ->
        userService.signedIn = false
        userService.id = null
        userService.email = null
        $location.path('/users/sign_in')
    $scope.includeMainProfile = ->
      $scope.template_url = '/templates/users/profile/main.html'
      $scope.mainActive = true
    $scope.template_url = '/templates/users/profile/main.html'
    $scope.mainActive = true
]
