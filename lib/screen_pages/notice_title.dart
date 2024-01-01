// ignore_for_file: unused_field, unused_element, use_build_context_synchronously

import 'package:fec_app2/models/checkbox_model.dart';
import 'package:fec_app2/models/dropdown_model.dart';
import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/models/radio_group_model.dart';
import 'package:fec_app2/providers/checkbox_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/dropdown_provider.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/formdata_submission.dart';
import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/providers/radiogroup_provider.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoticeTitle extends StatefulWidget {
  final Notice? noticeValue;
  final int? id;
  final String? mid;
  final String? mtype;

  const NoticeTitle(
      {super.key, this.noticeValue, this.id, this.mid, this.mtype});

  @override
  State<NoticeTitle> createState() => _NoticeTitleState();
}

class _NoticeTitleState extends State<NoticeTitle> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final List<List<TextEditingController>> _textControllers = [];
  final List<List<TextEditingController>> _dateControllers = [];
  final List<List<TextEditingController>> _fileControllers = [];
  final List<List<TextEditingController>> _numberControllers = [];
  String selectedDropItem = "";
  String selectedRadioButton = "";
  List<Notice> noticeListValue = [];
  DateFormat dateFormat = DateFormat("dd-mm-yyyy");
  void _submitFormData(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();

    Provider.of<FormDataSubmissionProvider>(context, listen: false)
        .submissionFormData();
  }

  bool isloading = true;
  getSingleNotice() async {
    await Provider.of<DropDownProvider>(context, listen: false)
        .apiAccessDropDown(widget.id);
    await Provider.of<RadioGroupProvider>(context, listen: false)
        .apiAccessRadioGroupes(widget.id);
    noticeListValue = await ApiService().getUserSingle(widget.id);

    for (int i = 0; i < noticeListValue.length; i++) {
      List<TextEditingController> controllersText = [];
      List<TextEditingController> controllersDates = [];
      List<TextEditingController> controllersFiles = [];
      List<TextEditingController> controllersNumbers = [];
      for (int j = 0; j < noticeListValue[i].formdata.length; j++) {
        controllersText.add(TextEditingController());
        controllersDates.add(TextEditingController());
        controllersFiles.add(TextEditingController());
        controllersNumbers.add(TextEditingController());
        // if ((noticeListValue[i].formdata[j].type == "text" &&
        //         noticeListValue[i].formdata[j].subtype == "text") &&
        //     noticeListValue[i].formdata[j].name!.isNotEmpty) {
        // } else if (noticeListValue[i].formdata[j].type == "radio-group" &&
        //     noticeListValue[i].formdata[j].name!.isNotEmpty) {
        //   for (int k = 0;
        //       k < noticeListValue[i].formdata[j].values.length;
        //       k++) {
        //     if (noticeListValue[i].formdata[j].values[k].selected == true) {
        //       selectedRadioButton =
        //           noticeListValue[i].formdata[j].values[k].value!;
        //       if (kDebugMode) {
        //         print(
        //             '=*******************=${noticeListValue[i].formdata[j].values[k].value!}');
        //       }
        //     }
        //   }
        // } else if (noticeListValue[i].formdata[j].type == "select" &&
        //     noticeListValue[i].formdata[j].name!.isNotEmpty) {
        //   for (int k = 0;
        //       k < noticeListValue[i].formdata[j].values.length;
        //       k++) {
        //     if (noticeListValue[i].formdata[j].values[k].selected == true) {
        //       selectedDropItem =
        //           noticeListValue[i].formdata[j].values[k].value!;
        //       if (kDebugMode) {
        //         print(
        //             '==============${noticeListValue[i].formdata[j].values[k].value!}');
        //       }
        //     }
        //   }
        // }
      }
      _textControllers.add(controllersText);
      _dateControllers.add(controllersDates);
      _fileControllers.add(controllersFiles);
      _numberControllers.add(controllersNumbers);
    }

    isloading = false;
    setState(() {});
  }

  String removeHtmlTags(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  final PushNotificationServices _pushNotificationServices =
      PushNotificationServices();

  @override
  void initState() {
    _pushNotificationServices.requestForNotificationPermissions();
    _pushNotificationServices.getDeviceToken().then((value) {
      // if (kDebugMode) {
      //   print('===========> \n $value');
      // }
    });
    _pushNotificationServices.notificationInit(context);
    _pushNotificationServices.getDeviceTokenRefreshing();
    _pushNotificationServices.setUpMessageInteraction(context);
    getSingleNotice();
    Provider.of<CheckBoxProvider>(context, listen: false)
        .apiAccessCheckBoxes(widget.id);

    super.initState();
  }

  @override
  void dispose() {
    for (var controllerTexts in _textControllers) {
      for (var controller in controllerTexts) {
        controller.dispose();
      }
    }
    for (var controllerDate in _dateControllers) {
      for (var controller in controllerDate) {
        controller.dispose();
      }
    }
    for (var controllerFile in _fileControllers) {
      for (var controller in controllerFile) {
        controller.dispose();
      }
    }
    for (var controllerNumber in _numberControllers) {
      for (var controller in controllerNumber) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FilePickerProvider>(context, listen: false);
    Provider.of<DateTimeProvider>(context, listen: false);
    Provider.of<CheckBoxProvider>(context, listen: false);
    Provider.of<DropDownProvider>(context, listen: false);
    Provider.of<RadioGroupProvider>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 74, 159),
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, NoticesScreen.routeName);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: ListTile(
          title: Text(
            widget.noticeValue!.title.toString(),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          subtitle: Text(
            DateFormat('dd-MM-yyyy - HH:mm')
                .format(widget.noticeValue!.createdAt!)
                .toString(),
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ),
        actions: [
          Container(
              width: 70.w,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/images/feclogos.png'))
        ],
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(children: [
              ClipPath(
                clipper: StraightBorderClipper(
                    borderWidth: 0), // Adjust the border width as needed
                child: Container(
                  height: 10.h,
                  width: double.infinity.w,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: Text(
                          removeHtmlTags(
                              widget.noticeValue!.description.toString()),
                          style: TextStyle(fontSize: 16.sp)),
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(removeHtmlTags(widget.noticeValue!.title.toString()),
                      style: TextStyle(fontSize: 16.sp)),
                  Text(removeHtmlTags(widget.noticeValue!.summary.toString()),
                      style: TextStyle(fontSize: 16.sp)),
                  Text(
                      removeHtmlTags(
                          widget.noticeValue!.description.toString()),
                      style: TextStyle(fontSize: 16.sp)),
                ],
              ),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    for (int k = 0; k < noticeListValue.length; k++)
                      for (int l = 0;
                          l < noticeListValue[k].formdata.length;
                          l++)
                        if (noticeListValue[k].formdata[l].type == "text" &&
                            noticeListValue[k].formdata[l].name!.isNotEmpty)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextFormField(
                                  controller: _textControllers[k][l],
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabled: true,
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      label: Text(noticeListValue[k]
                                          .formdata[l]
                                          .label
                                          .toString()),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    if (kDebugMode) {
                                      print('${_textControllers[k][l]}');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                    Consumer<CheckBoxProvider>(
                      builder: (context, cBP, child) => Column(
                        children: [
                          for (List<CheckboxModel> checkboxModel
                              in cBP.checkboxsList)
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: checkboxModel.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          border: Border.all()),
                                      child: CheckboxListTile(
                                        activeColor: const Color.fromARGB(
                                            255, 25, 74, 159),
                                        title: Text(checkboxModel[index]
                                            .label
                                            .toString()),
                                        value: checkboxModel[index].selected,
                                        onChanged: (value) {
                                          cBP.selectUnselectCheckboxe(value,
                                              checkboxModel[index], index);
                                        },
                                      ),
                                    ),
                                  );
                                })
                        ],
                      ),
                    ),
                    for (int k = 0; k < noticeListValue.length; k++)
                      for (int l = 0;
                          l < noticeListValue[k].formdata.length;
                          l++)
                        if ((noticeListValue[k].formdata[l].type == "date" &&
                                noticeListValue[k].formdata[l].subtype ==
                                    "date") &&
                            noticeListValue[k].formdata[l].name!.isNotEmpty)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Consumer<DateTimeProvider>(
                                  builder: (context, dp, child) =>
                                      TextFormField(
                                    controller: _dateControllers[k][l],
                                    keyboardType: TextInputType.datetime,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabled: true,
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        label: Text(noticeListValue[k]
                                            .formdata[l]
                                            .label
                                            .toString()),
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(8)),
                                    onTap: () async {
                                      _dateControllers[k][l].text =
                                          await dp.dateTimePicker(context);
                                      if (kDebugMode) {
                                        print(
                                            '++++++++++++++ ${_dateControllers[k][l].text}');
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                    for (int k = 0; k < noticeListValue.length; k++)
                      for (int l = 0;
                          l < noticeListValue[k].formdata.length;
                          l++)
                        if (noticeListValue[k].formdata[l].type == "file" &&
                            noticeListValue[k].formdata[l].name!.isNotEmpty)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Consumer<FilePickerProvider>(
                                  builder: (context, fpp, child) =>
                                      TextFormField(
                                    controller: _fileControllers[k][l],
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabled: true,
                                        border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        label: Text(noticeListValue[k]
                                            .formdata[l]
                                            .label
                                            .toString()),
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(8)),
                                    onTap: () async {
                                      _fileControllers[k][l].text = await fpp
                                          .filePickerFromGallery(context);
                                      if (kDebugMode) {
                                        print(
                                            '++++++++++++++ ${_fileControllers[k][l].text}');
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                    for (int k = 0; k < noticeListValue.length; k++)
                      for (int l = 0;
                          l < noticeListValue[k].formdata.length;
                          l++)
                        if ((noticeListValue[k].formdata[l].type == "number" &&
                                noticeListValue[k].formdata[l].subtype ==
                                    "number") &&
                            noticeListValue[k].formdata[l].name!.isNotEmpty)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextFormField(
                                  controller: _numberControllers[k][l],
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      enabled: true,
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      label: Text(noticeListValue[k]
                                          .formdata[l]
                                          .label
                                          .toString()),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    if (kDebugMode) {
                                      print(
                                          '=============== ${_numberControllers[k][l]}');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                    Consumer<RadioGroupProvider>(
                      builder: (context, rGP, child) => Column(children: [
                        for (List<RadioGroupModel> radioModels
                            in rGP.radioGroupsList)
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: radioModels.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.h),
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          border: Border.all()),
                                      child: RadioListTile(
                                        activeColor: const Color.fromARGB(
                                            255, 25, 74, 159),
                                        title: Text(radioModels[index]
                                            .label
                                            .toString()),
                                        selected: radioModels[index].selected,
                                        value: radioModels[index].value,
                                        groupValue: radioModels[index].selected,
                                        onChanged: (value) {},
                                      ),
                                    ));
                              }),
                      ]),
                    ),
                    Consumer<DropDownProvider>(
                      builder: (context, dDP, child) => Column(
                        children: [
                          for (List<DropDownModel> dropDownList
                              in dDP.dropDownsList)
                            Column(
                              children: [
                                // for (DropDownModel dropDown in dropDownList)
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 4.h),
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)),
                                        border: Border.all()),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 2.h),
                                      child: DropdownButtonFormField<
                                          DropDownModel>(
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide.none)),
                                        value: dropDownList.firstWhere(
                                            (element) => element.selected),
                                        items: dropDownList.map<
                                            DropdownMenuItem<
                                                DropDownModel>>((e) {
                                          return DropdownMenuItem<
                                              DropDownModel>(
                                            // value: e.value!,
                                            value: e,
                                            child: Text(e.label),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          dDP.dropDownSelectOne(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    for (int k = 0; k < noticeListValue.length; k++)
                      for (int l = 0;
                          l < noticeListValue[k].formdata.length;
                          l++)
                        if ((noticeListValue[k].formdata[l].type == "button" &&
                                noticeListValue[k].formdata[l].subtype ==
                                    "submit") &&
                            noticeListValue[k].formdata[l].name!.isNotEmpty)
                          Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                height: 45.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 25, 74, 159))),
                                    onPressed: () {
                                      _submitFormData(context);
                                    },
                                    child: Text(
                                      noticeListValue[k]
                                          .formdata[l]
                                          .label
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                              ))
                  ]),
                ),
              ),
              SizedBox(height: 20.h),
            ])),
    ));
  }
}
