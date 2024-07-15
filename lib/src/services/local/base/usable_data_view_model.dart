import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/models/usable_data/usable_data_model.dart';
import 'package:pfizer/src/services/local/auth_service.dart';
import 'package:pfizer/src/services/local/usable_data_service.dart';
import 'package:stacked/stacked.dart';

mixin UsableDataViewModel on ReactiveViewModel {
  UsableDataService usableDataService = locator<UsableDataService>();


  UsableDataModel? get usableData => usableDataService.usableData.value;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [usableDataService];
}