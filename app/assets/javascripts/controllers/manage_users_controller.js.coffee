@baseControllers.controller "ManageUsersCtrl", [
  "$scope"
  "$http"
  "$location"
  ($scope, $http, $location) ->
    $scope.current_page = 1
    if $location.search().page
      $scope.current_page = parseInt($location.search().page)
    
    $scope.loadPage = (page) ->
      $location.search('page', page)
      $scope.current_page = page
      promise = $http.get "/api/admin/users?page=#{$scope.current_page}"
      promise.success (data, status, headers, config) ->
        $scope.users = data.users
        $scope.pages_count = Math.ceil(data.meta.total / 25)
        $scope.pages = [1..$scope.pages_count]

    $scope.setCurrentUserId = (currentUserId) ->
      $scope.currentUserId = currentUserId

    $scope.deleteUser = ->
      $('#deleteModal').modal('hide')
      for user, i in $scope.users
        if user.id == $scope.currentUserId
          $scope.users.splice i, 1
          break
      $http.delete "/api/admin/users/#{$scope.currentUserId}"
    
    $scope.loadPage($scope.current_page)
]
