import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
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
                        forgotPasswordButton(),
                        customSizedBox(),
                        signInButton(),
                        customSizedBox(),
                        signUpButton(),


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
                        onPressed: () => Navigator.pushNamed(context, "/signUp"), child: Text("Hesap Oluştur", style: TextStyle(
                          color: Colors.pink[200]
                      ),),
                      ),
                    );
  }

  Center signInButton() {
    return Center(
                      child: TextButton(
                        onPressed: signIn, child: Container(
                        height: 50,
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xff31274F),
                        ),
                        child: Center(
                          child: Text("Giriş Yap", style: TextStyle(
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      ),
                    );
  }

  void signIn() async {
                        if(formkey.currentState!.validate()){
                          formkey.currentState!.save();
                         try{
                           final userInformation = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
                           Navigator.pushReplacementNamed(context, "/homePage");
                           print(userInformation.user!.email);
                         }catch(e){
                           print(e.toString());
                         }
                        }else{

                        }
                      }

  Center forgotPasswordButton() {
    return Center(
                      child: TextButton(
                        onPressed: () {}, child: Text("Şifremi Unuttum", style: TextStyle(
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
      "Merhaba, \nHosgeldin",
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