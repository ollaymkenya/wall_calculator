import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final int bricksNeeded;
  final double totalCost;
  final submitData;
  final GlobalKey<FormState> formKey;

  const BottomSheetWidget(
      {Key? key,
      required this.submitData,
      required this.bricksNeeded,
      required this.totalCost,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Calculate'),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          showBottomSheet(
            context: context,
            builder: (context) => SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    'Bricks: $bricksNeeded',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Cost: $totalCost',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          submitData();
                          Navigator.pushReplacementNamed(context, '/');
                        },
                      ),
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
