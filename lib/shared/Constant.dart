import 'package:blood_bank/models/city_model.dart';
import 'package:blood_bank/models/governate_model.dart';
import 'package:blood_bank/models/profile_model.dart';
import 'package:blood_bank/modules/Login_Screen/login.dart';
import 'package:blood_bank/shared/Network/local/Cache_helper.dart';
import 'package:flutter/material.dart';

void Signout(context)
{
  CacheHelper.Removedata(Key: 'token').then((value)
  {
    if(value)
    {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  });
}
String? token='';

int? govIdConstant;
int? cityIdConstant;
int? idIndexOfCity ;
// String? cityDropDownValue = cityItemList[idIndexOfCity].cityName;

List<Governorates> governorateItemList = [];
List<Cities> cityItemList = [];

ProfileModel? userDataModel;
