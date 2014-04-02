@baseControllers.controller "LoginCtrl", [
  "$scope"
  "userService"
  ($scope, userService) ->
    $scope.userService = userService
    $scope.signin = ->
      promise = userService.signin($scope.login)
      promise.error (data, status, headers, config) ->
        if data.error
          $scope.error = data.error
          $scope.error_occured = true
    $scope.signout = ->
      userService.signout()
    $scope.isAdmin = ->
      userService.isAdmin()
]
