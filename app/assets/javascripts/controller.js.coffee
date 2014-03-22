@baseControllers = angular.module("baseControllers", [])
@baseControllers.controller "LoginCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.sService = sessionService
    $scope.signin = ->
      promise = sessionService.signin($scope.login)
      promise.error (data, status, headers, config) ->
        if data.error
          $scope.error = data.error
          $scope.error_occured = true
    $scope.signout = ->
      sessionService.signout()
    $scope.getUserInfo = ->
      sessionService.heartbeat()
]
@baseControllers.controller "SignUpCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.signup = ->
      promise = sessionService.signup($scope.login.user_email, $scope.login.user_password)
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "ForgotPasswordCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.requestPasswordReset = ->
      promise = sessionService.requestPasswordReset($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "ConfirmUserCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.requestConfirmationResend = ->
      promise = sessionService.requestConfirmationResend($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "UnlockUserCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.requestUnlockResend = ->
      promise = sessionService.requestUnlockResend($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
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
