@baseApp = angular.module("baseApp", [
  "ngCookies"
  "ngAnimate"
  "ui.router"
  "baseControllers"
])

@baseControllers = angular.module("baseControllers", [])

@baseApp.run [
  "$templateCache"
  "$http"
  ($templateCache, $http) ->
    $http.get "/templates/users/sign_in.html",
      cache: $templateCache

]

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
