import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/appbar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/modes/issue_model.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';
import 'package:provider/provider.dart';

class IssuesScreen extends StatefulWidget {
  const IssuesScreen({super.key});

  @override
  State<IssuesScreen> createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
    IssueModel? issueModel;

  Future<void> fetchIssues() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final issueResponse = await apiProvider.getResponse(ApiUtils.allIssues);

      if (issueResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(issueResponse.body);
        issueModel = IssueModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch issues');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
 
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: buildAppBar(context, "Student Issues",
      ),
      body:FutureBuilder(
        future: fetchIssues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Result> issues = issueModel!.result;
            return issueModel == null
                ? const Center(
                    child: Text(
                      "No Issues found",
                    ),
                  )
                : ListView.builder(
                    itemCount: issues.length,
                    itemBuilder: (context, index) {
                      final issue = issues[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IssueCard(issue: issue),
                      );
                    },
                  );
          }
        },
      ),


    );
  }
}
class IssueCard extends StatelessWidget {
 final Result issue;
  const IssueCard({super.key, required this.issue});

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
              "Akshita Tyagi",
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
              "UserName:/${issue.studentDetails.userName}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "Room Number: ${issue.roomDetails.roomNumber}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "Block: ${issue.roomDetails.blockId}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "E-mail: ${issue.studentDetails.emailId}",
              style:TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w700,
              )
              ),
                  heightSpacer(10),
              Text(
              "Phone Number: ${issue.studentDetails.phoneNumber}",
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
                              Text("Issue: ",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                              ),
                               Text("${issue.issue}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              )
                            ],
                          ),
                          heightSpacer(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Student Comment: ",
                              style: AppTextTheme.kLabelStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                              ),
                               Text("${issue.studentComment}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              )
                            ],
                          ),
                          heightSpacer(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                                          onTap: (){
                                          apiCalls.closeAnIssue(issue.issueId, "Resolved", context);
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
                        Text("Resolve",
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