import 'package:flutter/material.dart';
import 'package:to_do/shared/cubit/cubit.dart';
buildTaskItem(Map record,context)
{
  GlobalKey dismissKey = GlobalKey();
  return Dismissible(
    key: dismissKey,
    onDismissed: (direction) {
      AppCubit.get(context).deleteDataFromDB(id: record['id']);
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children:  [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blue,
            child: Text(
              '${record['time']}',
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  '${record['title']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '${record['date']}',
                  style: const  TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: (){
              AppCubit.get(context).updateDatabase(status: 'done', id: record['id']);
            },
            icon: const Icon(Icons.check_box),
            color: Colors.green,
          ),
          IconButton(
            onPressed: (){
              AppCubit.get(context).updateDatabase(status: 'archived', id: record['id']);
            },
            icon: const Icon(Icons.archive_outlined),
            color: Colors.black45,
          ),
        ],
      ),
    ),
  );
}
Widget forEmpty()
{
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:const [
        Icon(Icons.menu,color: Colors.grey,size: 100),
        Text(
          'no tasks yet,please add new tasks..',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
        )
      ],
    ),
  );
}