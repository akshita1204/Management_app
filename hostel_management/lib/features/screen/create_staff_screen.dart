import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/custom_text_field.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/widgets/custom_button.dart';
import 'package:hostel_management/theme/text_theme.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({super.key});

  @override
  State<CreateStaffScreen> createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  static final _formKey=GlobalKey<FormState>();
  ApiCalls apiCalls=ApiCalls();
  TextEditingController userName=TextEditingController();
   TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
   TextEditingController jobRole=TextEditingController();
  @override
  void dispose()
  {
    userName.dispose();
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    jobRole.dispose();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Create Staff"),
      body:ApiUtils.roleId!=1?Center(
      child: Text( "You don't have Permission to view this page")
       ):SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical:10),
        child:Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("UserName",style:AppTextTheme.kLabelStyle),
             CustomTextField(
                  controller: userName,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your UserName",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'UserName is required';
                    }
                    return null;
                  },
                ),

                  heightSpacer(15),
                Text("First Name",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: firstName,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your First Name",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'First Name is required';
                    }
                    return null;
                  },
                ),

                    heightSpacer(15),
                Text("Last Name",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: lastName,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your Last Name",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Last Name is required';
                    }
                    return null;
                  },
                ),



                    heightSpacer(15),
                Text("Job Role",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: jobRole,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your Job Role",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Job Role is required';
                    }
                    return null;
                  },
                ),

                 heightSpacer(15),
                Text("E-mail",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: email,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your e-mail",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'E-mail is required';
                    }
                    else if (!emailRegex.hasMatch(value)) {
                            return 'Invalid email address';
                          }
                    return null;
                  },
                ),

                 heightSpacer(15),
                Text("Password",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: password,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your Password",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),

                        heightSpacer(15),
                Text("Phone Number",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: phoneNumber,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffd1d8ff)
                    ),
                    borderRadius:BorderRadius.circular(14),
                  ),
                  inputHint: "Enter your Phone Number",
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                ),

                heightSpacer(40),
                CustomButton(buttonText: "Create Staff", buttonColor: Colors.white, size: 16, onTap: (){
                    if(_formKey.currentState!.validate()){
                      apiCalls.createStaff(context,
                      userName.text, 
                      firstName.text,
                       lastName.text,
                        password.text,
                         email.text,
                          phoneNumber.text,
                           jobRole.text);
                    }
                })
          ],
        ))),
      )
    );
  }
   final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}
