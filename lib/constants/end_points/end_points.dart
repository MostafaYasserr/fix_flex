class EndPoints {
  static const String baseUrl = "https://server.fixflex.tech/api/v1/";
  static const String chatWebSocket = "wss://server.fixflex.tech";
  // static const String baseUrl = "https://dev1-fixflex.onrender.com/api/v1/";
  // static const String chatWebSocket = "wss://dev1-fixflex.onrender.com";
  static const String login = "auth/login";
  static const String register = "auth/signup";
  static const String logout = "auth/logout";
  static const String refreshToken = "auth/refresh-token";
  static const String users = "users";
  static const String updateMyData = "users/me";
  static const String sendVerificationCode = "users/send-verification-code";
  static const String verifyPhoneNumber = "users/verify";
  static const String taskers = "taskers";
  static const String categories = "categories";
  static const String tasks = "tasks";
  static const String offers = "offers";
  static const String chats = "chats";
  static const String messages = "messages";
  static String deleteTask({required String id}) => "$tasks/$id";
  static String getTask({required String id}) => "$tasks/$id";
  static String getUserData({required String id}) => "$users/$id";
  static String getMyData({required String id}) => "$users/me";
  static String updateProfilePicture() => "$users/me/profile-picture";
  static String checkMyRole() => "$taskers/me";
  static String becomeATasker() => "$taskers/become-tasker";
  static String getTaskerById({required String taskerId}) => "$taskers/$taskerId";
  static String uploadTaskPhotos({required String id}) => "$tasks/$id/images";
  static String getChatById({required String id}) => "$chats/$id";
  static String getMessagesByChatId({required String id}) => "$messages/chat/$id";
  static String acceptOfferCash({required String offerId}) => "$offers/$offerId/accept";
  static String canselTask({required String taskId}) => "$tasks/$taskId/cancel";
  static String makeTaskOpen({required String taskId}) => "$tasks/$taskId/open";
  static String completedTask({required String taskId}) => "$tasks/$taskId/complete";
  static String rateTasker({required String taskId}) => "$tasks/$taskId/reviews";
}