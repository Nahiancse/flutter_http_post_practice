import 'package:flutter/material.dart';
import 'package:flutter_http_post/userModel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserModel? _user;

  final TextEditingController nameController=TextEditingController();

  final TextEditingController jobController=TextEditingController();

  Future<UserModel> createUser(String name, String job)async{
    var apiUrl = Uri.parse( 'https://reqres.in/api/users');
     
   final response = await http.post(apiUrl,body: {
      "name": name,
    "job": job
    });

    if(response.statusCode ==201){
      final String responseString = response.body;
      return userModelFromJson(responseString);
    }else{
      return null!;
    }
     

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: nameController,
              ),
              TextField(
                controller: jobController,
              ),
              SizedBox(height: 10,),
              _user==null? Container():
              Text('The user ${_user?.name} is created\n the id is${_user?.id}\n job is ${_user?.job}\n created at ${_user?.createdAt?.toIso8601String()}'),
            

              ElevatedButton(onPressed: ()async{

                final name = nameController.text;
                final job = jobController.text;

                final UserModel user =await createUser(name, job);

                setState(() {
                  _user=user;
                });

                
              }, child: Text('Post'))
            ],
          ),
        ),
      ),
      
    );
  }
}