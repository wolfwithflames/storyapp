import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyapp/ui/views/home/home_view_model.dart';
import 'package:storyapp/ui/views/home/widgets/bottom_nav_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      child: ChangeNotifierProvider<HomeVM>(
        create: (BuildContext context) => HomeVM(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: const Center(
            child: Text("Home"),
          ),
          bottomSheet: Consumer<HomeVM>(
            builder: (context, data, child) {
              return BottomNavigationPanel(
                onNavItemTap: data.changeSelectedIndex,
                selectedIndex: data.selectedIndex,
              );
            },
          ),
        ),
      ),
    );
  }
}
