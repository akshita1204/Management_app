import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/modes/staff_info_model.dart';
import 'package:hostel_management/theme/text_theme.dart';
import 'package:provider/provider.dart';

class StaffDisplayScreen extends StatefulWidget {
  const StaffDisplayScreen({super.key});

  @override
  State<StaffDisplayScreen> createState() => _StaffDisplayScreenState();
}

class _StaffDisplayScreenState extends State<StaffDisplayScreen> {
  StaffInfoModel?staffInfoModel;
  ApiCalls apiCalls=ApiCalls();
  Future<void>fetchAllStaff() async{
    try{
     final apiProvider=Provider.of<ApiProvider>(context,listen:false);
     final staffInfo=await apiProvider.getResponse(ApiUtils.allStaffs);
     if(staffInfo.statusCode==200)
     {
      final Map<String,dynamic>staff=json.decode(staffInfo.body);
       staffInfoModel=StaffInfoModel.fromJson(staff);
     }

    }
    catch(e)
    {
     print('error $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Scaffold(
        appBar: buildAppBar(context, "All Staff"),
        body:
       ApiUtils.roleId!=1?Center(
      child: Text( "You don't have Permission to view this page")
       ): 
       Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(future: fetchAllStaff(), 
                builder:  (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return staffInfoModel == null
                  ? const Center(
                      child: Text(
                        "No Availability",
                      ),
                    ):
          
          GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
          childAspectRatio: 2/1.2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16,
          ),
          itemCount: staffInfoModel!.result.length,
           itemBuilder: (context,index)
          {
            final staff=staffInfoModel!.result[index];
            return Padding(
              padding: const EdgeInsets.only(top:10,left:10,right:10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const ShapeDecoration(
                  shape:RoundedRectangleBorder(
                    side:BorderSide(color:Color(0xff087b38),
                    //width:2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                   )  
                ),
                child:Column(children: [
                  Expanded(
                    child: Row(children: [
                      Column(children: [
                        Image.asset(AppConstants.person,
                        width:90,
                        height:90,),
                        heightSpacer(20),
                        Text(
                          "Hostel Warden",
                          style:AppTextTheme.kLabelStyle,
                        )
                      ],),
                      widthSpacer(10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          heightSpacer(10),
                          Text("Name: ${staff.firstName}",
                          style:TextStyle(fontSize:14.sp)),
                          heightSpacer(8),
                          Text(
                            "E-mail:${staff.emailId}",
                            style:TextStyle(fontSize:14.sp)),
                          heightSpacer(8),
                          Text(
                            "Contact:${staff.phoneNumber}",
                            style:TextStyle(fontSize:14.sp)),
                          heightSpacer(8),
                                          
                                          
                        ],),
                      )
                    ],),
                  ),
                  InkWell(
                    onTap: (){
                      apiCalls.deleteStaff(context, staff.emailId);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal:10,vertical:8),
                      width: double.maxFinite,
                    decoration: BoxDecoration
                    (
                      color:const Color(0xffec6977),
                      borderRadius: BorderRadius.circular(12.r)
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Text("Delete",
                      style:TextStyle(fontSize: 16,
                      color:Colors.white,))
                    ],)
                    ),
                  )
                ],
                )
          
            ),
            );
          }
          );
          
            }
            },
          ),
        ),
      ),
    );

  }

}

      

