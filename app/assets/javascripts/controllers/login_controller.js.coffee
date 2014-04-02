@baseControllers.controller "LoginCtrl", [
  "$scope"
  "userService"
  "alertService"
  ($scope, userService, alertService) ->
    $scope.userService = userService
    $scope.signin = ->
      promise = userService.signin($scope.login)
      promise.error (data, status, headers, config) ->
        if data.error
          alertService.errors.push data.error
    $scope.signout = ->
      userService.signout()
    $scope.isAdmin = ->
      userService.isAdmin()
]
