import 'package:every_maple/feature/auth/auth_repository.dart';
import 'package:every_maple/feature/auth/models/char_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  String uId = 'c38b836623c3e5a0ff23a8bda71ef628';
  CharModel? charModel;
  AuthRepository authRepository = AuthRepository();

  fetchUserByCharName({required String charName}) async {
    String? value =
        await authRepository.fetchUserByCharName(charName: charName);

    uId = value ?? '';
  }

  Future<void> fetchCharDetailByUid() async {
    charModel = await authRepository.fetchCharDetailByUid(uId: uId);

    print('charModel. : ${charModel!.characterImage}');

    update();
  }
}
