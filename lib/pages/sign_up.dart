import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>  {
late String email, password;
final formkey = GlobalKey<FormState>();
final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: height*.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/topImage.png"),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText(),
                        customSizedBox(),
                        emailTextField(),
                        customSizedBox(),
                        passwordTextField(),
                        customSizedBox(),
                        signUpButton(),
                        customSizedBox(),
                        backToLoginPage(),


                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: signIn, child: Text("Hesap Oluştur", style: TextStyle(
          color: Colors.pink[200]
      ),),
      ),
    );
  }

  void signIn() async {
        if(formkey.currentState!.validate()){
          formkey.currentState!.save();
          try {
            var userInformation = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
            print(userInformation.user!.uid);
            formkey.currentState!.reset();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Kayıt Olundu, Giriş Yap Sayfasına Yönlendiriliyorsunuz..."
              ),
            ),);
            Navigator.pushReplacementNamed(context, "/loginPage");
          }catch(e) { print(e.toString());}
        }else{

        }
      }

  Center backToLoginPage() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/loginPage"), child: Text("Kayıt Ol Sayfasına Geri Dön", style: TextStyle(
          color: Colors.pink[200]
      ),),
      ),
    );
  }



  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return "Bilgileri Eksiksiz Doldurun";
        }else {}
      },
      onSaved: (value) {
        password =value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Şifre"),
    );
  }

  TextFormField emailTextField() {

    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
        return "Bilgileri Eksiksiz Doldurun";
        }else {}
      },
      onSaved: (value) {
        email =value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: customInputDecoration("Kullanıcı Adı"),
    );
  }

  Text titleText() {
    return Text(
      "Gate, \nSystem",
      style: TextStyle(fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold),
    );
  }


  Widget customSizedBox() => SizedBox(
    height: 20,
  );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder:  UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }

}