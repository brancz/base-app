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
