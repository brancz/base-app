@baseApp.factory "userService", [
  "$http"
  "$location"
  "$state"
  ($http, $location, $state) ->
    wrappedService =
      getUserData: ->
        promise = $http.get('/api/users/profile/me')
        promise.success (data, status, headers, config) ->
          wrappedService.setUserData(data.id, data.email, data.roles, true)
        promise.error (data, status, headers, config) ->
          wrappedService.resetUserData()
        return promise

      setUserData: (id, email, roles, signedIn) ->
        wrappedService.id = id
        wrappedService.email = email
        wrappedService.roles = roles
        wrappedService.signedIn = signedIn

      resetUserData: ->
        wrappedService.setUserData(null, null, null, false)

      updateProfile: (email, password, password_confirmation, current_password) ->
        data = {'user':{'email':email, 'password':password, 'password_confirmation':password_confirmation, 'current_password':current_password}}
        console.debug data
        promise = $http.put('/api/users', data)
        return promise

      deleteAccount: () ->
        promise = $http.delete('/api/users')
        return promise

      isAdmin: () ->
        result = false
        if wrappedService.roles
          for role in wrappedService.roles
            if role.internal_name == "admin"
              result = true
              break
        return result

      id: null
      email: null
      roles: null
      signedIn: false

    wrappedService.getUserData()
    wrappedService
]
