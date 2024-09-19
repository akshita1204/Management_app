import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/features/screen/home_screen.dart';
import 'package:hostel_management/features/screen/login_screen.dart';
import 'package:hostel_management/modes/student_info_model.dart';
import 'package:hostel_management/modes/user_response.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ApiCalls
{
  Future<void>handleLogin(BuildContext context,String email,String password)
  async {
    final apiProvider=Provider.of<ApiProvider>(context,listen: false);
    final Map<String,dynamic> requestData=
    {
      "emailId": email,
      "password": password,
    };
    
     final response=await apiProvider.postResponse(
      ApiUtils.login,
      headers: {
      'Content-Type': 'application/json',
     },
     body:requestData,
  
     );
     if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
       if (responseBody['status'] == 'FAILED') {
        //print('Failed to Login');
        ApiUtils.showErrorSnackBar(context, responseBody['error']);
       }

       final UserResponse userResponse=UserResponse.fromJson(responseBody);
        print("User email: ${userResponse.result[0].emailId}");
        ApiUtils.phoneNumber=userResponse.result[0].phoneNumber.toString();
        ApiUtils.roomNumber=userResponse.result[0].roomNumber.toString();
        ApiUtils.blockNumber=userResponse.result[0].block.toString();
        ApiUtils.username=userResponse.result[0].userName;
        ApiUtils.email=userResponse.result[0].emailId!;
        ApiUtils.firstName=userResponse.result[0].firstName!;
        ApiUtils.lastName=userResponse.result[0].lastName!;
        ApiUtils.roleId=userResponse.result[0].roleId?.roleId;

      // print("bodyyyy:${responseBody}");
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
  }
else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        final String errorMessage = errorResponse['msg'];
        print("Error message: $errorMessage");
        // ignore: use_build_context_synchronously
        ApiUtils.showErrorSnackBar(context, errorMessage);
      }
}


  Future<String?> registerStudent(
    String username,
    String firstName,
    String lastName,
    String password,
    String email,
    String phoneNumber,
    String block,
    String roomNumber,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "userName": username,
      "emailId": email,
      "password": password,
      "roleId": 2,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "roomNumber": roomNumber,
      "block": block
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postResponse(
      ApiUtils.register,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['status'] == "Student created successfully") {
        // ignore: use_build_context_synchronously
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        // return responseBody['msg'];
      }
    }
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['status'] == "Student Already Exists") {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);

        // return responseBody['msg'];
      }
    }

    return null;
  }


Future<String?>createStaff(
  BuildContext context,
    String userName,
    String firstName,
    String lastName,
    String password,
    String email,
    String phoneNumber,
    String jobRole,

  )
  async {
    final apiProvider=Provider.of<ApiProvider>(context,listen: false);
    final Map<String,dynamic> requestData=
    {
      "userName": userName,
      "emailId": email,
      "password": password,
      "roleId": 3,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "jobRole":jobRole,
    };
    
     final response=await apiProvider.postResponse(
      ApiUtils.createStaff,
      headers: {
      'Content-Type': 'application/json',
     },
     body:requestData,
  
     );
     if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
         if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(context,
           CupertinoPageRoute(builder: (context) => const HomeScreen()));
      }
    return null;
  }
}
Future<String?>createAnIssue(
  BuildContext context,
    String roomNumber,
    String blockNumber,
    String issue,
    String email,
    String comment,
    String phoneNumber,

  )
  async {
    final apiProvider=Provider.of<ApiProvider>(context,listen: false);
    final Map<String,dynamic> requestData=
    {
      "roomNumber": roomNumber,
      "block": blockNumber,
      "issue": issue,
      "studentComment": comment,
      "studentEmailId": email
    };
    
     final response=await apiProvider.postResponse(
      ApiUtils.createIssue,
      headers: {
      'Content-Type': 'application/json',
     },
     body:requestData,
  
     );
     if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
         if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(context,
           CupertinoPageRoute(builder: (context) => const HomeScreen()));
      }
    return null;
  }
}

Future<String?>roomChangeRequest(
  BuildContext context,
    String changeRoomNumber,
    String changeBlockNumber,
    String reason,

  )
  async {
    final apiProvider=Provider.of<ApiProvider>(context,listen: false);
    final Map<String,dynamic> requestData=
    {
      "currentRoomNumber": ApiUtils.roomNumber,
      "toChangeRoomNumber": changeRoomNumber,
      "currentBlock": ApiUtils.blockNumber,
      "toChangeBlock": changeBlockNumber,
      "studentEmailId": ApiUtils.email,
      "changeReason": reason,
    };
    
     final response=await apiProvider.postResponse(
      ApiUtils.roomChangeRequest,
      headers: {
      'Content-Type': 'application/json',
     },
     body:requestData,
  
     );
     if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
         if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(context,
           CupertinoPageRoute(builder: (context) => const HomeScreen()));
      }
    return null;
  }
}

void deleteStaff(BuildContext context,String emailId)async{
  final apiProvider=Provider.of<ApiProvider>(context,listen: false);
  final response=await apiProvider.deleteResponse(
    '${ApiUtils.deleteStaff}$emailId',
    headers: 
    {
      'Content-Type': 'application/json',
    }, body: {

    }
    
  );
      if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
         if (responseBody['statusCode'] == 200) {
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        Navigator.pushReplacement(context,
           CupertinoPageRoute(builder: (context) => const HomeScreen()));
      }
    return null;
  }
 
}

  Future<String?>approveOrRejectRequest(
    int requestId,
    String adminComment,
    String action,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "roomChangeRequestId": requestId,
      "approveOrReject": action,
      "adminComment": adminComment,
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postResponse(
      ApiUtils.closeRoomRequest,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

        // return responseBody['msg'];
      }
    }
    return null;
  }

    Future<String?> closeAnIssue(
    int issueId,
    String staffComment,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "issueId": issueId,
      "staffComment": 'Resolved',
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postResponse(
      ApiUtils.closeIssue,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSuccessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

        // return responseBody['msg'];
      }
    }
    return null;
  }
    
}

