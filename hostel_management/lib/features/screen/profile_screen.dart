import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/custom_text_field.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/screen/login_screen.dart';
import 'package:hostel_management/features/widgets/custom_button.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   TextEditingController name=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
   TextEditingController firstName=TextEditingController();
    TextEditingController lastName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap:(){
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color:Colors.white,
          ),
        ),
        backgroundColor: AppColors.kGreenColor,
            title: Text(
          "Profile",
          style: AppTextTheme.kLabelStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: InkWell(
              onTap: (){
                    Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
              },
              child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
            ),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0),
        child: 
        ApiUtils.roleId==1?Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppConstants.profile,
                        height:180.h,
                        width: 180.w, 
                        ),
            ),
          heightSpacer(10),
          Text("You are an Admin",
          style:TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w700)),

          ],
        ):
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SvgPicture.asset(AppConstants.profile,
          height:180.h,
          width: 180.w, 
          ),
          heightSpacer(10),
          Text("${ApiUtils.firstName} ${ApiUtils.lastName}",
          style:TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w700)),
          heightSpacer(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          Expanded(
            child: Container(
                padding:const EdgeInsets.all(12),
                width:double.maxFinite,
                decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                  side:const BorderSide(
                    width:1,
                    color: Color(0xFF2E8B57)),
                    borderRadius: BorderRadius.circular(14),   
                  )
                ),
                child:Padding(padding: const EdgeInsets.only(left:10),
                child:Text(
                  'Block No:${ApiUtils.blockNumber}',
                  style:TextStyle(
                    fontSize: 17.sp,
                  )
                )
                )
                ),
          ),
        
             widthSpacer(30),
               Expanded(
                 child: Container(
                             padding:const EdgeInsets.all(12),
                             width:double.maxFinite,
                             decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                  side:const BorderSide(
                    width:1,
                    color: Color(0xFF2E8B57)),
                    borderRadius: BorderRadius.circular(14),   
                  )
                             ),
                             child:Padding(padding: const EdgeInsets.only(left:10),
                             child:Text(
                  'Room No:${ApiUtils.roomNumber}',
                  style:TextStyle(
                    fontSize: 17.sp,
                  )
                             )
                             )
                             ),
               ),
          ],),
          heightSpacer(20),
          Container(
                             padding:const EdgeInsets.all(12),
                             width:double.maxFinite,
                             decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                  side:const BorderSide(
                    width:1,
                    color: Color(0xFF2E8B57)),
                    borderRadius: BorderRadius.circular(14),   
                  )
                             ),
                             child:Padding(padding: const EdgeInsets.only(left:10),
                             child:Text(
                              ApiUtils.email ,
                  style:TextStyle(
                    fontSize: 17.sp,
                  )
                             )
                             )
                             ),
                             heightSpacer(10),
                              CustomTextField(
                              controller:name ,
                              inputHint: ApiUtils.username,
                              prefixIcon: const Icon(Icons.person_2_outlined),
                             ),
                              heightSpacer(10),
                              CustomTextField(
                              controller:phoneNumber ,
                              inputHint: ApiUtils.phoneNumber,
                              prefixIcon: const Icon(Icons.phone_outlined),
                             ),
                             Row(children: [
                               Expanded(child: 
                              CustomTextField(
                              controller:firstName ,
                              inputHint: ApiUtils.firstName,
                              //prefixIcon: const Icon(Icons.person_2_outlined),
                             ),
                             ),
                             widthSpacer(20),
                              Expanded(child: 
                              CustomTextField(
                              controller:lastName ,
                              inputHint: ApiUtils.lastName,
                             // prefixIcon: const Icon(Icons.person_2_outlined),
                             ),
                             ),
                             ],),
                             heightSpacer(30),
                             CustomButton(buttonText: 'Save', buttonColor: Colors.white, onTap: (){}, size: 16)

        ],),
      )
    );
  }
}