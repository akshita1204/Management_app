import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/custom_text_field.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/screen/home_screen.dart';
import 'package:hostel_management/features/screen/register_screen.dart';
import 'package:hostel_management/features/widgets/custom_button.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _formKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  ApiCalls apiCalls=ApiCalls();

void dispose()
{
  email.dispose();
  password.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Form
          ( key:_formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(AppConstants.logo,
                height: 250.h,),
              ),
              heightSpacer(30),
              Align(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: const Text("Login to your Account",
                  style:TextStyle(fontSize:20,
                  color:const Color(0xff333333),
                  fontWeight: FontWeight.w700)),
                ),
              ),
              heightSpacer(25),
              Text("E-mail",style:AppTextTheme.kLabelStyle),
              heightSpacer(15),
              CustomTextField(
                controller: email,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffd1d8ff)
                  ),
                  borderRadius:BorderRadius.circular(14),
                ),
                inputHint: "Enter your E-mail",
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return 'E-mail is required';
                  }
                  return null;
                },
              ),
              heightSpacer(20),
              Text("Password",style:AppTextTheme.kLabelStyle),
              heightSpacer(15),
               CustomTextField(
                controller: password,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffd1d8ff)
                  ),
                  borderRadius:BorderRadius.circular(14),
                ),
                inputHint: "Enter your password",
                 validator: (value){
                  if(value!.isEmpty)
                  {
                    return 'Password is required';
                  }
                  return null;
                }
              ),
              heightSpacer(30),
               CustomButton(
                buttonText:'Login',
                onTap:(){
                 if(_formKey.currentState!.validate())
                  {
                     apiCalls.handleLogin(context, email.text, password.text);
                  }
                 
                  /*Navigator.push(context,
                  CupertinoPageRoute(
                    builder: (context)=>const HomeScreen(),
                    ));*/
                },
                buttonColor:Colors.white,
                size:16,
              ),
              heightSpacer(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't have an Account?"),
                  InkWell(
                   onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterScreen()));
                   },
                    child:Text(
                      "Register",
                      style:AppTextTheme.kLabelStyle.copyWith(
                        fontSize: 14.sp,
                        color:AppColors.kGreenColor,
                      )
                    )
                  ),
                ],
              )
            ],
          )),
        ),
      )
    );
  }
}