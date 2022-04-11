import 'dart:io';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:deepy_wholesaler/bloc/sign_up_bloc/store_location_bloc/store_location_bloc.dart';
import 'package:deepy_wholesaler/repository/sign_up_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  ImagePicker picker = ImagePicker();
  StoreLocationBloc storeLocationBloc;
  SignUpRepository signUpRepository = SignUpRepository();
  UserInfoBloc(this.storeLocationBloc) : super(UserInfoState.initial()) {
    on<InputUsernameEvent>(inputUserName);
    on<InputPasswordEvent>(inputPassword);
    on<CheckIdDuplicatedEvent>(checkIdDuplicated);
    on<InputEmailEvent>(inputEmail);
    on<ValidatePasswordEvent>(validatePassword);
    on<CheckPasswordSame>(checkPasswordDuplicated);
    on<ValidateStoreNumberEvent>(validateStoreNumber);
    on<ValidatePhoneNumberEvent>(validatePhoneNumber);
    on<InputStoreNameEvent>(inputStoreName);
    on<InputRepresentativeNameEvent>(inputRepresentativeName);
    on<InputStoreNumberEvent>(inputStoreNumber);
    on<InputPhoneNumberEvent>(inputPhoneNumber);
    on<InputCompanyRegistrationNumberEvent>(inputCompanyRegistrationNumber);
    on<GetImageFromGallery>(getImageFromGallery);
    on<GetImageFromCamera>(getImageFromCamera);
    on<ClickSignUpButtonEvent>(clickSignUp);
  }
  void inputStoreName(InputStoreNameEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        storeName: event.storeName,
        signUpErrorType: '',
        signUpState: RequestState.initial));
  }

  void inputRepresentativeName(
      InputRepresentativeNameEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        name: event.name,
        signUpErrorType: '',
        signUpState: RequestState.initial));
  }

  void inputUserName(InputUsernameEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        username: event.username,
        signUpErrorType: '',
        signUpState: RequestState.initial));
  }

  void inputEmail(InputEmailEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        email: event.email,
        signUpErrorType: '',
        signUpState: RequestState.initial));
  }

  void inputPassword(InputPasswordEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        password: event.password,
        signUpErrorType: '',
        signUpState: RequestState.initial));
  }

  Future<void> checkIdDuplicated(
      CheckIdDuplicatedEvent event, Emitter<UserInfoState> emit) async {
    bool idUnique;
    RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');

    if (regex.hasMatch(event.id) &&
        event.id.length >= 4 &&
        event.id.length <= 20) {
      idUnique = await signUpRepository.getIdUnique(event.id).catchError((e) {
        throw Exception(e.toString());
      });
      print(idUnique);
      if (idUnique) {
        emit(state.copyWith(
            idUnique: ValidateState.valid,
            isIdEffective: ValidateState.valid,
            signUpErrorType: '',
            signUpState: RequestState.initial));
      } else {
        emit(state.copyWith(
            idUnique: ValidateState.unvalid,
            isIdEffective: ValidateState.valid,
            signUpErrorType: '',
            signUpState: RequestState.initial));
      }
    } else if (event.id.isEmpty) {
      emit(state.copyWith(
          idUnique: ValidateState.initial,
          isIdEffective: ValidateState.initial,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else {
      emit(state.copyWith(
          idUnique: ValidateState.initial,
          isIdEffective: ValidateState.unvalid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    }
    emit(state.copyWith(secondPageDataValid: checkSecondPageDataValid()));
  }

  void validatePassword(
      ValidatePasswordEvent event, Emitter<UserInfoState> emit) {
    RegExp regex = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[!-~]+$');
    if (regex.hasMatch(event.password) && event.password.length >= 10) {
      emit(state.copyWith(
          isPasswordEffective: ValidateState.valid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else if (event.password.isEmpty) {
      emit(state.copyWith(
          isPasswordEffective: ValidateState.initial,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else {
      emit(state.copyWith(
          isPasswordEffective: ValidateState.unvalid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    }

    emit(state.copyWith(secondPageDataValid: checkSecondPageDataValid()));
  }

  void validateStoreNumber(
      ValidateStoreNumberEvent event, Emitter<UserInfoState> emit) {
    RegExp regex = RegExp(r'^(0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4]|70))\d{7,8}$');
    if (regex.hasMatch(event.storeNumber)) {
      emit(state.copyWith(
          isStoreNumberEffective: ValidateState.valid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else if (event.storeNumber.isEmpty) {
      emit(state.copyWith(
          isStoreNumberEffective: ValidateState.initial,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else {
      emit(state.copyWith(
          isStoreNumberEffective: ValidateState.unvalid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    }

    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  void validatePhoneNumber(
      ValidatePhoneNumberEvent event, Emitter<UserInfoState> emit) {
    RegExp regex = RegExp(r'^01[0|1|6|7|8|9]\d{7,8}$');
    if (regex.hasMatch(event.phoneNumber)) {
      emit(state.copyWith(
          isPhoneNumberEffective: ValidateState.valid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else if (event.phoneNumber.isEmpty) {
      emit(state.copyWith(
          isPhoneNumberEffective: ValidateState.initial,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    } else {
      emit(state.copyWith(
          isPhoneNumberEffective: ValidateState.unvalid,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    }

    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  void checkPasswordDuplicated(
      CheckPasswordSame event, Emitter<UserInfoState> emit) {
    if (event.password.isNotEmpty) {
      if (event.password == event.passwordCheck) {
        emit(state.copyWith(
            isPasswordSame: ValidateState.valid,
            signUpErrorType: '',
            signUpState: RequestState.initial));
      } else {
        emit(state.copyWith(
            isPasswordSame: ValidateState.unvalid,
            signUpErrorType: '',
            signUpState: RequestState.initial));
      }
    } else {
      emit(state.copyWith(
          isPasswordSame: ValidateState.initial,
          signUpErrorType: '',
          signUpState: RequestState.initial));
    }

    emit(state.copyWith(secondPageDataValid: checkSecondPageDataValid()));
  }

  bool checkSecondPageDataValid() {
    if (state.storeName.isNotEmpty &&
        state.name.isNotEmpty &&
        state.idUnique == ValidateState.valid &&
        state.isIdEffective == ValidateState.valid &&
        state.isPasswordEffective == ValidateState.valid &&
        state.isPasswordSame == ValidateState.valid) {
      return true;
    } else {
      return false;
    }
  }

  void inputStoreNumber(
      InputStoreNumberEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        storeNumber: event.storeNumber,
        signUpErrorType: '',
        signUpState: RequestState.initial));

    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  void inputPhoneNumber(
      InputPhoneNumberEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        phoneNumber: event.phoneNumber,
        signUpErrorType: '',
        signUpState: RequestState.initial));
    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  void inputCompanyRegistrationNumber(
      InputCompanyRegistrationNumberEvent event, Emitter<UserInfoState> emit) {
    emit(state.copyWith(
        companyRegistrationNumber: event.first + event.second + event.third,
        signUpErrorType: '',
        signUpState: RequestState.initial));
    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  Future<void> getImageFromGallery(
      GetImageFromGallery event, Emitter<UserInfoState> emit) async {
    XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    File? image = state.companyRegistrationImage;

    if (photo != null) {
      image = File(photo.path);
    }

    emit(state.copyWith(
        companyRegistrationImage: image,
        signUpErrorType: '',
        signUpState: RequestState.initial));
    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  Future<void> getImageFromCamera(
      GetImageFromCamera event, Emitter<UserInfoState> emit) async {
    XFile? colorPhoto = await picker.pickImage(source: ImageSource.camera);
    File? image = state.companyRegistrationImage;

    if (colorPhoto != null) {
      image = File(colorPhoto.path);
    }

    emit(state.copyWith(
        companyRegistrationImage: image,
        signUpErrorType: '',
        signUpState: RequestState.initial));
    emit(state.copyWith(thirdPageDataValid: checkThirdPageDataValid()));
  }

  bool checkThirdPageDataValid() {
    if (state.isPhoneNumberEffective == ValidateState.valid &&
        state.isStoreNumberEffective == ValidateState.valid &&
        state.phoneNumber.isNotEmpty &&
        state.companyRegistrationImage != null &&
        state.companyRegistrationNumber.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> clickSignUp(
      ClickSignUpButtonEvent event, Emitter<UserInfoState> emit) async {
    String s3ImageUrl;
    Map response;
    Map body;
    emit(
        state.copyWith(signUpState: RequestState.initial, signUpErrorType: ""));
    s3ImageUrl = await signUpRepository
        .registusinessRegistrationImage(state.companyRegistrationImage!.path);

    body = {
      'username': state.username,
      'password': state.password,
      'name': state.storeName,
      'company_registration_number': state.companyRegistrationNumber,
      'business_registration_image_url': s3ImageUrl,
      'mobile_number': state.phoneNumber,
      'phone_number': state.storeNumber,
      'email': state.email,
      'zip_code': storeLocationBloc.state.zipCode,
      'base_address': storeLocationBloc.state.baseAddress,
      'detail_address': storeLocationBloc.state.selectedBuilding +
          " " +
          storeLocationBloc.state.selectedFloor +
          " " +
          storeLocationBloc.state.inputRoom,
    };
    print(body);
    response = await signUpRepository.signUpRequest(body);

    switch (response['code']) {
      case 201:
        emit(state.copyWith(signUpState: RequestState.success));
        break;
      case 400:
        if (response['message']['non_field_errors'][0] ==
            "The similarity between password and username is too large.") {
          emit(state.copyWith(
              signUpState: RequestState.failure,
              signUpErrorType: "아이디와 비밀번호가 유사합니다."));
          return;
        }
        emit(state.copyWith(
          signUpState: RequestState.failure,
        ));
        break;
      default:
    }
  }
}
