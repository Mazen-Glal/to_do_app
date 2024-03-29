import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/shared/components/components.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) => AppCubit.get(context).archivedTasks.isEmpty ? forEmpty() :  ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).archivedTasks[index],context),
          separatorBuilder: (context, index) =>  Container(height: 1,color: Colors.grey[200]),
          itemCount: AppCubit.get(context).archivedTasks.length,
        physics: const BouncingScrollPhysics(),

      ),
    );
  }


}
