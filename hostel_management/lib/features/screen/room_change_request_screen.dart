import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/modes/room_change_model.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';
import 'package:provider/provider.dart';

class RoomChangeRequestScreen extends StatefulWidget {
  const RoomChangeRequestScreen({super.key});

  @override
  State<RoomChangeRequestScreen> createState() => _RoomChangeRequestScreenState();
}

class _RoomChangeRequestScreenState extends State<RoomChangeRequestScreen> {
  RoomChangeModel? roomChangeModel;
  Future<void>fetchRoomChangeRequests() async{
    try{
     final apiProvider=Provider.of<ApiProvider>(context,listen:false);
     final requests=await apiProvider.getResponse(ApiUtils.studentRoomChangeRequest);
     if(requests.statusCode==200)
     {
      final Map<String,dynamic>issue=json.decode(requests.body);
       roomChangeModel=RoomChangeModel.fromJson(issue);
     }

    }
    catch(e)
    {
     print('error $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Room Change Request",
      ),
      body:ApiUtils.roleId!=1?Center(
      child: Text( "You don't have Permission to view this page")
       ):
       FutureBuilder(future: fetchRoomChangeRequests(), 
      builder:  (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return roomChangeModel == null
                ? const Center(
                    child: Text(
                      "No Availability",
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  
       ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: roomChangeModel!.result.length,
        itemBuilder: (context,index){
        return  RequestCard(requests:roomChangeModel!.result[index],);
      })
                );
          }
      }
      ),


    );
  }
}
class RequestCard extends StatelessWidget {
  final Result requests;
  const RequestCard({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    ApiCalls apiCalls=ApiCalls();
    return Container(
      width:double.maxFinite,
      child:Column(children: [
        heightSpacer(20),
        Container(
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end:Alignment(0, 1),
              colors: [
           const Color(0xff2e8b57).withOpacity(0.5),
           const Color(0x002e8857),
            ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
               // bottomLeft: Radius.circular(30),

              )
            )
          ),
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Column(children: [
             heightSpacer(20),
            Image.asset(AppConstants.person,
            height: 70,
            width: 70,),
            heightSpacer(20),
            const Text(

              // ignore: unnecessary_string_interpolations
              "Hello",
              //"${requests.studentDetails.firstName}",
              style:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )
              
            )
           ],),
           widthSpacer(20),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpacer(10),
              Text(
              "${requests.studentDetails.firstName}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "Current Room Number: ${requests.currentRoomNumber}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "Current Block: ${requests.currentBlock}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "E-mail:${requests.studentDetails.emailId}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "Phone Number: ${requests.studentDetails.phoneNumber}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
            ],
           )
          ],),
        ),
        Container(
          width:double.maxFinite,
          height: 150,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width:double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child:Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Asked For:  ",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                              ),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Block: ${requests.toChangeBlock}",
                                    style: TextStyle(
                                    fontSize: 16,
                                    color:Colors.pink,
                                    fontWeight: FontWeight.w400
                                      ),
                                        ),
                                        widthSpacer(20),
                                      Text("Room No: ${requests.toChangeRoomNumber}",
                                       style: TextStyle(
                                    fontSize: 16,
                                    color:Colors.pink,
                                    fontWeight: FontWeight.w400
                                    ),
                                   ),
                                 ],
                               )
                            ],
                          ),
                          heightSpacer(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Reason: ",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                              ),
                               Text("${requests.changeReason}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              )
                            ],
                          ),
                          heightSpacer(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                                          onTap: (){
                                           apiCalls.approveOrRejectRequest(requests.roomChangeRequestId, "Approved", "Approved", context);
                                          },
                                          child: Container(
                        padding: EdgeInsets.symmetric(horizontal:10,vertical:8),
                        width: 148,
                                          decoration: BoxDecoration
                                          (
                        color:AppColors.kGreenColor,
                        borderRadius: BorderRadius.circular(12)
                                          ),
                                          child:const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text("Approve",
                        style:TextStyle(fontSize: 16,
                        color:Colors.white,))
                                          ],)
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            apiCalls.approveOrRejectRequest(requests.roomChangeRequestId, "Rejected", "Rejected", context);

                                          },
                                          child: Container(
                        padding: EdgeInsets.symmetric(horizontal:10,vertical:8),
                        width: 148,
                                          decoration: BoxDecoration
                                          (
                        color:Color(0xffed6a57),
                        borderRadius: BorderRadius.circular(12)
                                          ),
                                          child:const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text("Reject",
                        style:TextStyle(fontSize: 16,
                        color:Colors.white,))
                                          ],)
                                          ),
                                        ),
                      ],
                    )
                
                
                        ],
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        )
      ],)
    );
  }
}
    
 
