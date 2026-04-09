import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/cubit/auth_state.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final shellContext = context;
    final authState = context.watch<AuthCubit>().state;
    final name = authState is AuthSuccess
        ? authState.user.name
        : AppStrings.drawerUserName;
    final email = authState is AuthSuccess
        ? authState.user.email
        : AppStrings.drawerUserEmail;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial && context.mounted) {
          context.go('/login');
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(name),
                accountEmail: Text(email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColors.background,
                  child: Text(name.isEmpty ? AppStrings.appName[0] : name[0]),
                ),
                decoration: BoxDecoration(color: AppColors.primary),
              ),
              _drawerItem(
                shellContext,
                AppStrings.settings,
                Icons.settings,
                '/settings',
              ),
              _drawerItem(
                shellContext,
                AppStrings.notifications,
                Icons.notifications_outlined,
                '/notifications',
              ),
              _drawerItem(
                shellContext,
                AppStrings.safety,
                Icons.shield_outlined,
                '/safety',
              ),
              _drawerItem(
                shellContext,
                AppStrings.roleSelection,
                Icons.swap_horiz,
                '/role-selection',
              ),
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.darkRed),
                title: Text(
                  AppStrings.logout,
                  style: TextStyle(color: AppColors.darkRed),
                ),
                onTap: () {
                  shellContext.pop();
                  shellContext.read<AuthCubit>().logout();
                },
              ),
            ],
          ),
        ),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          onTap: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: AppStrings.activity,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: AppStrings.map,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: AppStrings.wallet,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: AppStrings.account,
            ),
          ],
        ),
      ),
    );
  }

  ListTile _drawerItem(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title),
      onTap: () {
        context.pop();
        context.push(route);
      },
    );
  }
}
