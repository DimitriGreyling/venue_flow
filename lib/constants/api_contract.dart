class ApiEndpoints {
  static const String authLogin = '/auth/login';
  static const String authSignup = '/auth/signup';
  static const String authLogout = '/auth/logout';
  static const String authMe = '/auth/me';
  static const String authRefresh = '/auth/refresh';

  static const String events = '/event';
  static const String forms = '/form';
  static const String formSubmissions = '/FormSubmission';

  static String formById(String id) => '$forms/$id';
  static String tenantById(String id) => '/tenants/$id';
  static String tenantBySlug(String slug) => '/tenants/slug/$slug';

  //TODO:: Move this to env variables
  static String localUrl = "http://localhost:5082/api";
  static String productionUrl = "https://venue-flow-api.onrender.com/api";
}

class ApiQueryKeys {
  static const String search = 'search';
  static const String pageNumber = 'pageNumber';
  static const String pageSize = 'pageSize';
  static const String fields = 'fields';
}

class AuthStorageKeys {
  static const String accessToken = 'AUTH_TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';
  static const String authProfile = 'AUTH_PROFILE';
}

class ApiPayloadKeys {
  static const String refreshToken = 'refreshToken';
}
