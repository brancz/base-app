baseControllers = angular.module("baseControllers", [])
baseControllers.controller "LoginCtrl", [
  "$scope"
  "$http"
]
baseControllers.controller "HomeCtrl", [
  "$scope"
  "$routeParams"
]
