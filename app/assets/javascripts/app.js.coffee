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
        $location.path('/secret')
      return

    heartbeat: ->
      promise = $http.get('/api/session/heartbeat')
      promise.success (data, status, headers, config) ->
        if data.session_alive
          inner_promise = $http.get('/api/users/myself')
          inner_promise.success (data, status, headers, config) ->
            wrappedService.email = data.email
            wrappedService.loggedIn = true
      return

    logMeOut: ->
      promise = $http.delete('/api/session')
      promise.success (data, status, headers, config) ->
        $cookieStore.remove('user_token')
        wrappedService.loggedIn = false
        $location.path('/users/sign_up')
      return

    email: null
    loggedIn: null
  wrappedService

@baseApp.config [
  "$routeProvider"
  ($routeProvider) ->
    $routeProvider.when("/users/sign_in",
      templateUrl: "/templates/sign_in.html"
      controller: "LoginCtrl"
    ).when("/users/sign_up",
      templateUrl: "/templates/sign_up.html"
      controller: "SignUpCtrl"
    ).when("/users/forgot_password",
      templateUrl: "/templates/forgot_password.html"
      controller: "ForgotPasswordCtrl"
    ).when("/users/confirmation",
      templateUrl: "/templates/confirm.html"
      controller: "ConfirmUserCtrl"
    ).when("/users/unlock",
      templateUrl: "/templates/unlock.html"
      controller: "UnlockUserCtrl"
    ).when("/",
      templateUrl: "/templates/index.html"
      controller: "HomeCtrl"
    ).when("/secret",
      templateUrl: "/templates/secret.html"
      controller: "SecretCtrl"
    ).otherwise redirectTo: "/users/sign_in"
]

@baseApp.factory "httpRequestInterceptor", ($cookieStore, $location) ->
  request: (config) ->
    config.headers["Authorization"] = $cookieStore.get('user_token')
    config
  response: (response) ->
    if response.status == 401
      $location.path('/users/sign_up')
    response

@baseApp.config ($httpProvider) ->
  $httpProvider.interceptors.push "httpRequestInterceptor"
