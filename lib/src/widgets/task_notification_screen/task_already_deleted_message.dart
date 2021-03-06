import 'package:flutter/material.dart';
import 'package:task_manager_app/src/styles/styles.dart';
import 'package:task_manager_app/src/widgets/task_notification_screen/notification_screen_flat_button.dart';

class TaskAlreadyDeletedMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'This task was deleted from the database.',
            style: TextStyles.whiteBodyTextStyle.copyWith(fontSize: 22.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60.0),
          NotificationScreenFlatButton(
            buttonText: 'GO BACK',
            buttonHeight: 60.0,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
