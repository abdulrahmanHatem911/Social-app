import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant/style/color.dart';
import 'package:social_app/constant/style/icon_broken.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_cubit.dart';
import 'package:social_app/modules/screens/Layout/cubit/layout_state.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // vaarible for cubit
        var cubit = SocialCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      const Image(
                        image: NetworkImage(
                            'https://i.pinimg.com/564x/22/95/1d/22951db4c4a6b4bbecd4a491ba23394d.jpg'),
                        fit: BoxFit.cover,
                        height: 150.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Commmictaa flose sdffwe sdfasdasd',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return builtPostItem(
                      cubit.posts[index],
                      context,
                      index,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8.0),
                  itemCount: cubit.posts.length,
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget builtPostItem(
    PostModel model,
    BuildContext context,
    index,
  ) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name} ',
                            style: const TextStyle(
                              height: 1.4,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(width: 7.0),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 14.0,
                          )
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            // the line
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.3,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 10.0),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         // الهشتاج
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 7.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#softwar',
            //                 style: TextStyle(
            //                   color: Colors.blue[600],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 7.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#softwar',
            //                 style: TextStyle(
            //                   color: Colors.blue[600],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 7.0,
            //           ),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#softwar',
            //                 style: TextStyle(
            //                   color: Colors.blue[600],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  // for like
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // for commint
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              '${SocialCubit.get(context).comments[index]} comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //the line two
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.3,
                color: Colors.grey[300],
              ),
            ),
            // the write commint
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SocialCubit.get(context).commentPosts(
                          SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}',
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Text(
                          'Write comment ....',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePosts(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
