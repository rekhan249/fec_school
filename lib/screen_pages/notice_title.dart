// ignore_for_file: unused_field

import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/formdata_submission.dart';
import 'package:fec_app2/providers/notices_provider.dart';
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
  const NoticeTitle({super.key, this.noticeValue, this.id});

  @override
  State<NoticeTitle> createState() => _NoticeTitleState();
}

class _NoticeTitleState extends State<NoticeTitle> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  List<dynamic> radioOption = [];
  late final Function(String)? onChanged;

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
    List<Notice> noticeListValue = await ApiService().getUserSingle(widget.id);
    for (int i = 0; i < noticeListValue.length; i++) {
      for (int j = 0; j < noticeListValue[i].formdata.length; j++) {
        if (noticeListValue[i].formdata[j].type == "select") {
          for (int k = 0;
              k < noticeListValue[i].formdata[j].values.length;
              k++) {
            if (noticeListValue[i].formdata[j].values[k].selected == true) {
              selectedDropItem =
                  noticeListValue[i].formdata[j].values[k].value!;
              if (kDebugMode) {
                print(
                    '==============${noticeListValue[i].formdata[j].values[k].value!}');
              }
            }
          }
        }
      }
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
      if (kDebugMode) {
        // print('===========> \n $value');
      }
    });
    _pushNotificationServices.notificationInit(context);
    _pushNotificationServices.getDeviceTokenRefreshing();
    _pushNotificationServices.setUpMessageInteraction(context, id: widget.id);
    getSingleNotice();
    super.initState();
  }

  String selectedDropItem = "option-1";

  @override
  Widget build(BuildContext context) {
    Provider.of<FilePickerProvider>(context, listen: false);
    Provider.of<DateTimeProvider>(context, listen: false);

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
            DateFormat('dd-MM-yyyy--HH:mm')
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
                          style: TextStyle(fontSize: 14.sp)),
                    ),
                  )),
              Text(
                  removeHtmlTags(
                      '${widget.noticeValue!.title}\n ${widget.noticeValue!.summary}\n ${widget.noticeValue!.description}'),
                  style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 30.h),
              Form(
                key: _formKey,
                child: FutureBuilder<List<Notice>>(
                    future: ApiService().getUserSingle(widget.id),
                    builder: (context, AsyncSnapshot<List<Notice>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        for (var dataForms in snapshot.data!) {
                          Notice singleNoticeData = dataForms;
                          if (kDebugMode) {
                            print('runtimes ${singleNoticeData.runtimeType}');
                            print(
                                'datatime ${singleNoticeData.formdata.map((e) => e.toJson())}');
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: singleNoticeData.formdata.length,
                              itemBuilder: (context, index) {
                                if (singleNoticeData.formdata[index].type == "text" &&
                                    singleNoticeData.formdata[index].subtype ==
                                        "text" &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData.formdata[index].value !=
                                              null ||
                                          singleNoticeData
                                                  .formdata[index].value ==
                                              null)) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: TextFormField(
                                        controller: _textNameController,
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
                                            label: Text(singleNoticeData
                                                .formdata[index].label
                                                .toString()),
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(8)),
                                        onChanged: (value) {},
                                      ),
                                    );
                                  }
                                } else if (singleNoticeData.formdata[index].type ==
                                        "checkbox-group" &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].access ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].access ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].inline ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].inline ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].toggle ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].toggle ==
                                              true)) {
                                    return Column(
                                        children: singleNoticeData
                                            .formdata[index].values
                                            .map((e) {
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r)),
                                              border: Border.all()),
                                          child: CheckboxListTile(
                                            activeColor: const Color.fromARGB(
                                                255, 25, 74, 159),
                                            title: Text(e.label.toString()),
                                            value: e.selected,
                                            onChanged: (bool? value) {},
                                          ),
                                        ),
                                      );
                                    }).toList());
                                  }
                                } else if (singleNoticeData.formdata[index].type == "date" &&
                                    singleNoticeData.formdata[index].subtype ==
                                        "date" &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].access ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].access ==
                                              true) &&
                                      (singleNoticeData.formdata[index].value !=
                                              null ||
                                          singleNoticeData
                                                  .formdata[index].value ==
                                              null)) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Consumer<DateTimeProvider>(
                                        builder: (context, dp, child) =>
                                            TextFormField(
                                          controller: _dateController,
                                          keyboardType: TextInputType.datetime,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              enabled: true,
                                              border:
                                                  const UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              label: Text(singleNoticeData
                                                  .formdata[index].value
                                                  .toString()),
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.all(8)),
                                          onTap: () async {
                                            _dateController.text = await dp
                                                .dateTimePicker(context);
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                } else if (singleNoticeData.formdata[index].type == "file" &&
                                    singleNoticeData.formdata[index].multiple ==
                                        false &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].access ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].access ==
                                              true) &&
                                      (singleNoticeData.formdata[index].value !=
                                              null ||
                                          singleNoticeData
                                                  .formdata[index].value ==
                                              null)) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Consumer<FilePickerProvider>(
                                        builder: (context, fpp, child) =>
                                            TextFormField(
                                          controller: _fileController,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              enabled: true,
                                              border:
                                                  const UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              label: Text(singleNoticeData
                                                  .formdata[index].label
                                                  .toString()),
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.all(8)),
                                          onTap: () async {
                                            _fileController.text = await fpp
                                                .filePickerFromGallery(context);
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                } else if (singleNoticeData.formdata[index].type == "number" &&
                                    singleNoticeData.formdata[index].subtype ==
                                        "number" &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].access ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].access ==
                                              true) &&
                                      (singleNoticeData.formdata[index].value !=
                                              null ||
                                          singleNoticeData
                                                  .formdata[index].value ==
                                              null)) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: TextFormField(
                                        controller: _numberController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            enabled: true,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                            border: const UnderlineInputBorder(
                                                borderSide: BorderSide.none),
                                            label: Text(singleNoticeData
                                                .formdata[index].label
                                                .toString()),
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding:
                                                const EdgeInsets.all(8)),
                                        onChanged: (value) {},
                                      ),
                                    );
                                  }
                                } else if (singleNoticeData.formdata[index].type ==
                                        "radio-group" &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].access ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].access ==
                                              true) &&
                                      (singleNoticeData.formdata[index].value !=
                                              null ||
                                          singleNoticeData
                                                  .formdata[index].value ==
                                              null) &&
                                      (singleNoticeData
                                                  .formdata[index].inline ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].inline ==
                                              true)) {
                                    return Column(
                                        children: singleNoticeData
                                            .formdata[index].values
                                            .map((e) {
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 4.h),
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r)),
                                              border: Border.all()),
                                          child: RadioListTile(
                                            title: Text(e.label.toString()),
                                            value: true,
                                            groupValue: e.selected,
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      );
                                    }).toList());
                                  }
                                } else if (singleNoticeData.formdata[index].type == "select" &&
                                    singleNoticeData
                                        .formdata[index].name!.isNotEmpty) {
                                  if ((singleNoticeData
                                                  .formdata[index].required ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].required ==
                                              true) &&
                                      (singleNoticeData
                                                  .formdata[index].access ==
                                              false ||
                                          singleNoticeData
                                                  .formdata[index].access ==
                                              true)) {
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
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 2.h),
                                          child:
                                              DropdownButtonFormField<dynamic>(
                                            value: selectedDropItem,
                                            // items: [
                                            //   DropdownMenuItem(
                                            //       value: 'opt1',
                                            //       child: Text('option1')),
                                            //   DropdownMenuItem(
                                            //       value: 'opt2',
                                            //       child: Text('option2')),
                                            //   DropdownMenuItem(
                                            //       value: 'opt3',
                                            //       child: Text('option3')),
                                            // ],
                                            items: singleNoticeData
                                                .formdata[index].values
                                                .map<DropdownMenuItem>((e) {
                                              return DropdownMenuItem(
                                                value: e.value,
                                                child: Text(e.label!),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              selectedDropItem = value;
                                            },
                                            decoration: const InputDecoration(
                                                border: UnderlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none)),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else if (singleNoticeData.formdata[index].type ==
                                        "button" &&
                                    singleNoticeData.formdata[index].subtype == "submit") {
                                  return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SizedBox(
                                        height: 45.h,
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
                                              singleNoticeData
                                                  .formdata[index].label
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ));
                                }

                                return null;
                              },
                            ),
                          );
                        }
                        return const Center(
                            child: Text('Something went wrong'));
                      } else {
                        return const Center(
                            child: Text('Something went wrong'));
                      }
                    }),
              ),
              SizedBox(height: 20.h),
            ])),
    ));
  }
}
