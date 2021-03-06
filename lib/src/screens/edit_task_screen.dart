import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/src/core/utils/notification_to_reminder_conversion_utils.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:task_manager_app/src/models/reminder.dart';
import 'package:task_manager_app/src/models/task_with_reminders.dart';
import 'package:task_manager_app/src/providers.dart';
import 'package:task_manager_app/src/widgets/edit_task_screen/edit_task_screen_app_bar.dart';
import 'package:task_manager_app/src/widgets/edit_task_screen/edit_task_screen_body.dart';

final GlobalKey<EditTaskScreenBodyState> editTaskScreenBodyStateKey =
    GlobalKey<EditTaskScreenBodyState>();

class EditTaskScreen extends StatelessWidget {
  final Task task;

  const EditTaskScreen(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditTaskScreenAppBar(),
      body: Consumer(
        builder: (context, watch, _) {
          final taskNotificationsFuture =
              watch(notificationsDaoProvider).getTaskNotifications(task);

          return FutureBuilder(
            future: taskNotificationsFuture,
            builder: (context, AsyncSnapshot<List<Notification>> snapshot) {
              if (snapshot.hasData) {
                final listOfNotifications = snapshot.data;
                if (listOfNotifications.isNotEmpty) {
                  final List<Reminder> listOfReminders = makeListOfReminders(
                      task.allDayTask, task.startDate, listOfNotifications);

                  final taskWithReminders = TaskWithReminders(
                      task: task, listOfReminders: listOfReminders);
                  return EditTaskScreenBody(
                    key: editTaskScreenBodyStateKey,
                    taskWithReminders: taskWithReminders,
                  );
                } else {
                  final taskWithReminders = TaskWithReminders(
                      task: task, listOfReminders: List<Reminder>());
                  return EditTaskScreenBody(
                    key: editTaskScreenBodyStateKey,
                    taskWithReminders: taskWithReminders,
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
