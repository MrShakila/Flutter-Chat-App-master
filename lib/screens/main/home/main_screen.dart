import 'package:animate_do/animate_do.dart';

import 'package:chat_app_2/screens/main/users/users_list.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../components/custom_text.dart';
import '../../../utils/app_colors.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  //screen List
  final List<Widget> _screens = [const Home(), const UserList()];

  Future<bool> initBackButton() async {
    Logger().d('back button pressed');
    return await showDialog(
          context: context,
          builder: (context) => ElasticIn(
            child: AlertDialog(
              title: const CustomText(text: 'Exit App'),
              content:
                  const CustomText(text: 'Do you really want to exit an App ?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const CustomText(text: 'No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const CustomText(text: 'Yes'),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: initBackButton,
      child: Scaffold(
        backgroundColor: kmainBg,
        body: _screens.elementAt(_currentIndex),
        bottomNavigationBar: Container(
          height: 90,
          color: kWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavTile(
                icon: const Icon(
                  Icons.chat,
                  size: 25,
                ),
                isSelected: _currentIndex == 0,
                ontap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              BottomNavTile(
                icon: const Icon(
                  Icons.people,
                  size: 25,
                ),
                isSelected: _currentIndex == 1,
                ontap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavTile extends StatelessWidget {
  const BottomNavTile({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.ontap,
  }) : super(key: key);

  final Icon icon;
  final bool isSelected;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : kWhite,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
