import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Seasons'),
            onTap: () => Get.toNamed('/seasons'),
          ),
          ListTile(
            title: const Text('Drivers'),
            onTap: () => Get.toNamed('/drivers'),
          ),
        ],
      ),
    );
  }
}
