@baseApp = angular.module("baseApp", [
  "ngRoute"
  "ngCookies"
  "ngAnimate"
  "baseControllers"
])

@baseControllers = angular.module("baseControllers", [])

@baseApp.run ($templateCache, $http) ->
  $http.get "/templates/users/sign_in.html",
    cache: $templateCache

  return

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
