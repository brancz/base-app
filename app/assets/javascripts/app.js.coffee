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
    ).when("/logout",
      controller: "LogoutCtrl"
    ).when("/",
      templateUrl: "/templates/index"
      controller: "HomeCtrl"
    ).otherwise redirectTo: "/login"
]
@baseApp.factory "httpRequestInterceptor", () ->
  request: (config) ->
    config.headers["Authorization"] = "test"
    config

@baseApp.config ($httpProvider) ->
  $httpProvider.interceptors.push "httpRequestInterceptor"
  return

