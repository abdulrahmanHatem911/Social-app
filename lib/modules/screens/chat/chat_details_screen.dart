import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/soical_user_model.dart';

import '../../../constant/style/color.dart';
import '../../../constant/style/icon_broken.dart';
import '../../../models/messag/messge_model.dart';
import '../Layout/cubit/layout_cubit.dart';
import '../Layout/cubit/layout_state.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;
  ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);
// controller for message
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      // function for get message
      SocialCubit.get(context).getMessage(
        receiverId: userModel.uid,
      );
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // cubit
          var cubit = SocialCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  const SizedBox(width: 15.0),
                  Text('${userModel.name}'),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.messages.length > 0 || cubit.userModel != null,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = cubit.messages[index];
                            if (cubit.userModel!.uid == message.senderId) {
                              return buildSendMessage(message, context);
                            }
                            return buildReceiverMessage(message, context);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 15.0);
                          },
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      // button
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here...',
                                    hintStyle:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            // the send button
                            Container(
                              color: defaultColor,
                              child: MaterialButton(
                                minWidth: 1.0,
                                onPressed: () {
                                  cubit.sendMessage(
                                    receiverId: userModel.uid,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                child: const Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                  size: 17.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
      );
    });
  }

// receiver message
  Widget buildReceiverMessage(MessageModel model, context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        child: Text(
          '${model.text}',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  // send message
  Widget buildSendMessage(MessageModel model, context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        child: Text(
          '${model.text}',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
