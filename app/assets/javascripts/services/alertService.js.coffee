@baseApp.factory "alertService", [
  "$timeout"
  ($timeout) ->
    wrappedService =
      addError: (message) ->
        index = wrappedService.errors.push(message)
        $timeout (->
          wrappedService.dismissError(0)
          return
        ), 3000
      dismissError: (index) ->
        wrappedService.errors.splice(index, 1)
      addWarning: (message) ->
        index = wrappedService.warnings.push(message)
        $timeout (->
          wrappedService.dismissWarning(0)
          return
        ), 3000
      dismissWarning: (index) ->
        wrappedService.warnings.splice(index, 1)
      addInfo: (message) ->
        index = wrappedService.infos.push(message)
        $timeout (->
          wrappedService.dismissInfo(0)
          return
        ), 3000
      dismissInfo: (index) ->
        wrappedService.infos.splice(index, 1)
      infos: []
      warnings: []
      errors: []

    wrappedService
]
