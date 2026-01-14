import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class VotingPage extends StatelessWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('participants').snapshots(),
      builder: (context, asyncSnapshot) {
        final participants = asyncSnapshot.data!.docs;
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 10,
              childAspectRatio: 0.5
            ),
            itemCount: 2,
            itemBuilder: (context, index){
              final docs = participants[index];
              final data = docs.data() as Map<String, dynamic>;
              return Card(
                child: Column(
                  children: [
                    Image.network(data['imageUrl'],
                      height: 150,
                      width: 130,
                      fit: BoxFit.cover,
                    ),

                    SizedBox(height: 20,),
                    Text(data['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                    SizedBox(height: 20,),
                    Text('Votes: ${data['votes']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,),),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white
                      ),
                        onPressed: (){}, child: Text('VOTE'))
        
                  ],
                ),
              );
            }
        );
      }
    );
  }
}
