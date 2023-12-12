import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoticeTitle extends StatefulWidget {
  final Notice noticeValue;
  final int? id;
  const NoticeTitle({super.key, required this.noticeValue, required this.id});

  @override
  State<NoticeTitle> createState() => _NoticeTitleState();
}

String removeHtmlTags(String htmlString) {
  var document = parse(htmlString);
  String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}

class _NoticeTitleState extends State<NoticeTitle> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
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
            widget.noticeValue.title.toString(),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          subtitle: Text(
            DateFormat('dd-MM-yyyy--HH:mm')
                .format(widget.noticeValue.createdAt!)
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
      body: SingleChildScrollView(
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
                    removeHtmlTags(widget.noticeValue.description.toString()),
                    style: TextStyle(fontSize: 14.sp)),
              ),
            )),
        Text(
            removeHtmlTags(
                '${widget.noticeValue.title}\n ${widget.noticeValue.summary}\n ${widget.noticeValue.description}'),
            style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 30.h),
        Form(
          key: _formKey,
          child: FutureBuilder<List<Notice>>(
              future: ApiService().getUserSingle(widget.id),
              builder: (context, AsyncSnapshot<List<Notice>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  for (var dataForms in snapshot.data!) {
                    final singleNoticeData = dataForms;
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
                            if ((singleNoticeData.formdata[index].required ==
                                        false ||
                                    singleNoticeData.formdata[index].required ==
                                        true) &&
                                (singleNoticeData.formdata[index].value !=
                                        null ||
                                    singleNoticeData.formdata[index].value ==
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
                                      contentPadding: const EdgeInsets.all(8)),
                                  onChanged: (value) {},
                                ),
                              );
                            }
                          } else if (singleNoticeData.formdata[index].type ==
                                  "checkbox-group" &&
                              singleNoticeData
                                  .formdata[index].name!.isNotEmpty) {
                            if ((singleNoticeData.formdata[index].required ==
                                        false ||
                                    singleNoticeData.formdata[index].required ==
                                        true) &&
                                (singleNoticeData.formdata[index].access ==
                                        false ||
                                    singleNoticeData.formdata[index].access ==
                                        true) &&
                                (singleNoticeData.formdata[index].inline ==
                                        false ||
                                    singleNoticeData.formdata[index].inline ==
                                        true) &&
                                (singleNoticeData.formdata[index].toggle ==
                                        false ||
                                    singleNoticeData.formdata[index].toggle ==
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
                          } else if (singleNoticeData.formdata[index].type ==
                                  "date" &&
                              singleNoticeData.formdata[index].subtype ==
                                  "date" &&
                              singleNoticeData
                                  .formdata[index].name!.isNotEmpty) {
                            if ((singleNoticeData.formdata[index].required ==
                                        false ||
                                    singleNoticeData.formdata[index].required ==
                                        true) &&
                                (singleNoticeData.formdata[index].access ==
                                        false ||
                                    singleNoticeData.formdata[index].access ==
                                        true) &&
                                (singleNoticeData.formdata[index].value !=
                                        null ||
                                    singleNoticeData.formdata[index].value ==
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
                                            .formdata[index].value
                                            .toString()),
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(8)),
                                    onTap: () async {
                                      _dateController.text =
                                          await dp.dateTimePicker(context);
                                    },
                                  ),
                                ),
                              );
                            }
                          } else if (singleNoticeData.formdata[index].type ==
                                  "file" &&
                              singleNoticeData.formdata[index].multiple ==
                                  false &&
                              singleNoticeData
                                  .formdata[index].name!.isNotEmpty) {
                            if ((singleNoticeData.formdata[index].required ==
                                        false ||
                                    singleNoticeData.formdata[index].required ==
                                        true) &&
                                (singleNoticeData.formdata[index].access ==
                                        false ||
                                    singleNoticeData.formdata[index].access ==
                                        true) &&
                                (singleNoticeData.formdata[index].value !=
                                        null ||
                                    singleNoticeData.formdata[index].value ==
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
                                    onTap: () async {
                                      _fileController.text = await fpp
                                          .filePickerFromGallery(context);
                                    },
                                  ),
                                ),
                              );
                            }
                          } else if (singleNoticeData.formdata[index].type ==
                                  "number" &&
                              singleNoticeData.formdata[index].subtype ==
                                  "number" &&
                              singleNoticeData
                                  .formdata[index].name!.isNotEmpty) {
                            if ((singleNoticeData.formdata[index].required ==
                                        false ||
                                    singleNoticeData.formdata[index].required ==
                                        true) &&
                                (singleNoticeData.formdata[index].access ==
                                        false ||
                                    singleNoticeData.formdata[index].access ==
                                        true) &&
                                (singleNoticeData.formdata[index].value !=
                                        null ||
                                    singleNoticeData.formdata[index].value ==
                                        null)) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextFormField(
                                  controller: _numberController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      enabled: true,
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      label: Text(singleNoticeData
                                          .formdata[index].label
                                          .toString()),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(8)),
                                  onChanged: (value) {},
                                ),
                              );
                            }
                          } else if (singleNoticeData.formdata[index].type ==
                                  "radio-group" &&
                              singleNoticeData
                                  .formdata[index].name!.isNotEmpty) {
                            if ((singleNoticeData.formdata[index].required ==
                                        false ||
                                    singleNoticeData.formdata[index].required ==
                                        true) &&
                                (singleNoticeData.formdata[index].access ==
                                        false ||
                                    singleNoticeData.formdata[index].access ==
                                        true) &&
                                (singleNoticeData.formdata[index].value !=
                                        null ||
                                    singleNoticeData.formdata[index].value ==
                                        null) &&
                                (singleNoticeData.formdata[index].inline ==
                                        false ||
                                    singleNoticeData.formdata[index].inline ==
                                        true)) {
                              return Column(
                                  children: singleNoticeData
                                      .formdata[index].values
                                      .map((e) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 4.h),
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)),
                                        border: Border.all()),
                                    child: RadioListTile(
                                      title: Text(e.label.toString()),
                                      value: e.value,
                                      groupValue: e.selected,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                );
                              }).toList());
                            }
                          } else if (singleNoticeData.formdata[index].type ==
                                  "select" &&
                              singleNoticeData
                                  .formdata[index].name!.isNotEmpty) {
                            for (int j = 0;
                                j <
                                    singleNoticeData
                                        .formdata[index].values.length;
                                j++) {
                              if ((singleNoticeData.formdata[index].required ==
                                          false ||
                                      singleNoticeData
                                              .formdata[index].required ==
                                          true) &&
                                  (singleNoticeData.formdata[index].access ==
                                          false ||
                                      singleNoticeData.formdata[index].access ==
                                          true)) {
                                return Padding(
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
                                      child: DropdownButtonFormField(
                                        value: singleNoticeData
                                            .formdata[index].values[j].value,
                                        items: singleNoticeData
                                            .formdata[index].values
                                            .map<DropdownMenuItem>((e) {
                                          return DropdownMenuItem(
                                            value: e.value,
                                            child: Text(e.label!),
                                          );
                                        }).toList(),
                                        onChanged: (value) {},
                                        validator: (value) {
                                          value == null
                                              ? 'select category'
                                              : null;
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                          } else if (singleNoticeData.formdata[index].type ==
                                  "button" &&
                              singleNoticeData.formdata[index].subtype ==
                                  "submit") {
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
                                      onPressed: () {},
                                      child: Text(
                                        singleNoticeData.formdata[index].label
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
                  return const Center(child: Text('Something went wrong'));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              }),
        ),
        SizedBox(height: 20.h),
      ])),
    ));
  }
}
