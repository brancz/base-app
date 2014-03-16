@baseApp = angular.module("baseApp", [
  "ngRoute"
  "ngCookies"
  "baseControllers"
])

@baseApp.factory "sessionService", ($cookieStore, $http, $location) ->
  logMeIn: (login) ->
    promise = $http.post('/api/session', login)
    promise.success (data, status, headers, config) ->
      $cookieStore.put('user_token', data.user_token)
      $location.path('/secret')
    return

  logMeOut: ->
    promise = $http.delete('/api/session')
    promise.success(data, status, headers, config) ->
      $cookieStore.remove('user_token')
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

@baseApp.factory "httpRequestInterceptor", ($cookieStore) ->
  request: (config) ->
    config.headers["Authorization"] = $cookieStore.get('user_token')
    config

@baseApp.config ($httpProvider) ->
  $httpProvider.interceptors.push "httpRequestInterceptor"
