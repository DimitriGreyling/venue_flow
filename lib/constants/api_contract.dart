class ApiEndpoints {
  static const String authLogin = '/auth/login';
  static const String authSignup = '/auth/signup';
  static const String authLogout = '/auth/logout';
  static const String authMe = '/auth/me';
  static const String authRefresh = '/auth/refresh';

  static const String forms = '/forms';
  static const String formSubmissions = '/form-submissions';

  static String formById(String id) => '$forms/$id';
  static String tenantById(String id) => '/tenants/$id';
  static String tenantBySlug(String slug) => '/tenants/slug/$slug';
}

class ApiQueryKeys {
  static const String fields = 'fields';
}

class AuthStorageKeys {
  static const String accessToken = 'AUTH_TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';
}

class ApiPayloadKeys {
  static const String refreshToken = 'refreshToken';
}