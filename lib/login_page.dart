import 'package:firebaseclassproject/service/auth_service.dart';
import 'package:firebaseclassproject/signup_page.dart';
import 'package:firebaseclassproject/task_manager.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Text('Welcome back', style: TextStyle(fontSize: 25),),
              SizedBox(height: 30,),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              SizedBox(height: 50,),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                    onPressed: () async {
                  await  AuthService().login(emailController.text, passwordController.text);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskManager()));
                    }, child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
              ),
              TextButton(onPressed: (){}, child: Text('Forget Password?')),
              ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.login), label: Text('Login with Gmail')),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
          
              }, child: Text('Create Account')),
            ],
          ),
        ),
      ),
    );
  }
}
