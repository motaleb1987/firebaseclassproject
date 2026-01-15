import 'package:flutter/material.dart';
class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              
              title: Text('This is new task '),
              subtitle: Text('This is new task '),
              trailing: Icon(Icons.edit),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade100,
        onPressed: (){}, child: Icon(Icons.add),
      ),
    );
  }
}
