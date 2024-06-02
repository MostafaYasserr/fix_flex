class EndPoints {
  static const String baseUrl = "https://fixflex.onrender.com/api/v1/";
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
  static const String myChats = "chats";
  static const String messages = "messages";
  static String deleteTask({required String id}) => "$tasks/$id";
  static String getTask({required String id}) => "$tasks/$id";
  static String getUserData({required String id}) => "$users/$id";
  static String getMyData({required String id}) => "$users/me";
  static String updateProfilePicture() => "$users/me/profile-picture";
  static String checkMyRole() => "$taskers/me";
  static String BecomeATasker() => "$taskers/become-tasker";
  static String uploadTaskPhotos({required String id}) => "$tasks/$id/images";
  static String GetChatById({required String id}) => "$myChats/$id";
  static String GetMessagesByChatId({required String id}) => "$messages/chat/$id";
}
