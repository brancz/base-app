@baseApp.factory "alertService", [
  ->
    wrappedService =
      infos: []
      warnings: []
      errors: []

    wrappedService
]
