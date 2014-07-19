@baseControllers.controller "SignUpCtrl", [
  "$scope"
  "userService"
  ($scope, userService) ->
    $scope.signup = ->
      promise = userService.signup($scope.login.user_email, $scope.login.user_password)
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
