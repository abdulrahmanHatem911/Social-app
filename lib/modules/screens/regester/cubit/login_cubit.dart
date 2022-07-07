// ignore_for_file: unnecessary_import, avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/soical_user_model.dart';
import 'package:social_app/modules/screens/regester/cubit/login_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

// to create a new user in cloud firbase

  //SocialLoginModel? loginModel;

  // to register in firbase
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        userName: name,
        userEmail: email,
        userPhone: phone,
        userUid: value.user!.uid,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error));
      print(error.toString());
    });
  }

  void userCreate({
    required String userName,
    required String userEmail,
    required String userPhone,
    required var userUid,
  }) {
    // بتستدعب المودل و بعدين تبعتله البيانات و بعدين تجيب اليمودل و تبعته للفير بيز
    SocialUserModel model = SocialUserModel(
      name: userName,
      email: userEmail,
      image:
          'https://i.pinimg.com/236x/f2/b2/cc/f2b2cc4648754fe1cc8a5ce5ae281760.jpg',
      cover:
          'https://i.pinimg.com/236x/5b/44/9f/5b449f81bc139e1a195a4712a422112d.jpg',
      bio: 'the first bio',
      phone: userPhone,
      uid: userUid,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(
        SocialCreateUserSuccessState(),
      );
    }).catchError((error) {
      emit(
        SocialCreateUserErrorState(error),
      );
    });
  }

  // to change the icon for password
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
