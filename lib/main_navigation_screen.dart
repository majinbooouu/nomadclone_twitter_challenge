import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_challenge/authentication/repos/authentication_repo.dart';
import 'package:twitter_clone_challenge/write/views/write_screen.dart';

class MainNavScreen extends ConsumerStatefulWidget {
  static const routeName = "home";
  static const routeURL = "/";
  final String tab;

  const MainNavScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends ConsumerState<MainNavScreen> {
  final List<String> _tabs = [
    "home",
    "write",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    setState(() {});
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    ref.read(authRepo).signOut();
                    context.go("/signin");
                  },
                  icon: const FaIcon(FontAwesomeIcons.gear),
                ),
              ],
              title: const Text("🔥MOOD🔥"),
              elevation: 0,
              // backgroundColor: Theme.of(context).colorScheme.onPrimary,
            )
          : null,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const Center(child: Text("Post Screen")),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: WriteScreen(onTapCallback: _onTap),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => _onTap(value),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.house,
              ),
              selectedIcon: FaIcon(
                FontAwesomeIcons.house,
              ),
              label: 'home'),
          NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.penToSquare,
              ),
              selectedIcon: FaIcon(
                FontAwesomeIcons.penToSquare,
              ),
              label: 'add'),
        ],
      ),
    );
  }
}
