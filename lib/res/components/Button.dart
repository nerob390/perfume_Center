
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/AppColor.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({Key?key,
    this.textColor=Colors.white,
    this.btnColor=AppColor.themeColor,
    required this.title,
    required this.onPress,
    this.height=50,
    this.width=40,
    this.loading=false
  }):super(key: key);
  final bool loading;
  final String title;
  final double height,width;
  final VoidCallback onPress;
  final Color textColor,btnColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child:Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.circular(10)

            ),
            child: loading ?
            const Center(
                child: CircularProgressIndicator()):
            Center(
              child: Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),),
            )

        )
    );
  }
}