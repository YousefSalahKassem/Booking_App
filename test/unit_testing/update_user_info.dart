import 'package:bookingapp/src/features/profile/data/model/update_info_model.dart';
import 'package:bookingapp/src/features/profile/presentation/bloc/user_info/update_user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookingapp/injection_container.dart' as di;

void main() async {
  await di.init();
  group("check user updated", () {
    test("user updated successfully", () async {
      final cubit = UpdateUserCubit(updateUserUseCase: di.sl(), getUserInfoUseCase: di.sl());
      expectLater(
          cubit.updateInfo(
              UpdateInfoModel(name: 'Abdullah Mansou', email: 'abdullah.mansour12124@gmail.com')),
          completes);
    });

    test("user updated failed", () async {
      final cubit = UpdateUserCubit(updateUserUseCase: di.sl(), getUserInfoUseCase: di.sl());
      expectLater(
          cubit.updateInfo(
              UpdateInfoModel(name: 'Abdullah Mansour', email: 'abdullah.mansour@gmail.com')),
          completes);
    });

    test("get user profile successfully", () async {
      final cubit = UpdateUserCubit(updateUserUseCase: di.sl(), getUserInfoUseCase: di.sl());
      expectLater(cubit.userProfile(), completes);
    });
  });
}
