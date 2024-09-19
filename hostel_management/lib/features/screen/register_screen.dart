import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/custom_text_field.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/screen/home_screen.dart';
import 'package:hostel_management/features/widgets/custom_button.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final _formKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();


  ApiCalls apiCalls=ApiCalls();
  String? selectedBlock;
  String? selectedFloor;
  String? selectedRoom;

  /*List<String> blockOptions=['A','B','C'];
  List<String> roomOptionsA=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28'];
  List<String> roomOptionsB=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18'];
 List<String> roomOptionC=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18'];*/
  List<String> blockOptions=['A','B'];
  List<String> roomOptionsA=['101','102','103'];
  List<String> roomOptionsB=['101','102','103'];
  List<String> floor=['G','F','S','T'];


void dispose()
{
  email.dispose();
  password.dispose();
  username.dispose();
  firstName.dispose();
  lastName.dispose();
  phoneNumber.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical:10),
          child: Form(
            key:_formKey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpacer(40),
              Center(
                child: Image.asset(AppConstants.logo,
                height:150.h,
                width:150.w,
                ),
              ),
              heightSpacer(30),
              Align(
                alignment: Alignment.center,
                child: Text("Register your Account",
                style:TextStyle(fontSize:20.sp,
                    color:const Color(0xff333333),
                    fontWeight: FontWeight.w700)
                    ),
              ),
              heightSpacer(25),
                  Text("Username",style:AppTextTheme.kLabelStyle),
                  CustomTextField(
                  controller: username,
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
                Text("E-mail",style:AppTextTheme.kLabelStyle),
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
                heightSpacer(15),
                
                Row(
                  children: [
                    Container(
                      height: 50.h,
                      decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                        side:BorderSide(
                          width:1,
                          color:Color(0xff2e8b57)
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                      )),
                      child:Row(children: [
                        widthSpacer(20),
                        const Text("Block"),
                        widthSpacer(8),
                        
                        DropdownButton(items:blockOptions.map((String block)
                        {
                          return DropdownMenuItem(
                            value:block,
                            child: Text(block));
                        }).toList() ,
                        value:selectedBlock ,
                         onChanged: (String? newValue){
                          setState(() {
                            selectedBlock=newValue;
                            selectedRoom=null;
                          });
                        })
                      ],)
                    ),
                    widthSpacer(20),
                      Container(
                      height: 50.h,
                      decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                        side:BorderSide(
                          width:1,
                          color:Color(0xff2e8b57)
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                      )),
                       
                      child:Row(children: [
                        widthSpacer(20),
                        const Text("Floor"),
                        widthSpacer(8),
                        DropdownButton<String>
                        (items: (floor).map((String floor)
                        {
                          return DropdownMenuItem<String>(value:floor,
                            child: Text(floor),);
                        }).toList(),
                        value:selectedFloor ,
                         onChanged: (String? newValue){
                          setState(() {
                            selectedFloor=newValue;
                            selectedRoom=null;
                          });
                        })
                      ],)
                    ),
                  ],
                ),
                
                heightSpacer(20),
                    Container(
                      height: 50.h,
                      decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                        side:BorderSide(
                          width:1,
                          color:Color(0xff2e8b57)
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                      )),
                      child:Row(children: [
                        widthSpacer(20),
                        const Text("Room Number"),
                        widthSpacer(8),
                       
                       DropdownButton<String>(
                        value:selectedRoom,
                        onChanged:(String?newValue)
                        {
                          setState(() {
                            selectedRoom=newValue;
                          });
                        },
                        items: (selectedBlock=="A"?roomOptionsA:roomOptionsB).map((String room)
                        {
                          return DropdownMenuItem<String>(
                            value:room,
                            child:Text(room),
                          );
                        }).toList(),
                         ),
                      ],)
                    ),
      
        
                heightSpacer(25),
                CustomButton(buttonText: 'Register', onTap: ()async {
                  if(_formKey.currentState!.validate())  {
                    print('validated');
                   await  apiCalls.registerStudent(
                   username.text,
                    firstName.text,
                     lastName.text,
                      password.text, 
                      email.text,
                       phoneNumber.text, 
                       selectedBlock??"",
                        selectedRoom??"",
                         context);
                  }
                  
                },
                buttonColor:Colors.white,
                size:16,
                ),
                heightSpacer(10),
            ],
          )
          ,),
        ),
      )
    );
  }
   final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}