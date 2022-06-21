import 'package:chat_app_2/models/objects.dart';
import 'package:chat_app_2/provider/auth_provider.dart';
import 'package:chat_app_2/provider/chat/chat_provider.dart';
import 'package:chat_app_2/utils/app_colors.dart';
import 'package:chat_app_2/utils/util_functions.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../components/custom_text.dart';
import '../../../controllers/chat/chat_controller.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.convId}) : super(key: key);

  final String convId;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<MessageModel> list = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height / 12),
        child: const SafeArea(
          child: AppBarSection(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: ChatContoroller().getMesseges(widget.convId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("No Messeges Found"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  list.clear();
                  for (var item in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        item.data() as Map<String, dynamic>;

                    var model = MessageModel.fromJson(data);

                    list.add(model);
                  }
                  Logger().d(snapshot.data!.docs.length);
                  return list.isEmpty
                      ? const Center(child: Text("No Messeges Found"))
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: list.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Consumer<AuthProvider>(
                              builder: (context, value, child) {
                                return ChatMessegeWidget(
                                  model: list[index],
                                  isSender: list[index].senderId ==
                                      value.usermodel.uid,
                                );
                              },
                            );
                          });
                }),
          ),
          const MessegeTypingWidgest(),
        ],
      ),
    );
  }
}

class ChatMessegeWidget extends StatelessWidget {
  final bool isSender;
  final MessageModel model;

  const ChatMessegeWidget({
    Key? key,
    required this.isSender,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        BubbleSpecialThree(
          text: model.messege,
          color: isSender ? kPrimaryColor : greyColor,
          tail: true,
          isSender: isSender,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Padding(
          padding: isSender
              ? const EdgeInsets.only(right: 24)
              : const EdgeInsets.only(left: 24),
          child: CustomText(
            text: timeago.format(DateTime.parse(model.massegetime)),
            fontSize: 15,
            color: greyColor,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class MessegeTypingWidgest extends StatelessWidget {
  const MessegeTypingWidgest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, value, child) {
        return SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextField(
                            controller: value.messegeController,
                            decoration: const InputDecoration(
                                hintText: "Write Your Messege Here",
                                border: InputBorder.none)),
                      )),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        value.sendMessege(context);
                      },
                      icon: const Icon(Icons.send),
                    ))
              ],
            ));
      },
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(child: Consumer2<ChatProvider, AuthProvider>(
        builder: (context, value, value2, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      UtilFunctions.goBack(context);
                    }),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 58,
                    width: 58,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(value.conv.userarray
                            .firstWhere(
                                (element) => element.uid != value2.user.uid)
                            .img)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: value.conv.userarray
                            .firstWhere(
                                (element) => element.uid != value2.user.uid)
                            .name,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const CustomText(
                        text: "Online ",
                        fontSize: 15,
                        color: greyColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  )
                ],
              ),
              const Icon(Icons.attach_file)
            ],
          );
        },
      )),
    );
  }
}
