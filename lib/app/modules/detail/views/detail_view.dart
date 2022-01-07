import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rick_and_morty/app/modules/home/controllers/home_controller.dart';

class DetailView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
