import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/service_locator.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _api = ServiceLocator.api;

  AppUser? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;
  bool get isVendor => _currentUser?.role == UserRole.vendor;
  bool get isMapper => _currentUser?.role == UserRole.mapper;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _api.login(email, password);
      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String name, String email, String phone, String password, UserRole role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await _api.signup(name, email, phone, password, role);
      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _api.logout();
      _currentUser = null;
      _isLoggedIn = false;
      _error = null;
    } catch (e) {
      _currentUser = null;
      _isLoggedIn = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _api.forgotPassword(email);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
