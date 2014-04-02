@baseApp = angular.module("baseApp", [
  "ngRoute"
  "ngCookies"
  "baseControllers"
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
  "$httpProvider"
  ($httpProvider) ->
    $httpProvider.interceptors.push "httpRequestInterceptor"
]
