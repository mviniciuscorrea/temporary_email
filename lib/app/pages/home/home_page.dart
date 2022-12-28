import 'package:email_temporario/app/pages/home/controller/home_controller.dart';
import 'package:email_temporario/app/pages/home/widgets/appbar_widget.dart';
import 'package:email_temporario/app/pages/home/widgets/bottom_navigation_widget.dart';
import 'package:email_temporario/app/pages/home/widgets/header_widget.dart';
import 'package:email_temporario/app/pages/home/widgets/list_emails_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.style.backgroundColor(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBarWidget(),
      ),
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.getAllMessages(showLoading: false),
              child: const CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: ListEmailsWidget(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
