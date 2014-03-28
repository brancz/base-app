@baseApp = angular.module("baseApp", [
  "ngRoute"
  "ngCookies"
  "baseControllers"
])

@baseApp.factory "httpRequestInterceptor", [
  "$cookieStore"
  "$location"
  ($cookieStore, $location) ->
    request: (config) ->
      config.headers["Authorization"] = $cookieStore.get('user_token')
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
