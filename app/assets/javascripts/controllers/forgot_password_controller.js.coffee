@baseControllers.controller "ForgotPasswordCtrl", [
  "$scope"
  "userService"
  "alertService"
  ($scope, userService, alertService) ->
    $scope.requestPasswordReset = ->
      promise = userService.requestPasswordReset($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          alertService.addError "E-Mail " + data.errors.email
]
