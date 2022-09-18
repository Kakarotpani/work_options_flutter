final Map<String, String> apiRoutes = {
  "login_api": "api/login",
  "logout_api": "api/logout",
  "register_api": "api/register",
  "refresh_token_api": "api/token/refresh",
  // freelancer
  "freelancer_profile_post": "api/freelancer/profile/post",
  "freelancer_profile_get": "api/freelancer/profile/get",
  "freelancer_profile_put": "api/freelancer/profile/put",
  "freelancer_profile_delete": "api/freelancer/profile/delete",

  "skill_post": "api/freelancer/skill/post",
  "skill_get": "api/freelancer/skill/get",
  "skill_put": "api/freelancer/skill/put/",
  "skill_delete": "api/freelancer/skill/delete/",

  "freelancer_bid_post" : "api/freelancer/bid/post/",
  "freelancer_bid_get" : "api/freelancer/bid/get",
  "freelancer_bid_put" : "api/freelancer/bid/put/<int:id>",
  "freelancer_bid_delete" : "api/freelancer/bid/delete/",

  "freelancer_favourite_post" : "api/freelancer/favourite/post/",
  "freelancer_favourite_get" : "api/freelancer/favourite/get",
  "freelancer_favourite_delete" : "api/freelancer/favourite/delete/",

  "freelancer_contract_get" : "api/freelancer/contract/get",
  "freelancer_history_get" : "api/freelancer/history/get",
  "bid_clientprofile_get": "api/freelancer/bid/profile/get/",

  "freelancer_recommend": "api/freelancer/recommend/get",
  "freelancer_search": "api/freelancer/search/post",
  // client
  "client_profile_post": "api/client/profile/post",
  "client_profile_get": "api/client/profile/get",
  "client_profile_put": "api/client/profile/put",
  "client_profile delete": "api/client/profile/delete",

  "job_post": "api/client/job/post",
  "job_get": "api/client/job/get",
  "job_single_get": "api/client/job/single/get/",
  "job_put": "api/client/job/put/",
  "job_delete": "api/client/job/delete/",

  "contract_post": "api/client/contract/post/", //select bid
  "contract_get": "api/client/contract/get", //current jobs
  "contract_delete": "api/client/contract/get",

  "history_post": "api/client/history/post/", //finish current job 
  "history_get": "api/client/history/get", //job history

  "client_bid_get": "api/client/bid/get", //pending requests
  "bid_freelancerprofile_get": "api/client/bid/profile/get/", // get bid-freelancer profile

  "client_recommend": "api/client/recommend/get",
  "client_search": "api/client/search/post",
};