@baseApp.config [
  "$stateProvider"
  "$urlRouterProvider"
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise "/"

    $stateProvider.state("profile",
      url: "/users/profile"
      templateUrl: "/templates/users/profile.html"
      controller: "UserAccountCtrl"
    ).state("home",
      url: "/"
      templateUrl: "/templates/index.html"
      controller: "HomeCtrl"
    ).state("secret",
      url: "/secret"
      templateUrl: "/templates/secret.html"
      controller: "SecretCtrl"
    ).state("dashboard",
      url: "/admin"
      templateUrl: "/templates/admin/dashboard.html"
      controller: "AdminDashboardCtrl"
    ).state("manage_users",
      url: "/admin/users"
      templateUrl: "/templates/admin/users/list.html"
      controller: "ManageUsersCtrl"
    ).state("show_user",
      url: "/admin/users/:id"
      templateUrl: "/templates/admin/users/show.html"
      controller: "ShowUsersCtrl"
    ).state("edit_user",
      url: "/admin/users/:id/edit"
      templateUrl: "/templates/admin/users/edit.html"
      controller: "EditUsersCtrl"
    )
]
