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
  static String setMedicalByCaregiver(int elderId) {
    return merge('/api/api/v1/elders/$elderId/health-profile');
  }

  static String takeMedication(int doseId) {
    return merge('/api/api/v1/medications/doses/$doseId/taken');
  }

  static String snoozeMedication(int doseId) {
    return merge('/api/api/v1/medications/doses/$doseId/snooze');
  }

  static String doNotRemember(int medicationId) {
    return merge('/api/api/v1/medications/$medicationId/verify-pills');
  }

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
  static String addMedication = merge('/api/api/v1/medications');
  static String getMedications = merge('/api/api/v1/medications');
  static String analyzeVoice = merge('/ai/voice-assistant/message');
  static String getHomeData = merge('/api/api/v1/home');
  static String getCaregiverHomeData = merge('/api/api/v1/caregivers/home');
  static String getCaregiverProfileData = merge(
    '/api/api/v1/caregivers/profile',
  );
  static String connectCaregiverWithElder = merge(
    '/api/api/v1/caregivers/connect',
  );
  static String getCaregiverList = merge('/api/api/v1/elders/caregivers');
  static String allMedicationInCaregiver = merge(
    '/api/api/v1/caregivers/medications',
  );
  static String tabletModel = merge('/ai/tablet-blisters/analyze');
}
