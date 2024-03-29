class AppUrl {
  static const String baseURL = "https://per-node-be.onrender.com";
  // static const String baseURL = "http://localhost:3000";

  static const String login = "$baseURL/login";
  static const String googleLogin = "$baseURL/googleLogin";
  static const String otpRegister = "$baseURL/otpRegister";
  static const String verifyOTP = "$baseURL/verifyOTP";
  static const String register = "$baseURL/register";
  static const String registerGoogle = "$baseURL/registerGoogle";
  static const String forgotPassword = "$baseURL/forgotPassword";
  static const String updateAvatar = "$baseURL/updateAvatar";
  static const String updateUserInfo = "$baseURL/updateUserInfo";

  static const String createNewTask = "$baseURL/createNewTask";
  static const String getAllTasks = "$baseURL/getAllTasks";
  static const String deleteTask = "$baseURL/deleteTask/";
  static const String updateTaskCompletion = "$baseURL/updateTaskCompletion/";

  static const String createNewAlbum = "$baseURL/createNewAlbum";
  static const String getAllAlbums = "$baseURL/getAllAlbums";
  static const String deleteAlbum = "$baseURL/deleteAlbum/";
  static const String updateAlbum = "$baseURL/updateAlbum/";
  static const String getAllFirstImageFromAlbum =
      "$baseURL/getAllFirstImageFromAlbum";

  static const String getAllImagesByAlbumId =
      "$baseURL/get-all-images-by-albumid";
  static const String uploadImagesToAlbum = "$baseURL/upload-images-album";
  static const String deleteImagesOfAlbum = "$baseURL/delete-images-of-album/";

  static const String createNewNote = "$baseURL/create-new-note";
  static const String getAllNotes = "$baseURL/get-all-notes";
  static const String deteleNote = "$baseURL/deleteNote/";
  static const String updateNote = "$baseURL/update-note/";

  static const String createNewHealthyIndex =
      "$baseURL/create-new-healthy-index";
  static const String getAllHealthyIndexs = "$baseURL/get-all-healthy-indexs";

  static const String createNewDetailHealthyIndex =
      "$baseURL/create-new-detail-healthy-index";
  static const String getAllDetailHealthyIndexByUserId =
      "$baseURL/get-all-detail-healthy-index/";
  static const String deleteDetailHealthyIndex =
      "$baseURL/delete-detail-healthy-index/";
  static const String getDetailHealthyIndexLastest =
      "$baseURL/get-detail-healthy-index-lastest/";

  static const String createNewAccount = "$baseURL/createNewAccount";
  static const String getAllAccounts = "$baseURL/getAllAccounts";
  static const String deleteAccount = "$baseURL/deleteAccount/";
  static const String updateAccount = "$baseURL/updateAccount/";

  static const String createNewDocument = "$baseURL/createNewDocument";
  static const String getAllDocuments = "$baseURL/getAllDocuments";
  static const String deleteDocument = "$baseURL/deleteDocument/";
  static const String updateDocument = "$baseURL/updateDocument/";

  static const String createNewCategory = "$baseURL/createNewCategory";
  static const String getAllCategories = "$baseURL/getAllCategories";
  static const String deleteCategory = "$baseURL/deleteCategory/";
  static const String updateCategory = "$baseURL/updateCategory/";

  static const String getAllTasksByCategoryId =
      "$baseURL/get-all-tasks-by-categoryid";
  static const String uploadTasksToCategory = "$baseURL/upload-tasks-category";
  static const String deleteTasksOfCategory =
      "$baseURL/delete-tasks-of-category/";
}
