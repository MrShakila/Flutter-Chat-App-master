import 'package:chat_app_2/controllers/chat/chat_controller.dart';
import 'package:chat_app_2/provider/auth_provider.dart';
import 'package:chat_app_2/provider/chat/chat_provider.dart';
import 'package:chat_app_2/screens/main/chat/chat.dart';
import 'package:chat_app_2/utils/util_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../components/custom_text.dart';
import '../../../models/objects.dart';
import '../../../utils/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ConverstionModel> list = [];
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
              stream: ChatContoroller().getConverstions(value.user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("No Converstions Found"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                list.clear();
                for (var item in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      item.data() as Map<String, dynamic>;

                  var model = ConverstionModel.fromJson(data);

                  list.add(model);
                }
                Logger().d(snapshot.data!.docs.length);
                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ConverstionCard(
                          model: list[index],
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: list.length);
              }),
        ),
      ),
    );
  }
}

class ConverstionCard extends StatelessWidget {
  const ConverstionCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ConverstionModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false).setConv(model);
        UtilFunctions.navigateTo(
            context,
            Chat(
              convId: model.id,
            ));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(
            color: kWhite,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10), blurRadius: 20, color: Colors.black12),
            ],
          ),
          child: Consumer<AuthProvider>(
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 58,
                        width: 58,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image.network(model.userarray
                              .firstWhere(
                                  (element) => element.uid != value.user.uid)
                              .img),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: model.userarray
                                .firstWhere(
                                    (element) => element.uid != value.user.uid)
                                .name,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: model.lastMessege,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      )
                    ],
                  ),
                  CustomText(
                    text: timeago.format(DateTime.parse(model.lastmessgetime)),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: greyColor,
                  ),
                ],
              );
            },
          )),
    );
  }
}
