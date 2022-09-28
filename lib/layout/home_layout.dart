import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                  title: Text(cubit.titles[cubit.currentIndex],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown == true) {
                    if (formKey.currentState!.validate())
                    {
                      cubit.insertToDatabase(
                              title: titleController.text,
                              date: dateController.text,
                              time: timeController.text)
                          .then((value) {
                            Navigator.pop(context);
                            cubit.changeFActionButton(bottomSheetShown: false, icon: Icons.add);
                            titleController.clear();
                            dateController.clear();
                            timeController.clear();
                          });
                    }
                  } else {
                    cubit.changeFActionButton(bottomSheetShown: false, icon: Icons.edit);
                    scaffoldKey.currentState
                        ?.showBottomSheet((context) => Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: titleController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'the title must be not Empty.';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'task title..',
                                          prefixIcon: Icon(Icons.title),
                                          // suffixIcon: Icon(Icons.edit),
                                          border: OutlineInputBorder()),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: timeController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'the time must be not Empty.';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) => {
                                                  timeController.text =
                                                      value!.format(context)
                                                });
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'task time..',
                                          prefixIcon:
                                              Icon(Icons.watch_later_outlined),
                                          // suffixIcon: Icon(Icons.edit),
                                          border: OutlineInputBorder()),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: dateController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'the date must be not Empty.';
                                        }
                                        return null;
                                      },
                                      enabled: true,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-10-01'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'task date..',
                                          prefixIcon: Icon(
                                              Icons.calendar_today_outlined),
                                          // suffixIcon: Icon(Icons.edit),
                                          border: OutlineInputBorder()),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .closed
                        .then((value) {
                      cubit.changeFActionButton(bottomSheetShown: false, icon: Icons.add);
                    });
                    cubit.isBottomSheetShown = true;
                  }
                },
                child: Icon(cubit.buttonIcon),
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.onChangeBottomSheetItem(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outlined), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archived'),
                ],
              ),
              body: cubit.screens[cubit.currentIndex]
          );
        },
      ),
    );
  }

}
