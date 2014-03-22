@baseApp.factory "sessionService", ($cookieStore, $http, $location) ->
  wrappedService =
    logMeIn: (login) ->
      promise = $http.post('/api/session', login)
      promise.success (data, status, headers, config) ->
        $cookieStore.put('user_token', data.user_token)
        wrappedService.email = login.user_email
        wrappedService.loggedIn = true
        $location.path('/secret')
      return promise

    logMeOut: ->
      promise = $http.delete('/api/session')
      promise.success (data, status, headers, config) ->
        $cookieStore.remove('user_token')
        wrappedService.loggedIn = false
        $location.path('/users/sign_up')
      return

    heartbeat: ->
      promise = $http.get('/api/session/heartbeat')
      promise.success (data, status, headers, config) ->
        if data.session_alive
          inner_promise = $http.get('/api/users/myself')
          inner_promise.success (data, status, headers, config) ->
            wrappedService.email = data.email
            wrappedService.loggedIn = true
      return

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

    email: null
    loggedIn: null
  wrappedService
