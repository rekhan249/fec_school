// ignore_for_file: unused_element
import 'package:fec_app2/models/events_model.dart';
import 'package:fec_app2/providers/events_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/event_title.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/events';
  final String? payload;
  const EventScreen({required this.payload, super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final EventsProvider _eventsProvider = EventsProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper4(),
                    child: Container(
                      color: Colors.amber,
                      height: 140.h,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CurvedBottomClipper3(),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 133.h,
                                width: 400.w,
                                child: Image.asset(
                                  'assets/images/dashboard.png',
                                  fit: BoxFit.cover,
                                  alignment: const FractionalOffset(1, 1),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)
                                            .withOpacity(0.5),
                                    height: 133.h,
                                    width: 400.w,
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 40.h,
                            left: 130.w,
                            right: 130.w,
                            child: Text(
                              'Events',
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                        Positioned(
                            top: 0.h,
                            left: 0.w,
                            child: IconButton(
                                onPressed: () {
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
              SizedBox(height: 30.h),
              FutureBuilder<List<Event>>(
                  future: _eventsProvider.getUsers(),
                  builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      final eventData = snapshot.data;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: eventData!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EventTitle(
                                            eventsValue: eventData[index])));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 140.h,
                                    width: double.infinity.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListTile(
                                          title: Text(
                                            eventData[index].title.toString(),
                                            style: TextStyle(fontSize: 15.sp),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 05.h),
                                              Text(
                                                  eventData[index]
                                                      .summary
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.sp)),
                                              SizedBox(height: 15.h),
                                              Text(
                                                eventData[index]
                                                    .createdAt
                                                    .toString(),
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child:
                                          const Divider(color: Colors.black26)),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
