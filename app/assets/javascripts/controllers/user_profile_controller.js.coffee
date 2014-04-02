@baseControllers.controller "UserProfileCtrl", [
  "$scope"
  "sessionService"
  "$location"
  ($scope, sessionService, $location) ->
    promise = sessionService.getUserData()
    promise.success (data, status, headers, config) ->
      if sessionService.signedIn
        $scope.email = sessionService.email
      else
        $location.path('/users/sign_in')
    $scope.updateProfile = ->
      promise = sessionService.updateProfile($scope.email, $scope.password, $scope.password_confirmation, $scope.current_password)
      promise.success (data, status, headers, config) ->
        $scope.infos = []
        $scope.infos.push "An email has been send to #{$scope.email}, to verify it belongs to you."
        $scope.password = ''
        $scope.password_confirmation = ''
        $scope.current_password = ''
      promise.error (data, status, headers, config) ->
        $scope.all_errors = data.errors
]
