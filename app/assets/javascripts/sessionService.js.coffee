@baseApp.factory "sessionService", [
  "$http"
  "$location"
  ($http, $location) ->
    wrappedService =
      signin: (login) ->
        promise = $http.post('/api/users/sign_in', {user: login})
        promise.success (data, status, headers, config) ->
          wrappedService.getUserData()
          $location.path('/secret')
        return promise

      signout: ->
        promise = $http.delete('/api/users/sign_out')
        promise.success (data, status, headers, config) ->
          wrappedService.id = null
          wrappedService.email = null
          wrappedService.roles = null
          wrappedService.signedIn = false
          $location.path('/users/sign_in')
        return

      getUserData: ->
        promise = $http.get('/api/users/me')
        promise.success (data, status, headers, config) ->
          wrappedService.id = data.id
          wrappedService.email = data.email
          wrappedService.roles = data.roles
          wrappedService.signedIn = true
        promise.error (data, status, headers, config) ->
          wrappedService.id = null
          wrappedService.email = null
          wrappedService.roles = null
          wrappedService.signedIn = false
        return promise

      signup: (email, password) ->
        promise = $http.post('/api/users', {'user':{'email':email, 'password':password, 'password_confirmation':password}})
        return promise

      requestPasswordReset: (email) ->
        promise = $http.post('/api/users/password', {'user':{'email':email}})
        return promise

      requestConfirmationResend: (email) ->
        promise = $http.post('/api/users/confirmation', {'user':{'email':email}})
        return promise

      requestUnlockResend: (email) ->
        promise = $http.post('/api/users/unlock', {'user':{'email':email}})
        return promise

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
