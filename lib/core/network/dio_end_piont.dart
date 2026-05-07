class Endpoints {
  Endpoints._();
  static const String baseUrl = 'https://ra3y.me:4430';
  static const String chatBot =
      'https://cloud.activepieces.com/api/v1/webhooks/uostrq272HpWBW9c0j9Rg/sync';
  static String merge(String url) {
    return baseUrl + url;
  }

  static String register = merge('/api/api/v1/auth/register');
  static String otpVerify = merge('/api/api/v1/auth/register/verify-otp');
  static String refreshAccessToken = merge('/api/api/v1/auth/refresh');
  static String login = merge('/api/api/v1/auth/login');
  static String resetPass = merge('/api/api/v1/auth/password-reset/request');
  static String otpReset = merge('/api/api/v1/auth/password-reset/verify');
  static String newPassword = merge('/api/api/v1/auth/password-reset/confirm');
  static String personalData = merge('/api/api/v1/auth/register/personal-data');
  static String selectRole = merge('/api/api/v1/auth/register/select-role');
  static String setMedical = merge('/api/api/v1/auth/register/health-profile');
  static String addSugar = merge('/api/api/v1/auth/sugar-readings');
  static String addBlood = merge('/api/api/v1/auth/blood-pressure-readings');
  static String getSugarReads = merge('/api/api/v1/auth/sugar-readings');
  static String getBloodReads = merge(
    '/api/api/v1/auth/blood-pressure-readings',
  );
  static String updateSugar = merge('/api/api/v1/auth/sugar-readings/');
  static String updateBlood = merge(
    '/api/api/v1/auth/blood-pressure-readings/',
  );
  static String getSugarMonthly = merge('/api/api/v1/ai/diabetes-month');
  static String getSugarDaily = merge('/api/api/v1/ai/diabetes-daily');
  static String getUserProfile = merge('/api/api/v1/users/profile');
}
