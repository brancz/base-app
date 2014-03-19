@baseControllers = angular.module("baseControllers", [])
@baseControllers.controller "LoginCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.sService = sessionService
    $scope.logMeIn = ->
      sessionService.logMeIn($scope.login)
    $scope.logMeOut = ->
      sessionService.logMeOut()
    $scope.getUserInfo = ->
      sessionService.heartbeat()
]
@baseControllers.controller "SignUpCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "SIGNUP CONTROLLER!"
]
@baseControllers.controller "ForgotPasswordCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "FORGOT PASSWORD CONTROLLER!"
]
@baseControllers.controller "ConfirmUserCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "CONFIRM USER CONTROLLER!"
]
@baseControllers.controller "UnlockUserCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "UNLOCK USER CONTROLLER!"
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
