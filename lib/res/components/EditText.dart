
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../values/AppColor.dart';

class EditText extends StatelessWidget {
  EditText({Key? key,
    this.textColor=AppColor.textColor,
    this.backgroundColor=AppColor.grayColorLight,
    required this.title,
    required this.textInputType,
    required this.focusNode,
    required this.controller,
    this.icon,
    this.btnPress,
    this.readOnly=false,
    this.maxLengthCount=500,
    this.onChanged,
    this.showErrorMessage,
  }):super(key: key);

  final String title;
  final Color textColor,backgroundColor;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData?icon;
  final VoidCallback? btnPress;
  final bool readOnly;
  final int maxLengthCount;
  final ValueChanged<String>? onChanged;
  final bool?showErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.textFromFiled,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: showErrorMessage != true ? AppColor.themeColor : AppColor.themeColor,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    keyboardType: textInputType,
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: maxLengthCount,
                    onChanged: onChanged,
                  //  validator: (value) => validator(value),
                    readOnly: readOnly,
                    onTap: btnPress,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: InputDecoration(
                      hintText: title,
                      border: InputBorder.none,
                      counterText: "",
                      suffixIcon: Icon(icon),
                    ),
                  ),
                ),
              ),
            ),
            // Visibility(
            //   visible: showErrorMessage!,
            //
            //   child:  Container(
            //     margin: EdgeInsets.only(left: 0),
            //     padding: EdgeInsets.all(5),
            //     child:Align(
            //       alignment: Alignment.centerLeft,
            //       child: controller.text.trim().isEmpty?Text("The filed is required !",style: TextStyle(color: AppColor.red),):controller.text.trim().length<10?Text("Name is to short",style: TextStyle(color: AppColor.red)):Text(""),
            //     ),
            //   ),
            // )
          ],
        )
    );
  }
}