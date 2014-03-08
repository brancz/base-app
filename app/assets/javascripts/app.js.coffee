@baseApp = angular.module("baseApp", [
  "ngRoute"
  "baseControllers"
])

@baseApp.config [
  "$routeProvider"
  ($routeProvider) ->
    $routeProvider.when("/login",
      templateUrl: "/templates/login"
      controller: "LoginCtrl"
    ).when("/",
      templateUrl: "/templates/index"
      controller: "HomeCtrl"
    ).otherwise redirectTo: "/login"
]
