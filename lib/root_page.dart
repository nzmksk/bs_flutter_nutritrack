import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/cubits.dart';
import 'pages/pages.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AppBarTitleCubit, AppBarTitleState>(
          builder: (context, state) {
            return Text(state.appBarTitle);
          },
        ),
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state.navBarItem) {
            case NavBarItem.nutrition:
              return const NutritionPage();
            case NavBarItem.exercise:
              return const ExercisePage();
            case NavBarItem.logs:
              return const HomePage();
            case NavBarItem.summary:
              return const SummaryPage();
            case NavBarItem.profile:
              return const ProfilePage();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_outlined),
                label: 'Nutrition',
                // tooltip: 'Food nutrition info',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_outlined),
                label: 'Exercise',
                // tooltip: 'Exercise calories info',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note_outlined),
                label: 'Logs',
                // tooltip: 'Calorie logs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline_outlined),
                label: 'Summary',
                // tooltip: 'Report summary',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                label: 'Profile',
                // tooltip: 'Personal info',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: state.currentIndex,
            onTap: (index) {
              BlocProvider.of<AppBarTitleCubit>(context).getAppBarTitle(index);
              switch (index) {
                case 0:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.nutrition);
                  break;
                case 1:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.exercise);
                  break;
                case 2:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.logs);
                  break;
                case 3:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.summary);
                  break;
                case 4:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavBarItem.profile);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
