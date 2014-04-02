@baseControllers.controller "AlertsCtrl", [
  "$scope"
  "alertService"
  ($scope, alertService) ->
    $scope.dismissError = (index) ->
      $scope.alerts.errors.splice(index, 1)
    $scope.dismissWarning = (index) ->
      $scope.alerts.warnings.splice(index, 1)
    $scope.dismissInfo = (index) ->
      $scope.alerts.infos.splice(index, 1)
    $scope.alerts = alertService
]
