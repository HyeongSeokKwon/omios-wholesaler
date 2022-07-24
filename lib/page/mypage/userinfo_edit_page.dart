import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';
import '../../util/util.dart';

class UserInfoEditPage extends StatefulWidget {
  final MypageBloc mypageBloc;
  const UserInfoEditPage({Key? key, required this.mypageBloc})
      : super(key: key);

  @override
  State<UserInfoEditPage> createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState extends State<UserInfoEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.mypageBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
              ),
              Text(
                "회원정보 수정",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 23.0),
              )
            ],
          ),
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: BlocBuilder<MypageBloc, MypageState>(
            builder: (context, state) {
              return Column(
                children: [
                  nameArea(),
                  SizedBox(height: 10 * Scale.height),
                  mobilePhoneNumberArea(),
                  SizedBox(height: 10 * Scale.height),
                  phoneNumberArea(),
                  SizedBox(height: 10 * Scale.height),
                  emailArea(),
                  SizedBox(height: 10 * Scale.height),
                  baseAddressArea(),
                  SizedBox(height: 10 * Scale.height),
                  detailAddressArea(),
                  SizedBox(height: 10 * Scale.height),
                  companyRegistrationNumber(),
                  patchButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget nameArea() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '매장 이름',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                maxLength: 11,
                initialValue: state.userInfoData['name'],
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  state.userInfoData['name'] = text;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget mobilePhoneNumberArea() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '핸드폰 번호',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                maxLength: 11,
                initialValue: state.userInfoData['mobile_number'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  state.userInfoData['mobile_number'] = text;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget phoneNumberArea() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '매장 전화번호',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                maxLength: 11,
                initialValue: state.userInfoData['phone_number'],
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  state.userInfoData['phone_number'] = text;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget emailArea() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '이메일',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                initialValue: state.userInfoData['email'],
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  state.userInfoData['email'] = text;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget baseAddressArea() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '기본 주소',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                maxLength: 11,
                initialValue: state.userInfoData['base_address'],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.streetAddress,
                onChanged: (text) {
                  state.userInfoData['base_address'] = text;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget detailAddressArea() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '상세 주소',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                maxLength: 11,
                initialValue: state.userInfoData['detail_address'],
                onChanged: (text) {
                  state.userInfoData['detail_address'] = text;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget companyRegistrationNumber() {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '사업자등록번호',
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 14.0),
              ),
              SizedBox(height: 3 * Scale.height),
              TextFormField(
                maxLength: 11,
                initialValue: state.userInfoData['company_registration_number'],
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  state.userInfoData['company_registration_number'] = text;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(
                    10 * Scale.width,
                    10 * Scale.height,
                    10 * Scale.width,
                    10 * Scale.height,
                  ),
                  counterText: "",
                  //errorText: errorText,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(color: Color(0xffcccccc), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 2 * Scale.width),
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget patchButton() {
    return BlocConsumer<MypageBloc, MypageState>(
      listener: ((context, state) {
        if (state.fetchStatus == FetchStatus.fetched) {
          showAlertDialog(context, "변경되었습니다");
        }
      }),
      builder: (context, state) {
        return InkWell(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.grey,
            child: const Text(
              "patch",
            ),
          ),
          onTap: () {
            context.read<MypageBloc>().add(ClickPatchButtonEvent());
          },
        );
      },
    );
  }
}
