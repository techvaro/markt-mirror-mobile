import 'api_service.dart';

class ServiceLocator {
  static ServiceLocator? _instance;
  late final ApiService _apiService;

  ServiceLocator._() {
    _apiService = ApiService();
  }

  static ServiceLocator get instance {
    _instance ??= ServiceLocator._();
    return _instance!;
  }

  ApiService get apiService => _apiService;

  static ApiService get api => instance._apiService;
}
