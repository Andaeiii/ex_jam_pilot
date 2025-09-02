const String ipaddr = '10.0.2.2';
const String serverURL = "http://$ipaddr/"; // only project base
const String appURL = "exjam_api/public"; // API folder path

// Combine them into the final API URL
const String assetURL = "$serverURL$appURL";
const String appBaseURL = "$serverURL$appURL/api";

const Map<String, dynamic> endPoints = {"login": "login", "profile": "profile"};
