@baseApp = angular.module("baseApp", [
  "ngRoute"
  "ngCookies"
  "baseControllers"
])

@baseApp.factory "sessionService", ($cookieStore, $http, $location) ->
  wrappedService =
    logMeIn: (login) ->
      promise = $http.post('/api/session', login)
      promise.success (data, status, headers, config) ->
        $cookieStore.put('user_token', data.user_token)
        wrappedService.email = login.user_email
        wrappedService.loggedIn = true
        console.debug wrappedService
        $location.path('/secret')
      return

    getUserInfo: ->
      promise = $http.get('/api/users/myself')
      promise.success (data, status, headers, config) ->
        wrappedService.email = data.email
        wrappedService.loggedIn = true
      return

    logMeOut: ->
      promise = $http.delete('/api/session')
      promise.success (data, status, headers, config) ->
        $cookieStore.remove('user_token')
        wrappedService.loggedIn = false
        $location.path('/login')
      return

    email: null
    loggedIn: null
  wrappedService

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

@baseApp.factory "httpRequestInterceptor", ($cookieStore, $location) ->
  request: (config) ->
    config.headers["Authorization"] = $cookieStore.get('user_token')
    config
  response: (response) ->
    if response.status == 401
      $location.path('/login')
    response

@baseApp.config ($httpProvider) ->
  $httpProvider.interceptors.push "httpRequestInterceptor"
