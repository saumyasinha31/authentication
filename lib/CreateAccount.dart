import 'package:authentication/Methods.dart';
import 'package:flutter/material.dart';
import 'package:authentication/HomeScreen.dart';
class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading? Center(child: Container(
        height: size.height/20,
        width: size.width/20,
        child: CircularProgressIndicator(),
      ),) : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1.2,
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_back_ios), ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            Container(
              width: size.width / 1.3,
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: size.width / 1.3,
              alignment: Alignment.centerLeft,
              child: Text(
                "Create Account to Continue!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Name", Icons.person, _name),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "email", Icons.account_box, _email),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                width: size.width,
                alignment: Alignment.center,
                child: field(size, "password", Icons.lock, _password),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            customButton(size),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                "Already have an account? Login ",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: (){
        if( _name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
             setState(() {
               isLoading = true;
             });
            createAccount(_name.text, _email.text, _password.text)
            .then((user) {
               if(user != null){
                 setState(() {
                   isLoading = false;
                 });
                 Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                 print("Account Created Successfull");
               }else{
                 print("Login Failed");

                 setState(() {
                   isLoading = false;
                 });
               }
            });

        }else{
          print("Please Enter Fields");
        }
      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue[700],
        ),
        alignment: Alignment.center,
        child: Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget field(Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 11,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
