import 'dart:io';

import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:favorite_places/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      // showDialog(
      //   context: context,
      //   builder: (ctx) {
      //     return AlertDialog(
      //       title: Text('Error'),
      //       content: Text('Please enter a title'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(ctx).pop();
      //           },
      //           style: TextButton.styleFrom(
      //             foregroundColor: Theme.of(context).colorScheme.onPrimary,
      //           ),
      //           child: const Text('Okay'),
      //         ),
      //       ],
      //     );
      //   },
      // );
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: ('Title'),
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const Gap(12),
            // Image Input
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const Gap(10),
            const LocationInput(),
            const Gap(16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
            ),
          ],
        ),
      ),
    );
  }
}

