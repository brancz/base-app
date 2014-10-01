var module = angular.module("app", [
    "ngCookies",
    "ngAnimate",
    "ui.router",
    "chieffancypants.loadingBar",
    "restangular"
]);

module.config([
    "$locationProvider",
    "$stateProvider",
    "$urlRouterProvider",
    function($locationProvider, $stateProvider, $urlRouterProvider) {
        $locationProvider.html5Mode(true);
        $urlRouterProvider.otherwise("/");
        $stateProvider.state("home", {
            url: "/",
            templateUrl: "/templates/index.html",
            controller: "HomeCtrl"
        }).state("secret", {
            url: "/secret",
            templateUrl: "/templates/secret.html",
            controller: "SecretCtrl"
        });
    }
]);
