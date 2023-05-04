// import 'package:flutter/material.dart';

// import '../../custom_widgets/custom_widgets.dart';

// final _formKey = GlobalKey<FormState>();

// class AddExercise extends StatelessWidget {
//   const AddExercise({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Exercise'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: IconButton(
//               icon: const Icon(Icons.search_outlined),
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: ExerciseSearchDelegate(),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text('Search exercise'),
//       ),
//     );
//   }
// }
