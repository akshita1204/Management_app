import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hostel_management/common/spacing.dart';

class CategoryCard extends StatelessWidget {
  String category;
  String image;
  VoidCallback onTap;
   CategoryCard({
    Key?key,
    required this.category,
    required this.onTap,
    required this.image,
    }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: ShapeDecoration(
          color:Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
        shadows: [
          BoxShadow(
            color:Color(0x7f2eBb57),
            blurRadius: 4,
            offset: Offset(1,4),
            spreadRadius: 0,
          )
        ]),
        child:Column(children: [
          SizedBox(
            height: 70,
            width:70,
            child:Image.asset(image),
          ),
          heightSpacer(10),
          Text(
            category,
            textAlign: TextAlign.center,
            style:TextStyle(color: const  Color(0xff333333),
            fontSize: 15,
            )
          ),
          heightSpacer(10),
          
      
        ],)
      
      ),
    );
  }
}