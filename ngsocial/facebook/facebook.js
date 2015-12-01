'use strict';

angular.module('ngSocial.facebook', ['ngRoute', 'ngFacebook'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/facebook', {
    templateUrl: 'facebook/facebook.html',
    controller: 'facebookCtrl'
  });
}])
.config( function( $facebookProvider ) {
  $facebookProvider.setAppId('520135284812823');
  $facebookProvider.setPermissions("email,public_profile,user_posts,publish_actions,user_photos");
})


.run( function( $rootScope ) {
        (function(d, s, id){
         var js, fjs = d.getElementsByTagName(s)[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement(s); js.id = id;
         js.src = "//connect.facebook.net/en_US/sdk.js";
         fjs.parentNode.insertBefore(js, fjs);
       }(document, 'script', 'facebook-jssdk'));
})

.controller('facebookCtrl', ['$scope', '$facebook', function($scope, $facebook) {
    $scope.isLoggedIn = false;
    refresh()
    $scope.login = function() {
        $facebook.login().then(function() {
           $scope.isLoggedIn = true;
           refresh()
        });
    };

    $scope.logout = function() {
        $facebook.logout().then(function() {
           $scope.isLoggedIn = false;
           refresh()
        });
    };

    $scope.postStatus = function() {
        var body = this.postBody;
        //console.log("Post: " + body);
        $facebook.api('/me/feed', 'post', {message:body}).then(function(response) {
            //console.log("Posted");
            $scope.msg = 'Thanks for posting.';
            refresh();
        })
    };

    function refresh() {
        $facebook.api("/me?fields=id,name,first_name,last_name,email,gender,locale,link,picture,permissions,posts,cover").then(function(response) {
            $scope.welcomeMsg = "Welcome " + response.name;
            $scope.isLoggedIn = true;
            $scope.userInfo = response;
            $scope.picture = response.picture.data.url;
            $scope.permissions = response.permissions.data;
            $scope.posts = response.posts.data;
            // console.log(response);
        },
        function(err){
            $scope.welcomeMsg = "Please Log In"
        })
    }
}]);
