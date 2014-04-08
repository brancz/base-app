@baseControllers.controller "UnlockUserCtrl", [
  "$scope"
  "userService"
  "alertService"
  "$location"
  "$http"
  ($scope, userService, alertService, $location, $http) ->
    if $location.search().unlock_token
      promise = $http.get "/api/users/unlock?unlock_token=" + $location.search().unlock_token
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