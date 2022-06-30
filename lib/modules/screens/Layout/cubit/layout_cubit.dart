import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constant/const.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/soical_user_model.dart';
import 'package:social_app/models/user/user_model.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';
import 'package:social_app/modules/screens/chat/chats_screen.dart';
import 'package:social_app/modules/screens/feeds_screen.dart';
import 'package:social_app/modules/screens/new_post_screen.dart';
import 'package:social_app/modules/screens/settings_screen.dart';
import 'package:social_app/modules/screens/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  // to get data from database in firbase
  void getUserDate() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // to get date
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(
        SocialGetUserSuccessState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        SocialGetUserErrorState(error.toString()),
      );
    });
  }

// to change the screen in bottom van
  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titlsScreen = [
    'Home',
    'Chats',
    'post',
    'Users',
    'Setting',
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostNavState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  // to choose image for profile
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileImage = File(pickedFile!.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImageErrorState());
    }
  }

  // to choose image for Cover
  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      coverImage = File(pickedFile!.path);
      emit(SocialCoverImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImageErrorState());
    }
  }

  // to upload image in storage

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUserData(
          uploadName: name,
          uploadPhone: phone,
          uploadBio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // to upload image cover in storage

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUserData(
          uploadName: name,
          uploadPhone: phone,
          uploadBio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // the function for update

  // void updateUserImage({
  //   required String uploadName,
  //   required String uploadPhone,
  //   required String uploadBio,
  // }) {
  //   emit(SocialUploadLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUserData(
  //       uploadName: uploadName,
  //       uploadPhone: uploadPhone,
  //       uploadBio: uploadBio,
  //     );
  //   }
  // }

  // update user data only
  void updateUserData({
    required String uploadName,
    required String uploadPhone,
    required String uploadBio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
      name: uploadName,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      bio: uploadBio,
      phone: uploadPhone,
      uid: userModel!.uid,
      isEmailVerified: userModel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserDate();
    }).catchError((error) {
      emit(SocialUploadErrorState());
    });
  }

  // for crate new post
  File? postImage;

  Future<void> getpostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      postImage = File(pickedFile!.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

// to remove the post image

  void removePostImage() {
    postImage = null;
    emit(SocialPostImagePickedRemoveState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uid,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  // to get posts from firebase
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      emit(SocialGetPostsSuccessState());
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          comments.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  // to make a like in the post

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

  // to comment in the post
  void commentPosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uid)
        .set({
      'comment': 'my comment',
    }).then((value) {
      emit(SocialCommentPostsSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostsErrorState(error.toString()));
    });
  }

  // to get all user in chat screen

  List<SocialUserModel> users = [];
  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        emit(SocialGetAllUsersSuccessState());
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel!.uid) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }
}
