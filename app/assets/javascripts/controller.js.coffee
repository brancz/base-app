@baseControllers = angular.module("baseControllers", [])
@baseControllers.controller "LoginCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.logMeIn = ->
      sessionService.logMeIn($scope.login)
    $scope.message = "LOGIN CONTROLLER!"
]
@baseControllers.controller "HomeCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "HOME CONTROLLER!"
]
@baseControllers.controller "SecretCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "SECRET CONTROLLER!"
]
@baseControllers.controller "MainCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.logMeOut = ->
      sessionService.logout()
    $scope.logMeIn = ->
      sessionService.logMeIn($scope.login)
]
