const String ipaddr = '10.0.2.2';
const String serverURL = "http://$ipaddr/"; // only project base
const String _appURL = "exjam_api/public/api"; // API folder path

// Combine them into the final API URL
const String appBaseURL = "$serverURL$_appURL";

const Map<String, dynamic> endPoints = {"login": "login", "profile": "profile"};
