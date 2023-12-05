import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

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
  @override
  Widget build(BuildContext context) {
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
                ' ${widget.noticeValue.id}\n ${widget.noticeValue.title}\n ${widget.noticeValue.summary}\n ${widget.noticeValue.description}'),
            style: TextStyle(fontSize: 16.sp)),
        SizedBox(height: 30.h),
        FutureBuilder<List<Notice>>(
            future: ApiService().getUserSingle(widget.id),
            builder: (context, AsyncSnapshot<List<Notice>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                final singleNoticeData =
                    snapshot.data!.map((e) => e.formdata).toList();

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: singleNoticeData.length,
                    itemBuilder: (context, index) {
                      if (singleNoticeData[index]
                              .map((e) => e.type == "text")
                              .isNotEmpty &&
                          singleNoticeData[index]
                              .map((e) => e.required == false)
                              .isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                                enabled: true,
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                label: Text(singleNoticeData
                                    .map((e) => e[index].label)
                                    .toString()),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.all(8)),
                            onChanged: (value) {},
                          ),
                        );
                      }
                      //  else if (singleNoticeData.formdata[index].type ==
                      //         "checkbox-group" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: Container(
                      //       height: 50.h,
                      //       decoration: BoxDecoration(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(10.r)),
                      //           border: Border.all()),
                      //       child: CheckboxListTile(
                      //         activeColor:
                      //             const Color.fromARGB(255, 25, 74, 159),
                      //         title: Text(singleNoticeData
                      //             .formdata[index].values[0].label
                      //             .toString()),
                      //         value: singleNoticeData
                      //             .formdata[index].values[0].selected,
                      //         onChanged: (bool? value) {},
                      //       ),
                      //     ),
                      //   );
                      // } else if (singleNoticeData.formdata[index].type == "date" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: TextFormField(
                      //       readOnly: true,
                      //       decoration: InputDecoration(
                      //           enabled: true,
                      //           border: const UnderlineInputBorder(
                      //               borderSide: BorderSide.none),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           label: Text(singleNoticeData
                      //               .formdata[index].label
                      //               .toString()),
                      //           fillColor: Colors.white,
                      //           filled: true,
                      //           contentPadding: const EdgeInsets.all(8)),
                      //     ),
                      //   );
                      // } else if (singleNoticeData.formdata[index].type ==
                      //         "file" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: TextFormField(
                      //       readOnly: true,
                      //       decoration: InputDecoration(
                      //           enabled: true,
                      //           border: const UnderlineInputBorder(
                      //               borderSide: BorderSide.none),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           label: Text(singleNoticeData
                      //               .formdata[index].label
                      //               .toString()),
                      //           fillColor: Colors.white,
                      //           filled: true,
                      //           contentPadding: const EdgeInsets.all(8)),
                      //     ),
                      //   );
                      // } else if (singleNoticeData.formdata[index].type ==
                      //         "number" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: TextFormField(
                      //       readOnly: true,
                      //       decoration: InputDecoration(
                      //           enabled: true,
                      //           enabledBorder: const OutlineInputBorder(
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(10))),
                      //           border: const UnderlineInputBorder(
                      //               borderSide: BorderSide.none),
                      //           label: Text(singleNoticeData
                      //               .formdata[index].label
                      //               .toString()),
                      //           fillColor: Colors.white,
                      //           filled: true,
                      //           contentPadding: const EdgeInsets.all(8)),
                      //     ),
                      //   );
                      // } else if (singleNoticeData.formdata[index].type ==
                      //         "radio-group" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   return Padding(
                      //       padding: const EdgeInsets.all(3.0),
                      //       child: Column(
                      //         children: singleNoticeData.formdata[index].values
                      //             .map((option) {
                      //           return Container(
                      //             margin: EdgeInsets.symmetric(vertical: 4.h),
                      //             height: 50.h,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.all(
                      //                     Radius.circular(10.r)),
                      //                 border: Border.all()),
                      //             child: ListTile(
                      //               title: Text(option.label.toString()),
                      //               leading: Radio(
                      //                 value: option,
                      //                 groupValue: option.selected,
                      //                 onChanged: (value) {},
                      //               ),
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ));
                      // } else if (singleNoticeData.formdata[index].type ==
                      //         "select" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   for (int i = 0;
                      //       i <=
                      //           singleNoticeData.formdata[index].values.length -
                      //               1;) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(3.0),
                      //       child: Container(
                      //         margin: EdgeInsets.symmetric(vertical: 4.h),
                      //         height: 50.h,
                      //         decoration: BoxDecoration(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(10.r)),
                      //             border: Border.all()),
                      //         child: Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               horizontal: 10.w, vertical: 2.h),
                      //           child: DropdownButtonFormField(
                      //             decoration: const InputDecoration(
                      //                 border: UnderlineInputBorder(
                      //                     borderSide: BorderSide.none)),
                      //             value: singleNoticeData
                      //                 .formdata[index].values[1].value,
                      //             onChanged: (value) {},
                      //             items: singleNoticeData.formdata[index].values
                      //                 .map((option) {
                      //               return DropdownMenuItem(
                      //                 value: option.value,
                      //                 child: Text(option.label.toString()),
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   }
                      // } else if (singleNoticeData.formdata[index].type ==
                      //         "text" &&
                      //     singleNoticeData.formdata[index].required == false) {
                      //   return Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: TextFormField(
                      //       readOnly: true,
                      //       decoration: InputDecoration(
                      //           enabled: true,
                      //           border: const UnderlineInputBorder(
                      //               borderSide: BorderSide.none),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //           ),
                      //           label: Text(singleNoticeData
                      //               .formdata[index].label
                      //               .toString()),
                      //           fillColor: Colors.white,
                      //           filled: true,
                      //           contentPadding: const EdgeInsets.all(8)),
                      //     ),
                      //   );
                      // } else if (singleNoticeData.formdata[index].type ==
                      //         "button" &&
                      //     singleNoticeData.formdata[index].subtype == "submit") {
                      //   return Padding(
                      //       padding: const EdgeInsets.all(3.0),
                      //       child: SizedBox(
                      //         height: 45.h,
                      //         child: ElevatedButton(
                      //             style: const ButtonStyle(
                      //                 shape: MaterialStatePropertyAll(
                      //                     RoundedRectangleBorder(
                      //                         side: BorderSide.none)),
                      //                 backgroundColor: MaterialStatePropertyAll(
                      //                     Color.fromARGB(255, 25, 74, 159))),
                      //             onPressed: () {},
                      //             child: Text(
                      //               singleNoticeData.formdata[index].label
                      //                   .toString(),
                      //               style: const TextStyle(color: Colors.white),
                      //             )),
                      //       ));
                      // }
                      return null;
                    },
                  ),
                );
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            }),
        SizedBox(height: 20.h),
      ])),
    ));
  }
}
