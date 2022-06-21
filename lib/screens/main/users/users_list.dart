import 'package:chat_app_2/controllers/user/user_controller.dart';
import 'package:chat_app_2/models/objects.dart';
import 'package:chat_app_2/provider/auth_provider.dart';
import 'package:chat_app_2/provider/chat/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../components/custom_text.dart';
import '../../../utils/app_colors.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserModel> list = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhite,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Consumer<AuthProvider>(
              builder: (context, value, child) => CustomText(
                    text: value.user.displayName.toString(),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
          actions: [
            Consumer<AuthProvider>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          value.logOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: kBlack,
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        value.user.photoURL.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.only(top: 13),
          child: Consumer<AuthProvider>(
              builder: (context, value, child) => StreamBuilder<QuerySnapshot>(
                  stream: UserContoller().getUsers(value.user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("No Users Found");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    list.clear();
                    for (var item in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          item.data() as Map<String, dynamic>;

                      var model = UserModel.fromJson(data);

                      list.add(model);
                    }
                    Logger().d(snapshot.data!.docs.length);
                    return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => UserCard(
                              model: list[index],
                            ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: list.length);
                  })),
        ));
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: const BoxDecoration(
          color: kWhite,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10), blurRadius: 20, color: Colors.black12),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 58,
                    width: 58,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(model.img))),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: model.name,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        model.isOnline
                            ? const Icon(
                                Icons.circle,
                                color: kGreen,
                                size: 11,
                              )
                            : const Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: 11,
                              )
                      ],
                    ),
                    CustomText(
                      text: timeago.format(DateTime.parse(model.lastSeen)),
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: greyColor,
                    ),
                  ],
                )
              ],
            ),
            Consumer<ChatProvider>(
              builder: (context, value, child) {
                return value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: () {
                          value.crerateConverstions(model, context);
                        },
                        icon: const Icon(Icons.chat),
                        label: const CustomText(
                          text: "Start Chat",
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: kWhite,
                        ),
                      );
              },
            )
          ],
        ));
  }
}
