import '../../app_environment.dart';

class ApiUrls {
  static String baseUrl = AppEnvironment().getApiURL();

  //? Auth Api's
  static String loginUrl = "restaurant-login";

// //? Bottombar Api's
// static String groups = "group/group-list";
// static String newGroup = "group/new-group";
// static String newGroupJoin = "group/join/";
//
// //? Notification Api's
// static String getAllNotification = "notification";
// static String notificationDeleteById = "notification/delete-by-id/";
// static String notificationDeleteAll = "notification/delete-all";
// static String readSingleNotification = "notification/read-single/";
//
// //? Group Api's
// static String groupDetails = "group/details/";
// static String createGroup = "researchers/group";
// static String updateGroup = "researchers/group/";
// static String deleteGroup = "researchers/group/delete/";
// static String leaveGroup = "group/leave/";
// static String homeTips = "tip/dashboard/home-screen/";
// static String stockTypes = "/tip/dashboard/stock-types";
// static String groupMembers = "/researchers/group/members/";
// static String removeMember = "/researchers/group/remove-member/";
}
