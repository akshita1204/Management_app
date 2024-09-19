import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/screen/change_room_screen.dart';
import 'package:hostel_management/modes/room_availability_model.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:provider/provider.dart';

class RoomAvailabilityScreen extends StatefulWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  State<RoomAvailabilityScreen> createState() => _RoomAvailabilityScreenState();
}

class _RoomAvailabilityScreenState extends State<RoomAvailabilityScreen> {
RoomAvailabilityModel? roomAvailabilityModel;
  Future<void>fetchRoomAvailability() async{
    try{
     final apiProvider=Provider.of<ApiProvider>(context,listen:false);
     final roomAvailabilityScreen=await apiProvider.getResponse(ApiUtils.roomAvailability);
     if(roomAvailabilityScreen.statusCode==200)
     {
      final Map<String,dynamic>room=json.decode(roomAvailabilityScreen.body);
       roomAvailabilityModel=RoomAvailabilityModel.fromJson(room);
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
      appBar: buildAppBar(context, "Room Availability"),
      body: FutureBuilder(future: fetchRoomAvailability(), 
      builder:  (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return roomAvailabilityModel == null
                ? const Center(
                    child: Text(
                      "No Availability",
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: roomAvailabilityModel!.result.length,
                      itemBuilder: (context, index) {
                        final room = roomAvailabilityModel!.result[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: RoomCard(room:roomAvailabilityModel!.result[index]),
                        );
                      },

      ),
                );
          }
      }
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Result room;
  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
           bottomLeft: Radius.circular(30.r),
        ),
        border:Border.all(color: Color(0xff087b3b,),
        width:2,
        )
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [
            Image.asset(AppConstants.bed,
            height:70.h,
            width:70.h,),
             Text("Room Number: ${room.roomNumber}",
            style:TextStyle(
              fontWeight: FontWeight.bold,
            )) 
          ],),
          widthSpacer(20),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Block: ${room.blockId.block}",
              style:TextStyle(fontSize: 16)),
              heightSpacer(5),
               Text("Capacity: ${room.roomCapacity}",
              style:TextStyle(fontSize: 16)),
              heightSpacer(5),
               Text("Current Capacity: ${room.roomCurrentCapacity}",
              style:TextStyle(fontSize: 16)),
              heightSpacer(5),
               Text("Room Type: ${room.roomType?.roomType??"Sharing"}",
              style:TextStyle(fontSize: 16)),
              heightSpacer(5),
              Row(children: [
                Text("Status:",
                style:TextStyle(fontSize: 16)
                ),
                widthSpacer(10),
                Container(
                  height: 30.h,
                  padding:EdgeInsets.only(left:5,right:5,bottom:5,top:2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:AppColors.kGreenColor
                  ),
                  child:room.roomCurrentCapacity==5?
                  Text("Unavailable",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 16.sp,
                    color:Colors.white,
                  ))
                   : InkWell(
                    onTap: (){
                      Navigator.push(context,CupertinoPageRoute(builder: (context)=>const ChangeRoomScreen()));
                    },
                     child: Text("Available",
                                       textAlign: TextAlign.center,
                                       style:TextStyle(
                      fontSize: 16.sp,
                      color:Colors.white,
                                       )),
                   )
                )
              ],)


              
            ],
          )
        ],
      ),
      
    );
  }
}