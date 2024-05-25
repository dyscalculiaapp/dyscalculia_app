import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NoticeDialog extends StatelessWidget {
  final String notice;

  NoticeDialog({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 10.0,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
        side: BorderSide(color: Colors.green, width: 2.r), // 다이얼로그 테두리 색
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Text(
                      '안내장',
                      style: TextStyle(
                        fontFamily: 'static',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.green, thickness: 2.0,),
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Text(
                          notice,
                          style: TextStyle(
                            fontFamily: 'static',
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 15.r,
              right: 15.r,
              child: IconButton(
                icon: Icon(
                  MdiIcons.closeThick,
                ),
                color: Colors.green,
                iconSize: 30.r,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
