import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.offAllNamed('/');
            },
            selected: Get.currentRoute == '/',
          ),
          ListTile(
            leading: const Icon(Icons.sports_motorsports),
            title: const Text('Drivers'),
            onTap: () {
              Get.toNamed('/drivers');
            },
            selected: Get.currentRoute == '/drivers',
          ),
        ],
      ),
    );
  }
}
