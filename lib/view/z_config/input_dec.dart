
import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:flutter/material.dart';

const myInputDecoration =  InputDecoration(
  focusColor: primaryColor,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryColor)),
                                contentPadding:
                                    EdgeInsets.only(left: 2, top: 10),
                                hintText: "First Name",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                border: UnderlineInputBorder(),
);
