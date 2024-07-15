import 'package:pfizer/src/configs/app_setup.locator.dart';
import 'package:pfizer/src/models/api_resonse/doctor_call_form_model.dart';
import 'package:pfizer/src/models/usable_data/usable_data_model.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:stacked/stacked.dart';

class UsableDataService with ReactiveServiceMixin {
  ReactiveValue<UsableDataModel?> usableData =
      ReactiveValue<UsableDataModel?>(UsableDataModel());

  LocalDatabase db = locator<LocalDatabase>();

  UsableDataService() {
    listenToReactiveValues([usableData]);
    get();
  }

  void clear() {
    usableData.value = null;
  }

  update() async {
    UsableDataModel _data = await db.insertIntoTables(usableData.value);
    print(_data);
  }

  get() async {
    UsableDataModel _data = await db.getFromTable();
    usableData.value = _data;
  }

  updateStatus(String detail_id) async {
    await db.UpdateOfflineStatus(detail_id);
  }
}
