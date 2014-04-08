@baseControllers.controller "ConfirmUserCtrl", [
  "$scope"
  "userService"
  "alertService"
  "$location"
  "$http"
  ($scope, userService, alertService, $location, $http) ->
    if $location.search().confirmation_token
      promise = $http.get "/api/users/confirmation?confirmation_token=" + $location.search().confirmation_token
      promise.success () -> 
        alertService.addInfo "Your account has been successfully activated!" 
      promise.error (data) ->
        if data.confirmation_token == "is invalid"
          alertService.addError "Your account could not be activated due to an invalid token!"
        else
          alertService.addError "Your account could not be activated. Reason: Token " + data.confirmation_token

    $scope.requestConfirmationResend = ->
      promise = userService.requestConfirmationResend($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          alertService.addError "E-Mail " + data.errors.email
]
