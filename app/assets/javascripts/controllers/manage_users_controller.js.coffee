@baseControllers.controller "ManageUsersCtrl", [
  "$scope"
  "$http"
  "$location"
  ($scope, $http, $location) ->
    promise = $http.get '/api/admin/users'
    promise.success (data, status, headers, config) ->
      $scope.users = data.users
      $scope.pages_count = Math.ceil(data.meta.total / 25)
      $scope.pages = [1..$scope.pages_count]
      $scope.current_page = 1
      if $location.search().page
        $scope.current_page = $location.search().page
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
