import 'package:fec_app2/models/notices_model.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticeTitle extends StatefulWidget {
  final Notice noticeValue;
  const NoticeTitle({super.key, required this.noticeValue});

  @override
  State<NoticeTitle> createState() => _NoticeTitleState();
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
            widget.noticeValue.createdAt.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
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
                child: Text(widget.noticeValue.description.toString(),
                    style: TextStyle(fontSize: 14.sp)),
              ),
            )),
        if (widget.noticeValue.type != null)
          Text('Type: ${widget.noticeValue.type.toString()}',
              style: TextStyle(fontSize: 16.sp)),
      ])),
    ));
  }
}
