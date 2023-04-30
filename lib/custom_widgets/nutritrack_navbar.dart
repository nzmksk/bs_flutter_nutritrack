import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';

class NutriTrackNavBar extends StatelessWidget {
  const NutriTrackNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu_outlined),
              label: 'Nutrition',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined),
              label: 'Exercise',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined),
              label: 'Logs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline_outlined),
              label: 'Summary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              label: 'Profile',
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
    );
  }
}
