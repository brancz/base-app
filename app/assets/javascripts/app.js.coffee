@baseApp = angular.module("baseApp", [
  "ngRoute"
  "baseControllers"
])

@baseApp.factory "sessionService", ($http, $location) ->
  logMeIn: (login) ->
    promise = $http.post('/api/session', login)
    promise.success (data, status, headers, config) ->
      localStorage.setItem('user_token', data.user_token)
      $location.path('/secret')
    return

  logMeOut: ->
    promise = $http.delete('/api/session')
    promise.success(data, status, headers, config) ->
      $location.path('/login')
    return

@baseApp.config [
  "$routeProvider"
  ($routeProvider) ->
    $routeProvider.when("/login",
      templateUrl: "/templates/login.html"
      controller: "LoginCtrl"
    ).when("/",
      templateUrl: "/templates/index.html"
      controller: "HomeCtrl"
    ).when("/secret",
      templateUrl: "/templates/secret.html"
      controller: "SecretCtrl"
    ).otherwise redirectTo: "/login"
]

@baseApp.factory "httpRequestInterceptor", () ->
  request: (config) ->
    config.headers["Authorization"] = localStorage.getItem('user_token')
    config

@baseApp.config ($httpProvider) ->
  $httpProvider.interceptors.push "httpRequestInterceptor"
  return
