class AppUrl {
  static const String baseURL = "https://per-node.herokuapp.com";

  static const String login = baseURL + "/login";
  static const String otpRegister = baseURL + "/otpRegister";
  static const String verifyOTP = baseURL + "/verifyOTP";
  static const String register = baseURL + "/register";
  static const String forgotPassword = baseURL + "/forgotPassword";

  static const String createNewTask = baseURL + "/createNewTask";
  static const String getAllTasks = baseURL + "/getAllTasks";
  static const String deleteTask = baseURL + "/deleteTask/";
  static const String updateTaskCompletion = baseURL + "/updateTaskCompletion/";

  static const String createNewSpending = baseURL + "/createNewSpending";
  static const String getAllSpendings = baseURL + "/getAllSpendings";
}
