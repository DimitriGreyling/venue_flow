import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/shared/helpers/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});