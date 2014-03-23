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
@baseControllers.controller "UserProfileCtrl", [
  "$scope"
  "$routeParams"
  "sessionService"
  "$location"
  ($scope, $routeParams, sessionService, $location) ->
    promise = sessionService.heartbeat()
    promise.success (data, status, headers, config) ->
      if sessionService.signedIn
        $scope.email = sessionService.email
      else
        $location.path('/users/sign_in')
    $scope.updateProfile = ->
      promise = sessionService.updateProfile($scope.email, $scope.current_password)
      promise.success (data, status, headers, config) ->
        $scope.infos = []
        $scope.infos.push "An email has been send to #{$scope.email}, to verify it belongs to you."
        $scope.current_password = ''
      promise.error (data, status, headers, config) ->
        $scope.all_errors = data.errors
    $scope.deleteAccount = ->
      $('#deleteModal').modal('hide')
      promise = sessionService.deleteAccount()
      promise.success (data, status, headers, config) ->
        sessionService.signedIn = null
        sessionService.id = null
        sessionService.email = null
        $location.path('/users/sign_in')
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
