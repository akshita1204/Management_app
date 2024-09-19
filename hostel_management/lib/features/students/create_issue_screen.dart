import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/custom_text_field.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/widgets/custom_button.dart';
import 'package:hostel_management/theme/text_theme.dart';

class CreateIssueScreen extends StatefulWidget {
  const CreateIssueScreen({super.key});

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  TextEditingController studentComment=new TextEditingController();
  TextEditingController studentEmailId=new TextEditingController();
  TextEditingController roomNumber=TextEditingController();
  TextEditingController block=new TextEditingController();
  TextEditingController issue=new TextEditingController();
  TextEditingController studentContactNumber=new TextEditingController();

String?selectedIssue;
ApiCalls apiCalls=ApiCalls();
List<String>issues=[
"Furniture",
"Electricity",
"Water",
"Bathroom",
"Washroom",
];
@override
  void dispose() {
    // TODO: implement dispose
    studentComment.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Create Issue'),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal:15,vertical:10),
        child: SingleChildScrollView(
          child: Form(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            heightSpacer(15),
             Text("Block",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            Container(
              padding: const EdgeInsets.all(12),
              width:double.maxFinite,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                side:const BorderSide(
                  width:1,
                  color: Color(0xff2e8b57),
                ),
                borderRadius: BorderRadius.circular(14),
              )),
              child:Padding(
                padding: EdgeInsets.only(left:10.0),
                child:  Text(
                  ApiUtils.blockNumber,
                  style:TextStyle(fontSize: 17.sp)
                ),
                
              ),
            ) , 
            heightSpacer(15),
             Text("Floor",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            Container(
              padding: const EdgeInsets.all(12),
              width:double.maxFinite,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                side:const BorderSide(
                  width:1,
                  color: Color(0xff2e8b57),
                ),
                borderRadius: BorderRadius.circular(14),
              )),
              child:Padding(
                padding: EdgeInsets.only(left:10.0),
                child:  Text(
                  "T",
                  style:TextStyle(fontSize: 17.sp)
                ),
                
              ),
            ) , 
            heightSpacer(15),
            Text("Room Number",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            Container(
              padding: const EdgeInsets.all(12),
              width:double.maxFinite,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                side:const BorderSide(
                  width:1,
                  color: Color(0xff2e8b57),
                ),
                borderRadius: BorderRadius.circular(14),
              )),
              child:Padding(
                padding: EdgeInsets.only(left:10.0),
                child:  Text(
                  ApiUtils.roomNumber,
                  style:TextStyle(fontSize: 17.sp)
                ),
                
              ),
            ) ,
            //heightSpacer(15), 
                heightSpacer(15),
            Text("Your E-mail",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            Container(
              padding: const EdgeInsets.all(12),
              width:double.maxFinite,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                side:const BorderSide(
                  width:1,
                  color: Color(0xff2e8b57),
                ),
                borderRadius: BorderRadius.circular(14),
              )),
              child:Padding(
                padding: EdgeInsets.only(left:10.0),
                child:  Text(
                  ApiUtils.email,
                  style:TextStyle(fontSize: 17.sp)
                ), 
              ),
            ) ,
                heightSpacer(15),
            Text("Phone Number",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            Container(
              padding: const EdgeInsets.all(12),
              width:double.maxFinite,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                side:const BorderSide(
                  width:1,
                  color: Color(0xff2e8b57),
                ),
                borderRadius: BorderRadius.circular(14),
              )),
              child:Padding(
                padding: EdgeInsets.only(left:10.0),
                child:  Text(
                  ApiUtils.phoneNumber,
                  style:TextStyle(fontSize: 17.sp)
                ),
              ),
            ) ,
                heightSpacer(15),
            Text("Issues you are Facing?",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            Container(
              padding:  EdgeInsets.symmetric(horizontal:10.w),
              width:double.maxFinite,
              decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                side:const BorderSide(
                  width:1,
                  color: Color(0xff2e8b57),
                ),
                borderRadius: BorderRadius.circular(14),
              )),
              child:DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                value:selectedIssue,
                items: issues.map((String issue)
                {
                  return DropdownMenuItem(
                    value:issue,
                    child: Text(issue));
                }).toList(),
                onChanged: (String? newValue)
                {
                  setState(() {
                    selectedIssue=newValue;
                  });
                }),
            ) ,
                heightSpacer(15),
            Text("Comment",
            style:AppTextTheme.kLabelStyle),
            heightSpacer(15),
            CustomTextField(
              controller: studentComment,
              validator: (value){
                if(value!.isEmpty)
                {
                  return "Comment is required";
                }
                return null;
              },
              enabledBorder: OutlineInputBorder(
                borderRadius:BorderRadius.circular(14),
                borderSide: BorderSide(
                  color:Color(0xffd1d8ff),
                ),
              ),       
            ),
            heightSpacer(40),
            CustomButton(buttonText: "Submit",  onTap: (){
              apiCalls.createAnIssue(context, ApiUtils.roomNumber, ApiUtils.blockNumber, ApiUtils.createIssue, ApiUtils.email, studentComment.text, ApiUtils.phoneNumber);
            }, buttonColor: Colors.white, size: 16,),
            heightSpacer(10),
          ],),),
        ),
      )
    );
  }
}