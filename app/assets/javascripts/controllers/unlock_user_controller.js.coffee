@baseControllers.controller "UnlockUserCtrl", [
  "$scope"
  "userService"
  "alertService"
  "$routeParams"
  "$http"
  ($scope, userService, alertService, $routeParams, $http) ->
    if typeof $routeParams.unlock_token != "undefined"
      promise = $http.get "/api/users/unlock?unlock_token=" + $routeParams.unlock_token
      promise.success () -> 
        alertService.addInfo "Your account has been successfully unlocked!" 
      promise.error () ->
        alertService.addError "Your account could not be unlocked due to an invalid token!"

    $scope.requestUnlockResend = ->
      promise = userService.requestUnlockResend $scope.login.user_email
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          alertService.addError "E-Mail " + data.errors.email 

]