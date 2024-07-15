import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/services/local/auth_service.dart';
import 'package:stacked/stacked.dart';

mixin AuthViewModel on ReactiveViewModel {
  AuthService _authService = locator<AuthService>();

  AuthService get authService => _authService;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_authService];
}