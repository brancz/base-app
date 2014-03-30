@baseApp.factory "sessionService", [
  "$cookieStore"
  "$http"
  "$location"
  ($cookieStore, $http, $location) ->
    wrappedService =
      signin: (login) ->
        promise = $http.post('/api/session', login)
        promise.success (data, status, headers, config) ->
          $cookieStore.put('user_token', data.user_token)
          inner_promise = $http.get('/api/users/myself')
          inner_promise.success (data, status, headers, config) ->
            wrappedService.id = data.id
            wrappedService.email = data.email
            wrappedService.roles = data.roles
            wrappedService.signedIn = true
            $location.path('/secret')
        return promise

      signout: ->
        promise = $http.delete('/api/session')
        promise.success (data, status, headers, config) ->
          $cookieStore.remove('user_token')
          wrappedService.signedIn = false
          $location.path('/users/sign_in')
        return

      heartbeat: ->
        promise = $http.get('/api/session/heartbeat')
        promise.success (data, status, headers, config) ->
          if data.session_alive
            inner_promise = $http.get('/api/users/myself')
            inner_promise.success (data, status, headers, config) ->
              wrappedService.id = data.id
              wrappedService.email = data.email
              wrappedService.roles = data.roles
              wrappedService.signedIn = true
          else
            wrappedService.id = null
            wrappedService.email = null
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

      updateProfile: (email, current_password) ->
        promise = $http.put('/api/users', {'user':{'email':email, 'current_password':current_password}})
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

    wrappedService.heartbeat()
    wrappedService
]
