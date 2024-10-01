
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_standard/res/components/EditText.dart';
import 'package:flutter_standard/res/drawable/AppImage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../res/components/Button.dart';
import '../../res/routes/routes_name.dart';
import '../../res/values/AppColor.dart';
import '../../res/values/AppString.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _LoginState();
}
class _LoginState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode  passwordFocus = FocusNode ();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image:AssetImage(AppImage.loginBack),
                      // colorFilter: ColorFilter.mode(
                      //   AppColor.themeColor.withOpacity(0.7), // Apply a blue tint with 50% opacity
                      //   BlendMode.srcATop, // Use 'srcATop' blend mode
                      // ),
                      fit: BoxFit.fill
                  )
              ),
            ),
            const SizedBox(height: 50,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                //decoration: AppDecorations.commonBoxDecoration,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Text(" Or",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: AppColor.grayColorDart),),
                          Text(" Signup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(flex:2,child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColor.textFromFiled,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              color: AppColor.editText,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("+88",textAlign: TextAlign.center,),
                          ),
                        )),
                        Flexible(flex: 12,child: EditText(
                          controller: _emailController,
                          title: "Mobile Number",
                          textInputType:TextInputType.number,
                          focusNode: FocusNode(),
                          onChanged: (value) {
                          },
                        ))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const SizedBox(height: 0,),

                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        children: [
                          Text(
                            "By continuing, I agree to the ",
                            style: TextStyle(fontSize: 15, color: AppColor.grayColorDart),
                          ),
                          Text(
                            "Terms of Use ",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColor.themeColor),
                          ),
                          Text(
                            "& ",
                            style: TextStyle(fontSize: 15, color: AppColor.grayColorDart),
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColor.themeColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    RoundButton(
                        width:MediaQuery.of(context).size.width,title: 'Continue',
                        //btnColor: isLoginButtonEnabled() ? Colors.green : AppColor.grayColor_,
                        onPress: () async{

                        }),
                    const SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a member?"),
                        const SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            Get.toNamed(RoutesName.signUp);
                          },
                          child: const Text("SignUp Now",style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.themeColor,fontSize: 15),),
                        )

                      ],
                    ),
                    const SizedBox(height: 50,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

