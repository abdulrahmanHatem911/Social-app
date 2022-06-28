import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/style/icon_broken.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_cubit.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // cubit

        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create post'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // time now
                  var nowDate = DateTime.now();
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        dateTime: nowDate.toString(),
                        text: textController.text);
                  } else {
                    cubit.uploadPostImage(
                      dateTime: nowDate.toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text('Post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(height: 10.0),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/564x/af/7a/1a/af7a1ac8729932ec8f8dccfcb3288fa0.jpg'),
                    ),
                    const SizedBox(width: 18.0),
                    Expanded(
                      child: Text(
                        'Abdulrahman ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16.0,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind ?! .',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: cubit.postImage == null
                                ? const NetworkImage(
                                    'https://images.unsplash.com/photo-1472457897821-70d3819a0e24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8ZnVubnl8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60')
                                : FileImage(cubit.postImage!) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blue.withOpacity(0.7),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getpostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'add image',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '#  tags',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
