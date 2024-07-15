import 'package:pfizer/src/services/local/auth_service.dart';
import 'package:pfizer/src/services/local/base/usable_data_view_model.dart';
import 'package:pfizer/src/services/local/connectivity_service.dart';
import 'package:pfizer/src/services/local/keyboard_service.dart';
import 'package:pfizer/src/services/local/local_db.dart';
import 'package:pfizer/src/services/local/usable_data_service.dart';
import 'package:pfizer/src/services/remote/api_service.dart';
import 'package:pfizer/src/views/change_password/change_password_view.dart';
import 'package:pfizer/src/views/dashboard/dashboard_view.dart';
import 'package:pfizer/src/views/doctor_call/doctor_call_view.dart';
import 'package:pfizer/src/views/my_schedule/my_schedule_view.dart';
import 'package:pfizer/src/views/setting/setting_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:pfizer/src/views/login/login_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: SettingView),
    MaterialRoute(page: ChangePasswordView),
    MaterialRoute(page: DoctorCallView),
    MaterialRoute(page: MyScheduleView),
  ],
  dependencies: [
    // Lazy singletons
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: KeyboardService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: LocalDatabase),
    LazySingleton(classType: UsableDataService),
  ],
)
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
