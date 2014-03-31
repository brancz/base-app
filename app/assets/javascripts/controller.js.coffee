@baseControllers = angular.module("baseControllers", [])
@baseControllers.controller "LoginCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.sService = sessionService
    $scope.signin = ->
      promise = sessionService.signin($scope.login)
      promise.error (data, status, headers, config) ->
        if data.error
          $scope.error = data.error
          $scope.error_occured = true
    $scope.signout = ->
      sessionService.signout()
    $scope.isAdmin = ->
      sessionService.isAdmin()
]
@baseControllers.controller "SignUpCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.signup = ->
      promise = sessionService.signup($scope.login.user_email, $scope.login.user_password)
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "ForgotPasswordCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.requestPasswordReset = ->
      promise = sessionService.requestPasswordReset($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "ConfirmUserCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.requestConfirmationResend = ->
      promise = sessionService.requestConfirmationResend($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "UnlockUserCtrl", [
  "$scope"
  "sessionService"
  ($scope, sessionService) ->
    $scope.requestUnlockResend = ->
      promise = sessionService.requestUnlockResend($scope.login.user_email)
      promise.success (data, status, headers, config) ->
        $scope.success = true
      promise.error (data, status, headers, config) ->
        if data.errors
          $scope.all_errors = data.errors
]
@baseControllers.controller "UserProfileCtrl", [
  "$scope"
  "$routeParams"
  "sessionService"
  "$location"
  ($scope, $routeParams, sessionService, $location) ->
    promise = sessionService.heartbeat()
    promise.success (data, status, headers, config) ->
      if sessionService.signedIn
        $scope.email = sessionService.email
      else
        $location.path('/users/sign_in')
    $scope.updateProfile = ->
      promise = sessionService.updateProfile($scope.email, $scope.current_password)
      promise.success (data, status, headers, config) ->
        $scope.infos = []
        $scope.infos.push "An email has been send to #{$scope.email}, to verify it belongs to you."
        $scope.current_password = ''
      promise.error (data, status, headers, config) ->
        $scope.all_errors = data.errors
    $scope.deleteAccount = ->
      $('#deleteModal').modal('hide')
      promise = sessionService.deleteAccount()
      promise.success (data, status, headers, config) ->
        sessionService.signedIn = false
        sessionService.id = null
        sessionService.email = null
        $location.path('/users/sign_in')
]
@baseControllers.controller "HomeCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "HOME CONTROLLER!"
]
@baseControllers.controller "SecretCtrl", [
  "$scope"
  ($scope) ->
    $scope.message = "SECRET CONTROLLER!"
]
@baseControllers.controller "AdminDashboardCtrl", [
  "$scope"
  "$http"
  ($scope, $http) ->
    width = $("#user_distribution").width()
    height = width
    radius = Math.min(width, height) / 2
    color = d3.scale.ordinal().range([
      "#98abc5"
      "#8a89a6"
      "#7b6888"
      "#6b486b"
      "#a05d56"
      "#d0743c"
      "#ff8c00"
    ])
    arc = d3.svg.arc().outerRadius(radius - 10).innerRadius(0)
    pie = d3.layout.pie().sort(null).value((d) ->
      d.users_count
    )
    svg = d3.select("#user_distribution").append("svg").attr("width", width).attr("height", height).append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
    promise = $http.get("/api/admin/roles")
    promise.success (data, status, headers, config) ->
      data.forEach (d) ->
        d.users_count = +d.users_count
        return

      g = svg.selectAll(".arc").data(pie(data)).enter().append("g").attr("class", "arc")
      g.append("path").attr("d", arc).style "fill", (d) ->
        color d.data.id

      g.append("text").attr("transform", (d) ->
        "translate(" + arc.centroid(d) + ")"
      ).attr("dy", ".35em").style("text-anchor", "middle").text (d) ->
        d.data.name + " (" + d.data.users_count + ")"

      return
]
