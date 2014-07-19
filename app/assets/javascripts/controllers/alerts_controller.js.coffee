@baseControllers.controller "AlertsCtrl", [
  "$scope"
  "alertService"
  ($scope, alertService) ->
    $scope.alerts = alertService
]
