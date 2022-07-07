// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/const.dart';
import 'package:social_app/constant/style/icon_broken.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_cubit.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';
import 'package:social_app/modules/screens/login/cubit/loginState.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel;
        // the profile image
        var profileImage = SocialCubit.get(context).profileImage;
        // the cover image
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5.0,
            title: const Text('Edit Profile'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                    uploadName: nameController.text,
                    uploadPhone: phoneController.text,
                    uploadBio: bioController.text,
                  );
                },
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUploadLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUploadLoadingState)
                    const SizedBox(height: 10.0),
                  SizedBox(
                    height: 180.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.blue.withOpacity(0.7),
                                  child: const Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // to tack the profile image
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            // for change the pickter
                            CircleAvatar(
                              radius: 54.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blue.withOpacity(0.7),
                                child: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  title: 'Upload Profile',
                                  buttonColor: Colors.purple.shade300,
                                  function: () {
                                    cubit.uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                ),
                                if (state is SocialUploadLoadingState)
                                  const SizedBox(height: 5.0),
                                if (state is SocialUploadLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (cubit.coverImage != null)
                          const SizedBox(width: 10.0),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  title: 'Upload Cover',
                                  buttonColor: Colors.purple.shade300,
                                  function: () {
                                    cubit.uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                ),
                                if (state is SocialUploadLoadingState)
                                  const SizedBox(height: 5.0),
                                if (state is SocialUploadLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    const SizedBox(height: 10.0),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.User),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      hintText: 'Enter your Bio ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Info_Circle),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Bio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // text hhfield for phone
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      hintText: 'Enter your phone ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(IconBroken.Call),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
