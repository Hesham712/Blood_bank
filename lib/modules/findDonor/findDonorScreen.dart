import 'package:blood_bank/models/Donermodel.dart';
import 'package:blood_bank/models/Donermodel.dart';
import 'package:blood_bank/models/Donermodel.dart';
import 'package:blood_bank/models/Donermodel.dart';
import 'package:blood_bank/modules/chat/chatscreen.dart';
import 'package:blood_bank/shared/components/components.dart';
import 'package:blood_bank/shared/cubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/Donermodel.dart';
import '../../models/Donermodel.dart';
import '../../shared/Constant.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FindDonorScreen extends StatelessWidget {

  String? bloodType;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  bool isButtomSheetShown = false;
  late int id;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldkey,
          appBar: AppBar(
            title: Text('Find a donor'),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.asset("assets/images/finddonor.jpg"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => FindDonorInfo(
                        "assets/images/finddonor.jpg",
                        "${cubit.donorModel.users[index].name}",
                        "${cubit.donorModel.users[index].governorate?.governorateName}",
                        "${cubit.donorModel.users[index].city?.cityName}",
                        "${cubit.donorModel.users[index].bloodType}"),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 30.h,
                    ),
                    itemCount: cubit.donorModel.users.length,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isButtomSheetShown) {
                Navigator.pop(context);
                isButtomSheetShown = false;
              } else {
                scaffoldkey.currentState?.showBottomSheet((context) {
                  return Container(
                    height: 420.h,
                    color: greyColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Blood type",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                              color: mainColor,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 60,
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              items: cubit.bloodGroupItem
                                  .map(
                                    (label) => DropdownMenuItem(
                                  child: Text(
                                    label,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  value: label,
                                ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                bloodType = value.toString();
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Blood type must not be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              hint: const Text('Blood type'),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "Governorate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                              color: mainColor,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 60,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              hint: const Text(
                                'Governorate',
                              ),
                              validator: (value) {
                                value ?? "Governorate must not be empty";
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: governorateItemList
                                  .asMap()
                                  .entries
                                  .map((items) {
                                return DropdownMenuItem(
                                  value: items.value.governorateName,
                                  child: Text(items.value.governorateName!),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                id = governorateItemList.indexWhere((element) => element.governorateName == newValue);
                                cubit.getFilterCityData(id: governorateItemList[id].id!);
                                idIndexOfCity = 0;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "City",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                              color: mainColor,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            height: 60,
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: ["15 mayo", "ma3sara", "masaken"]
                                  .map((label) => DropdownMenuItem(
                                child: Text(
                                  label,
                                  style: TextStyle(fontSize: 16),
                                ),
                                value: label,
                              ))
                                  .toList(),
                              onChanged: (value) {
                                // bloodtype = value.toString();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
                isButtomSheetShown = true;
              }
            },
            backgroundColor: mainColor,
            child: const Icon(Icons.filter_alt_outlined),
          ),
        );
      },
    );
  }
}

class FindDonorInfo extends StatelessWidget {
  FindDonorInfo(
      this.imageLink, this.name, this.governorate, this.city, this.bloodType,
      {Key? key})
      : super(key: key);
  String imageLink;
  String name;
  String governorate;
  String city;
  String bloodType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                imageLink,
              ),
              radius: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  '$governorate,$city',
                  style: const TextStyle(
                    color: greyColor2,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 28,
                    width: 85,
                    child: const Center(
                      child: Text(
                        'Ask for help',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: mainColor,
                    ),
                  ),
                ),
                Container(
                  height: 21,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(26)),
                  child: Center(
                      child: Text(
                        bloodType,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}