import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class VotingPage extends StatelessWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context) {

    voteParticipants(String id){
      FirebaseFirestore.instance.collection('participants').doc(id).update(
        {
          'votes' : FieldValue.increment(1)
        }
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('participants').snapshots(),
      builder: (context, asyncSnapshot) {
        if(asyncSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
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
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    SizedBox(height: 20,),
                    Text(data['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                    SizedBox(height: 20,),
                    Text('Votes: ${data['votes']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,),),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white
                        ),
                          onPressed: (){
                          voteParticipants(docs.id);
                          }, child: Text('VOTE')),
                    )
        
                  ],
                ),
              );
            }
        );
      }
    );
  }
}
