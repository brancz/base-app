@baseControllers.controller "ManageUsersCtrl", [
  "$scope"
  "$http"
  ($scope, $http) ->
    promise = $http.get '/api/admin/users'
    promise.success (data, status, headers, config) ->
      $scope.users = data
    $scope.setCurrentUserId = (currentUserId) ->
      $scope.currentUserId = currentUserId
    $scope.deleteUser = ->
      $('#deleteModal').modal('hide')
      for user, i in $scope.users
        if user.id == $scope.currentUserId
          $scope.users.splice i, 1
          break
      $http.delete "/api/admin/users/#{$scope.currentUserId}"
]
