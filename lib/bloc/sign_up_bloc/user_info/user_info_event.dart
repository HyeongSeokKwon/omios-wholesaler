part of 'user_info_bloc.dart';

@immutable
abstract class UserInfoEvent {}

class InputUsernameEvent extends UserInfoEvent {
  final String username;
  InputUsernameEvent({
    required this.username,
  });
}

class InputEmailEvent extends UserInfoEvent {
  final String email;
  InputEmailEvent({
    required this.email,
  });
}

class InputPasswordEvent extends UserInfoEvent {
  final String password;
  InputPasswordEvent({
    required this.password,
  });
}

class InputStoreNameEvent extends UserInfoEvent {
  final String storeName;
  InputStoreNameEvent({
    required this.storeName,
  });
}

class InputRepresentativeNameEvent extends UserInfoEvent {
  final String name;
  InputRepresentativeNameEvent({
    required this.name,
  });
}

class CheckIdDuplicatedEvent extends UserInfoEvent {
  final String id;

  CheckIdDuplicatedEvent({
    required this.id,
  });
}

class ValidatePasswordEvent extends UserInfoEvent {
  final String password;
  ValidatePasswordEvent({
    required this.password,
  });
}

class CheckPasswordSame extends UserInfoEvent {
  final String password;
  final String passwordCheck;
  CheckPasswordSame({
    required this.password,
    required this.passwordCheck,
  });
}

class ValidatePhoneNumberEvent extends UserInfoEvent {
  final String phoneNumber;

  ValidatePhoneNumberEvent({required this.phoneNumber});
}

class ValidateStoreNumberEvent extends UserInfoEvent {
  final String storeNumber;

  ValidateStoreNumberEvent(this.storeNumber);
}

class InputStoreNumberEvent extends UserInfoEvent {
  final String storeNumber;

  InputStoreNumberEvent({
    required this.storeNumber,
  });
}

class InputPhoneNumberEvent extends UserInfoEvent {
  final String phoneNumber;

  InputPhoneNumberEvent({
    required this.phoneNumber,
  });
}

class InputCompanyRegistrationNumberEvent extends UserInfoEvent {
  final String first;
  final String second;
  final String third;

  InputCompanyRegistrationNumberEvent({
    required this.first,
    required this.second,
    required this.third,
  });
}

class GetImageFromGallery extends UserInfoEvent {}

class GetImageFromCamera extends UserInfoEvent {}

class ClickSignUpButtonEvent extends UserInfoEvent {}
