import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/services/local/auth_service.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:stacked/stacked.dart';

mixin LocalDbViewModel on ReactiveViewModel {
  LocalDatabase _localDatabase = locator<LocalDatabase>();

  LocalDatabase get db => _localDatabase;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_localDatabase];
}