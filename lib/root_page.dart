import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/cubits.dart';
import 'custom_widgets/custom_widgets.dart';
import 'pages/pages.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AppBarTitleCubit, AppBarTitleState>(
          builder: (context, state) => Text(state.appBarTitle),
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
              return const LogsPage();
            case NavBarItem.summary:
              return const SummaryPage();
            case NavBarItem.profile:
              return const ProfilePage();
          }
        },
      ),
      floatingActionButton: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return state.navBarItem == NavBarItem.logs
              ? NutriTrackExpandableFab(
                  distance: 112.0,
                  children: [
                    NutriTrackActionButton(
                      icon: const Icon(Icons.dining_outlined),
                      tooltip: 'Add calorie intake',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddFood(),
                          ),
                        );
                      },
                    ),
                    const NutriTrackActionButton(
                      icon: Icon(Icons.fitness_center_outlined),
                      tooltip: 'Add calorie burnt',
                      // onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const AddExercise(),
                      //   ),
                      // );
                      // },
                    ),
                    const NutriTrackActionButton(
                      icon: Icon(Icons.monitor_weight_outlined),
                      tooltip: 'Update weight',
                    ),
                  ],
                )
              : Container();
        },
      ),
      bottomNavigationBar: const NutriTrackNavBar(),
    );
  }
}
