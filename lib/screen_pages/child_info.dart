// ignore_for_file: use_build_context_synchronously

import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/notification.dart';
import 'package:fec_app2/widgets/class_grade.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:fec_app2/widgets/name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildInformation extends StatefulWidget {
  static const String routeName = '/child-info';
  const ChildInformation({super.key});

  @override
  State<ChildInformation> createState() => _ChildInformationState();
}

class _ChildInformationState extends State<ChildInformation> {
  final _formKey = GlobalKey<FormState>();
  final _parentNameController = TextEditingController();
  final _classController = TextEditingController();

  NotificationServices? notifyServices;
  @override
  void initState() {
    // notifyServices = NotificationServices();
    // notifyServices!.initializationNotifications();
    // notifyServices!.displayNotification(
    //     title: 'Welcome to Flutter', body: "This is Child Screen");
    super.initState();
  }

  void _submitStudentForm(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    print('token $token');
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<ChildInfoProvider>(context, listen: false)
        .onSubmittedStudentsForm(
            context,
            Provider.of<TextFormFieldsProvider>(context, listen: false)
                .textFields,
            _parentNameController.text,
            _classController.text,
            token!);
  }

  @override
  void dispose() {
    _parentNameController.clear();
    _classController.clear();
    Provider.of<TextFormFieldsProvider>(context, listen: false)
        .textFields
        .clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TextFormFieldsProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper5(),
                    child: Container(
                      color: Colors.amber,
                      height: 210.h,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CurvedBottomClipper(),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 203.h,
                                width: 400.w,
                                child: Image.asset(
                                  'assets/images/dashboard.png',
                                  fit: BoxFit.cover,
                                  alignment: const FractionalOffset(1.5, 0.5),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)
                                            .withOpacity(0.5),
                                    height: 211.h,
                                    width: 400.w,
                                  )),
                              Positioned(
                                  left: 80,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/images/mainslogo.png',
                                          height: 180.h,
                                          width: 200.w))),
                              Positioned(
                                  top: 0.h,
                                  left: 0.w,
                                  child: IconButton(
                                      onPressed: () {
                                        notifyServices?.displayNotification(
                                            title: "We add new child",
                                            body: "Notify me");
                                        notifyServices!.scheduledNotification();
                                        Navigator.popAndPushNamed(
                                            context, DashBoard.routeName);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Center(
                  child: Text(
                'Children Info',
                style: TextStyle(
                    fontSize: 30.sp,
                    color: const Color.fromARGB(255, 25, 74, 159),
                    fontWeight: FontWeight.w700),
              )),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Text(
                  'Children Name:',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              SizedBox(height: 05.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Column(
                  children: [
                    Consumer<TextFormFieldsProvider>(
                      builder: (context, provider, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.textFields.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          provider.textFields[index].text,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Enter Name here",
                                        label: Text("Child Name",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black)),
                                        prefixIcon: const Icon(Icons.person,
                                            color: Colors.black),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            borderSide: const BorderSide(
                                                width: 3, color: Colors.grey)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            borderSide: const BorderSide(
                                                width: 3, color: Colors.grey)),
                                      ),
                                      onChanged: (newText) {
                                        provider.textFields[index].text =
                                            newText;
                                      },
                                      validator: ((value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter full name';
                                        } else if (!RegExp(
                                                r"^[a-zA-Z]+(?:\s[a-zA-Z]+)+$")
                                            .hasMatch(value)) {
                                          return 'Please enter valid name';
                                        }
                                        return null;
                                      }),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.add_box,
                                            color: Color.fromARGB(
                                                255, 25, 74, 159)),
                                        onPressed: () {
                                          provider.addTextField('');
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          provider.removeTextField(index);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Text(
                  'Parent Name:',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              SizedBox(height: 05.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: NameField(
                  nameController: _parentNameController,
                  hintText: 'Enter Your Parent Name',
                  labelText: 'Parent Name',
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Text(
                  'Class:',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                ),
              ),
              SizedBox(height: 05.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: ClassGrade(classController: _classController),
              ),
              SizedBox(height: 50.h),
              SizedBox(
                  height: 50.h,
                  width: double.infinity.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.h),
                    child: TextButton(
                        onPressed: () => _submitStudentForm(context),
                        style: ButtonStyle(
                            shape: const MaterialStatePropertyAll(
                                LinearBorder.none),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 25, 74, 159))),
                        child: Text('Add',
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                  )),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    ));
  }
}
