import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';

class ExpandableFAB extends StatelessWidget {
  const ExpandableFAB({
    super.key,
    this.initialOpen,
    // required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  // final double distance;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpandableFABCubit, ExpandableFABState>(
      builder: (context, state) {
        return SizedBox.expand(
          child: Stack(
            alignment: Alignment.bottomRight,
            clipBehavior: Clip.none,
            children: [
              _buildTapToCollapseFAB(context),
              _buildTapToExpandFAB(state, context),
            ],
          ),
        );
      },
    );
  }

  SizedBox _buildTapToCollapseFAB(BuildContext context) {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              BlocProvider.of<ExpandableFABCubit>(context).toggleButton();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IgnorePointer _buildTapToExpandFAB(
      ExpandableFABState state, BuildContext context) {
    return IgnorePointer(
      ignoring: state.isOpened,
      // Cross-fade animation
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          state.isOpened ? 0.7 : 1.0,
          state.isOpened ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeOut,
        ),
        child: AnimatedOpacity(
          opacity: state.isOpened ? 0.0 : 1.0,
          curve: const Interval(
            0.25,
            1.0,
            curve: Curves.easeOut,
          ),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<ExpandableFABCubit>(context).toggleButton();
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
