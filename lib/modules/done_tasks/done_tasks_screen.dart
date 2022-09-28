import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/shared/components/components.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) => AppCubit.get(context).doneTasks.isEmpty ? forEmpty() : ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).doneTasks[index],context),
          separatorBuilder: (context, index) =>  Container(height: 1,color: Colors.grey[200]),
          itemCount: AppCubit.get(context).doneTasks.length
      ),
    );
  }


}
