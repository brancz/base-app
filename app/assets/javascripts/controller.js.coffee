@baseControllers = angular.module("baseControllers", [])
@baseControllers.controller "LoginCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "LOGIN CONTROLLER!"
]
@baseControllers.controller "HomeCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "HOME CONTROLLER!"
]
@baseControllers.controller "LogoutCtrl", [
  "$scope"
  "$http"
  ($scope, $http) ->
    $http.delete('/users').success(data) ->
      $location.path('/login')
]
