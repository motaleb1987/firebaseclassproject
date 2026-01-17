import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class TaskManager extends StatelessWidget {
   TaskManager({super.key});
   
   final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> updateTasks(String id, bool completed) async {
   await tasks.doc(id).update({
      'title':titleController.text,
      'description':descriptionController.text,
      'completed': completed,
    });
  }

   Future<void> updateStatusTasks(String id, bool completed) async {
     await tasks.doc(id).update({
       'completed': completed,
     });
   }

  Future<void> deleteTasks(String id) async {
    await tasks.doc(id).delete();
  }

  Future<void> addTasks() async{
    await tasks.add({
      'title':titleController.text,
      'description':descriptionController.text,
      'completed': false,
    });
    titleController.clear();
    descriptionController.clear();
  }

  void showTaskDialog(BuildContext context, [DocumentSnapshot ? doc]){

    //doc !=null 'Update Task': 'Add Task';
    if(doc != null){
      titleController.text = doc['title'];
      descriptionController.text = doc['description'];
    }else{
      titleController.clear();
      descriptionController.clear();
    }


    showDialog(context: context, builder: (_)=>AlertDialog(
      title: Text(doc !=null ? 'Update task' : 'Add task'),
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
        ElevatedButton(onPressed: (){
         doc != null ? updateTasks(doc.id, doc['completed']): addTasks();
          Navigator.pop(context);
        }, child: Text(doc != null ? 'Update' : 'Add'))
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: tasks.snapshots(),
          builder: (context, asyncSnapshot) {
            if(!asyncSnapshot.hasData) return Center(child: CircularProgressIndicator(),);
            final docs = asyncSnapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
                itemBuilder: (context, index){
                final doc = docs[index];
                  return Slidable(
                    key: ValueKey(doc.id),
                    endActionPane: ActionPane(motion: DrawerMotion(), children: [
                      SlidableAction(onPressed: (_)=>deleteTasks(doc.id),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ]),
                    child: Card(
                      child: ListTile(
                        title: Text(doc['title']),
                        subtitle: Text(doc['description']),
                        leading: Checkbox(value: doc['completed'], onChanged: (val){
                          updateStatusTasks(doc.id, val!);
                        }),
                        trailing: IconButton(onPressed: (){
                          showTaskDialog(context, doc);
                        }, icon: Icon(Icons.edit)),
                      ),
                    ),
                  );
                }
            );
          }
        ),
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
