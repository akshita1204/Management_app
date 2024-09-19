import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/screen/category_card.dart';
import 'package:hostel_management/features/screen/create_staff_screen.dart';
import 'package:hostel_management/features/screen/hostel_fee_screen.dart';
import 'package:hostel_management/features/screen/issues_screen.dart';
import 'package:hostel_management/features/screen/profile_screen.dart';
import 'package:hostel_management/features/screen/room_availability_screen.dart';
import 'package:hostel_management/features/screen/room_change_request_screen.dart';
import 'package:hostel_management/features/screen/staff_display_screen.dart';
import 'package:hostel_management/features/students/create_issue_screen.dart';
import 'package:hostel_management/modes/student_info_model.dart';
import 'package:hostel_management/theme/text_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
StudentInfoModel? studentInfoModel;
  Future<void>fetchStudentData(String emailId) async{
    try{
     final apiProvider=Provider.of<ApiProvider>(context,listen:false);
     final studentInfo=await apiProvider.getResponse('${ApiUtils.studentInfo}$emailId');
     if(studentInfo.statusCode==200)
     {
      final Map<String,dynamic>student=json.decode(studentInfo.body);
       studentInfoModel=StudentInfoModel.fromJson(student);
     }

    }
    catch(e)
    {
     print('error $e');
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStudentData(ApiUtils.email);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        "Dashboard",
        style:AppTextTheme.kLabelStyle.copyWith(fontSize: 22.sp),
      ),
      actions:[Padding(
        padding: const EdgeInsets.only(right:15),
        child: InkWell(
          onTap: (){
           Navigator.push(context,
          CupertinoPageRoute(builder: (context)=>const ProfileScreen())); 
          },
          child: SvgPicture.asset(AppConstants.profile)),
      )]
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical:10.h),
        child: Column(children: [
          heightSpacer(20),
          Container(
            height:140.h,
            width:double.maxFinite,
            decoration:const ShapeDecoration(
              color: Colors.white,
              shape:RoundedRectangleBorder(
                side:BorderSide(width:2,
                color:Color(0xff007b3b)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              ),
              shadows:[
                BoxShadow(color:Color(0x332e8b57),
                blurRadius: 8,
                offset: Offset(2,4),
                spreadRadius: 0,
                )
              ]
            ),
            child:Padding(
              padding: const EdgeInsets.all(10.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      width:180,
                      child: Text(
                        //"Akshita Tyagi",
                       "${ApiUtils.firstName} ${ApiUtils.lastName}",
                        maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle(
                        fontWeight:FontWeight.w700,
                        color:const Color(0xff333333),
                        fontSize: 24.sp,
                      ),
                      ),
                    ),
                    heightSpacer(15),
                     Text(
                      "Room Number: ${ApiUtils.roomNumber}",
                    style:TextStyle(
                      //sssfontWeight:FontWeight.w700,
                      color:const Color(0xff333333),
                      fontSize: 15.sp,
                    ),
                    ),
                     heightSpacer(15),
                      Text("Block Number: ${ApiUtils.blockNumber} ",
                    style:TextStyle(
                      //fontWeight:FontWeight.w700,
                      color:const Color(0xff333333),
                      fontSize: 15.sp,
                    ),
                    ),

                  ],
                ),
                widthSpacer(20),
                Column(children: [
                  InkWell(
                    onTap:(){
                      Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=>const CreateIssueScreen()));
                    },
                    child: SvgPicture.asset(AppConstants.createIssue)),
                   Text("Create Issue",
                  style:TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
      
                  ))
                ],)
              ],),
            ) 
          ),
          heightSpacer(30),
          Container(
            width:double.maxFinite,
            color:const Color(0xff262e8b57),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              heightSpacer(20),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text("Categories",
                style:TextStyle(
                  color:const Color(0xff333333),
                  fontSize:19.sp,
                  fontWeight: FontWeight.w700,
                )),
              ),
              heightSpacer(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
            CategoryCard(category: 'Room\nAvailability', onTap: (){
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=>const RoomAvailabilityScreen()));

            }, image: AppConstants.roomAvailability),
            CategoryCard(category: 'All\nIssues', onTap: (){
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=>const IssuesScreen()));
            }, image: AppConstants.allIssues),
            CategoryCard(category: 'Satff\nMembers', onTap: (){
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=>const StaffDisplayScreen()));
            }, image: AppConstants.staffMember),
           // CategoryCard(category: 'Room\nAvailability', onTap: (){}, image: AppConstants.roomAvailability),

          ],),
          heightSpacer(20),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
            CategoryCard(category: 'Create\nStaff', onTap: (){
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=>const CreateStaffScreen()));
            }, image: AppConstants.createStaff),

            CategoryCard(category: 'Hostel\nFees', onTap: (){
              //final student=studentInfoModel!.result.first;
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=> const HostelFeeScreen(
                       /* blockNumber: student.studentProfileData.block.toString(),
                        roomNumber: student.studentProfileData.roomNumber.toString(),
                        maintenanceCharge: student.roomChargesModel.maintenanceCharges.toString(), 
                        parkingCharge: student.roomChargesModel.parkingCharges.toString(),
                        waterCharge: student.roomChargesModel.roomWaterCharges.toString(), 
                        roomCharge: student.roomChargesModel.roomAmount.toString(),
                        totalCharge: student.roomChargesModel.totalAmount.toString(),*/
                        ))
                        );
            }, image: AppConstants.hostelFee),
            CategoryCard(category: 'Change\nRequest', onTap: (){
              Navigator.push(context,
                      CupertinoPageRoute(builder: (context)=>const RoomChangeRequestScreen()));
            }, image: AppConstants.roomChange),
           // CategoryCard(category: 'Room\nAvailability', onTap: (){}, image: AppConstants.roomAvailability),

          ],),
          heightSpacer(20),

            ],)
          )
          
        ],),
      )
    );
  }
}