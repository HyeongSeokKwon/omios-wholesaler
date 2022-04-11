part of 'user_info_bloc.dart';

enum ValidateState { valid, unvalid, initial }
enum RequestState { initial, success, failure, loading }

class UserInfoState extends Equatable {
  final String storeName;
  final String name;
  final String username;
  final String email;
  final String password;
  final String checkPassword;
  final String storeNumber;
  final String phoneNumber;
  final String companyRegistrationNumber;
  final ValidateState idUnique;
  final ValidateState isIdEffective;
  final ValidateState isPasswordEffective;
  final ValidateState isPasswordSame;
  final ValidateState isStoreNumberEffective;
  final ValidateState isPhoneNumberEffective;
  final bool secondPageDataValid;
  final bool thirdPageDataValid;
  final File? companyRegistrationImage;
  final RequestState signUpState;
  final String signUpErrorType;

  const UserInfoState({
    required this.storeName,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.checkPassword,
    required this.storeNumber,
    required this.phoneNumber,
    required this.companyRegistrationNumber,
    required this.idUnique,
    required this.isIdEffective,
    required this.isPasswordEffective,
    required this.isPasswordSame,
    required this.isStoreNumberEffective,
    required this.isPhoneNumberEffective,
    required this.secondPageDataValid,
    required this.thirdPageDataValid,
    required this.companyRegistrationImage,
    required this.signUpState,
    required this.signUpErrorType,
  });
  factory UserInfoState.initial() {
    return const UserInfoState(
        storeName: '',
        name: '',
        username: '',
        email: '',
        password: '',
        checkPassword: '',
        storeNumber: '',
        phoneNumber: '',
        companyRegistrationNumber: '',
        idUnique: ValidateState.initial,
        isIdEffective: ValidateState.initial,
        isPasswordEffective: ValidateState.initial,
        isPasswordSame: ValidateState.initial,
        isPhoneNumberEffective: ValidateState.initial,
        isStoreNumberEffective: ValidateState.initial,
        secondPageDataValid: false,
        thirdPageDataValid: false,
        companyRegistrationImage: null,
        signUpState: RequestState.initial,
        signUpErrorType: '');
  }

  @override
  List<Object?> get props {
    return [
      storeName,
      name,
      username,
      email,
      password,
      checkPassword,
      storeNumber,
      phoneNumber,
      companyRegistrationNumber,
      idUnique,
      isIdEffective,
      isPasswordEffective,
      isPasswordSame,
      isStoreNumberEffective,
      isPhoneNumberEffective,
      secondPageDataValid,
      thirdPageDataValid,
      companyRegistrationImage,
      signUpState,
      signUpErrorType,
    ];
  }

  UserInfoState copyWith({
    String? storeName,
    String? name,
    String? username,
    String? email,
    String? password,
    String? checkPassword,
    String? storeNumber,
    String? phoneNumber,
    String? companyRegistrationNumber,
    ValidateState? idUnique,
    ValidateState? isIdEffective,
    ValidateState? isPasswordEffective,
    ValidateState? isPasswordSame,
    ValidateState? isStoreNumberEffective,
    ValidateState? isPhoneNumberEffective,
    bool? secondPageDataValid,
    bool? thirdPageDataValid,
    File? companyRegistrationImage,
    RequestState? signUpState,
    String? signUpErrorType,
  }) {
    return UserInfoState(
      storeName: storeName ?? this.storeName,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      checkPassword: checkPassword ?? this.checkPassword,
      storeNumber: storeNumber ?? this.storeNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      companyRegistrationNumber:
          companyRegistrationNumber ?? this.companyRegistrationNumber,
      idUnique: idUnique ?? this.idUnique,
      isIdEffective: isIdEffective ?? this.isIdEffective,
      isPasswordEffective: isPasswordEffective ?? this.isPasswordEffective,
      isPasswordSame: isPasswordSame ?? this.isPasswordSame,
      isStoreNumberEffective:
          isStoreNumberEffective ?? this.isStoreNumberEffective,
      isPhoneNumberEffective:
          isPhoneNumberEffective ?? this.isPhoneNumberEffective,
      secondPageDataValid: secondPageDataValid ?? this.secondPageDataValid,
      thirdPageDataValid: thirdPageDataValid ?? this.thirdPageDataValid,
      companyRegistrationImage:
          companyRegistrationImage ?? this.companyRegistrationImage,
      signUpState: signUpState ?? RequestState.initial,
      signUpErrorType: signUpErrorType ?? '',
    );
  }
}
