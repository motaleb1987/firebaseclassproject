import 'package:flutter/material.dart';
class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  void showTaskDialog(BuildContext context){
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    showDialog(context: context, builder: (_)=>AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task title'
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'description'
              ),
            ),
            
          ],
        ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),
        ElevatedButton(onPressed: (){}, child: Text('Add'))
      ],
      
    ));
  }


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
              leading: Checkbox(value: false, onChanged: (val){}),
              trailing: Icon(Icons.edit),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade100,
        onPressed: (){
          showTaskDialog(context);
        }, child: Icon(Icons.add),
      ),
    );
  }
}
