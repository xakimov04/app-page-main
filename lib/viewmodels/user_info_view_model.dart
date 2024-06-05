import 'package:settings_page/models/user_info.dart';

class UserInfoViewModel {
  UserInfo _userInfo = UserInfo(
    userName: 'userName',
    userSurname: 'userSurname',
    phoneNumber: 'phoneNumber',
    profilePictureUrl: 'https://cdn.hackaday.io/images/3553251501638077867.png',
  );

  UserInfo get userInfo {
    return _userInfo;
  }

  void editUserInfo({
    required String newName,
    required String newSurname,
    required String newNumber,
    required String newPicture,
  }) {
    _userInfo.userName = newName;
    _userInfo.userSurname = newSurname;
    _userInfo.phoneNumber = newNumber;
    _userInfo.profilePictureUrl = newPicture;
  }
}
