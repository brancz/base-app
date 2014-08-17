@baseControllers.controller "UserCtrl", [
  "$scope"
  "userService"
  ($scope, userService) ->
    $scope.userService = userService
]
