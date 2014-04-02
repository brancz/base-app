@baseControllers.controller "UserAccountCtrl", [
  "$scope"
  "sessionService"
  "$location"
  ($scope, sessionService, $location) ->
    $scope.deleteAccount = ->
      $('#deleteModal').modal('hide')
      promise = sessionService.deleteAccount()
      promise.success (data, status, headers, config) ->
        sessionService.signedIn = false
        sessionService.id = null
        sessionService.email = null
        $location.path('/users/sign_in')
    $scope.includeMainProfile = ->
      $scope.template_url = '/templates/users/profile/main.html'
      $scope.mainActive = true
    $scope.template_url = '/templates/users/profile/main.html'
    $scope.mainActive = true
]
