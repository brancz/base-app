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
    $scope.isAdmin = ->
      sessionService.isAdmin()
]
