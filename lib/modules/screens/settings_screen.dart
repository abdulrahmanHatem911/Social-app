import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/const.dart';
import 'package:social_app/constant/style/icon_broken.dart';
import 'package:social_app/models/soical_user_model.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_cubit.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';
import 'package:social_app/modules/screens/edit_profil_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        //the cover image
        var caverImage = cubit.coverImage;
        var profileImage = cubit.profileImage;

        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 180.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: caverImage == null
                                    ? NetworkImage('${userModel!.cover}')
                                    : FileImage(caverImage) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 54.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: profileImage == null
                                ? NetworkImage('${userModel!.image}')
                                : FileImage(profileImage) as ImageProvider,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '${userModel!.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Center(
                    child: Text(
                      '${userModel.bio}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '72',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.grey.shade300,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '430',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.grey.shade300,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '105K',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.grey.shade300,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '16',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Followings',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.grey.shade300,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              'Add photo',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: const Icon(
                          IconBroken.Edit,
                          size: 18.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          fallback: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
