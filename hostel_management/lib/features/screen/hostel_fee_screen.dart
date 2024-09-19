import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';

class HostelFeeScreen extends StatelessWidget {
   /*String blockNumber;
   String roomNumber;
   String maintenanceCharge;
   String parkingCharge;
 String waterCharge;
   String roomCharge;
   String totalCharge;*/
   const HostelFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:buildAppBar(context, "Hostel Fee") ,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             heightSpacer(20),
          SvgPicture.asset(AppConstants.hostel),
          heightSpacer(40),
          Container(
            width:double.maxFinite,
            decoration: ShapeDecoration(
              //borderRadius: BorderRadius.circular(30),
              shape: RoundedRectangleBorder(
                side:BorderSide(
                  width: 4,
                  
                  color:Color(0xff2e8857),
                ),
                 borderRadius:BorderRadius.circular(30),
                
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(             
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   heightSpacer(20),
                Text("Hostel Details",
                style:TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                )),
                heightSpacer(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                     // 
                      children: [
                       Text("Block Number: ",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("A",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                    ],),
        
                     Row(
                          children: [
                          Text("Room Number: ",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("5",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],)
        
                  ],
        
                ),
                heightSpacer(20),
                 Text("Payment Details",
                style:TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                )),
                heightSpacer(10),
                Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Hostel Registration Fee: ",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("Rs.500.00",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],),
                        heightSpacer(10),
        
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Laundary Charges: ",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("Rs.3500.00",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],),
                        heightSpacer(10),
        
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Lodging and Boarding: ",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("Rs.161000.00",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],),
                        heightSpacer(10),
        
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Hostel Security: ",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("Rs.5000",
                    style:TextStyle(
                      fontSize:16.sp,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],),
                        heightSpacer(20),
                        Divider(
                          color:Colors.black,
                          
                        ),
                         Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Total (without Security): ",
                    style:TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      //fontWeight: FontWeight.w700,
                    )),
                                 // heightSpacer(20),
                      Text("Rs.165000",
                    style:TextStyle(
                      fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],),
                        heightSpacer(20),
                         Row(
        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Total (with Security): ",
                    style:TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      //fontWeight: FontWeight.w700,
                    )),
                                
                      Text("Rs.170000",
                    style:TextStyle(
                      fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                      //fontWeight: FontWeight.w700,
                    )),
                        ],), 
              ],),
            ),
            
          )
        ],),
      )
    );
  }
}