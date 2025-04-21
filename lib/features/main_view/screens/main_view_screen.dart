import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:task/features/main_view/bloc/main_view_bloc.dart';
import 'package:task/features/main_view/widgets/blogs_widget.dart';
import 'package:task/features/main_view/widgets/bottom_navigation_bar.dart';
import 'package:task/features/menu/widgets/menu_widget.dart';
import 'package:task/global/methods_helpers_functions/Isolates.dart';

class MainViewScreen extends StatefulWidget {
  const MainViewScreen({
    super.key,
    required this.isFromRegistration,
    required this.isNew,
    required this.userId,
  });

  final bool isFromRegistration;

  final bool isNew;
  final String userId;

  @override
  State<MainViewScreen> createState() => _MainViewScreenState();
}

class _MainViewScreenState extends State<MainViewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MainViewBloc>().add(FetchBlogs(query: '', context: context));
    pageController = PageController(initialPage: 0);

    SchedulerBinding.instance.addPostFrameCallback((e)  {
      Future.delayed(Duration(seconds: 5), () {
        if (widget.isFromRegistration) {
          Isolates.executeSendNotificationInBackground(
            widget.isNew,
            widget.userId,
          );
        }
      });
    });
  }

  int selectedIndex = 0;
  late PageController pageController;

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBarWidget(
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        selectedIndex: selectedIndex,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          BlogsWidget(),
          Center(child: Text("Notifications")),
          Center(child: Text("Requests")),
          MenuWidget(),
        ],
      ),
    );
  }
}
