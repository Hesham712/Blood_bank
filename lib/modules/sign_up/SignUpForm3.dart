import 'package:blood_bank/modules/Login_Screen/login.dart';
import 'package:blood_bank/shared/components/components.dart';
import 'package:blood_bank/shared/cubit/cubit.dart';
import 'package:blood_bank/shared/cubit/states.dart';
import 'package:blood_bank/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen3 extends StatelessWidget {
  TextEditingController height = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450.h,
                    color: const Color.fromRGBO(237, 57, 74, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Sign Up ',
                          style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  clipper: CustomClipPath(),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "step 3 of 3",
                            style: TextStyle(fontSize: 22.h , fontStyle: FontStyle.italic , color: mainColor),
                          ),
                        ),
                        Container(
                          width: 300.w,
                          height: 7.h,
                          color: mainColor,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          height: 150,
                          child: Stack(
                            children: [
                              (cubit.x != null)
                                  ? CircleAvatar(
                                      radius: 90.r,
                                      backgroundImage: FileImage(cubit.x),
                                    )
                                  : CircleAvatar(
                                      radius: 90.r,
                                      backgroundImage:
                                          AssetImage("assets/images/pp.png"),
                                    ),
                              Positioned(
                                right: 25.w,
                                bottom: -10.h,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Pick Image'),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                cubit.GalleryImage();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Gallery')),
                                          ElevatedButton(
                                              onPressed: () {
                                                cubit.CameraImage();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Camera')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Go Back'))
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: mainColor,
                                    size: 50.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Blood type",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.004,
                        ),
                        BloodTypeDropDown(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.008,
                        ),
                        SignupTextField(
                          hintText: 'Enter your Weight',
                          text: 'Weight',
                          controller: weight,
                          keyboardtype: TextInputType.number,
                          validatorText: 'Please enter your weight',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.008,
                        ),
                        SignupTextField(
                          hintText: 'Enter your Height',
                          text: 'Height',
                          controller: height,
                          keyboardtype: TextInputType.number,
                          validatorText: 'Please enter your height',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.008,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Checkbox(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                activeColor: mainColor,
                                value: cubit.policyTerms,
                                onChanged: (value) {
                                  cubit.acceptPolicy(value!);
                                },
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text('I accept the policy and terms',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                (cubit.check != true)
                                    ? Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Please accept the policy ",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18.sp),
                                        ))
                                    : Text(""),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Buttons_without_icon(
                          function: () {
                            if (formKey.currentState!.validate() &&
                                (cubit.policyTerms)) {
                              cubit.ChangeCheck();
                              print('done');
                            } else {
                              cubit.ChangeCheck();
                              print('not done');
                            }
                          },
                          num_hieght: 80.h,
                          text_button_name: 'Sign up',
                          button_color: mainColor,
                          num_border: 30,
                          num_fontsize: 20,
                          text_fontwwieght: FontWeight.normal,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.008,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
