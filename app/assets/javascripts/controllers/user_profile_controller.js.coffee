@baseControllers.controller "UserProfileCtrl", [
  "$scope"
  "$location"
  "userService"
  "alertService"
  ($scope, $location, userService, alertService) ->
    promise = userService.getUserData()
    promise.success (data, status, headers, config) ->
      if userService.signedIn
        $scope.email = userService.email
      else
        $location.path('/users/sign_in')
    $scope.updateProfile = ->
      promise = userService.updateProfile($scope.email, $scope.password, $scope.password_confirmation, $scope.current_password)
      promise.success (data, status, headers, config) ->
        alertService.addInfo "An email has been send to #{$scope.email}, to verify it belongs to you."
        $scope.password = ''
        $scope.password_confirmation = ''
        $scope.current_password = ''
      promise.error (data, status, headers, config) ->
        $scope.all_errors = data.errors
]
