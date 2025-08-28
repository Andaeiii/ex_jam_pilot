const String _server = "http://10.0.2.2/"; // only project base
const String _appURL = "exjam_api/public/api"; // API folder path

// Combine them into the final API URL
const String appBaseURL = "$_server$_appURL";

const Map<String, dynamic> endPoints = {"login": "login", "profile": "profile"};
