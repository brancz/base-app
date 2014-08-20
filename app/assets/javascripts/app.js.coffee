@baseApp = angular.module("baseApp", [
  "ngCookies"
  "ngAnimate"
  "ui.router"
  "chieffancypants.loadingBar"
  "baseControllers"
  "restangular"
])

@baseControllers = angular.module("baseControllers", [])

@baseApp.factory "httpRequestInterceptor", [
  "$location"
  ($location) ->
    request: (config) ->
      config
    response: (response) ->
      if response.status == 401
        $location.path('/users/sign_up')
      response
]

@baseApp.config [
  "$httpProvider",
  "$locationProvider"
  ($httpProvider, $locationProvider) ->
    $httpProvider.interceptors.push "httpRequestInterceptor"
]
