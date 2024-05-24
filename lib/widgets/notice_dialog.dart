import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(60.0),
        side: BorderSide(color: Colors.green, width: 2.0), // 다이얼로그 테두리 색
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '안내장',
                      style: TextStyle(
                        fontFamily: 'static',
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.green, thickness: 2.0,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          notice,
                          style: TextStyle(
                            fontFamily: 'static',
                            fontSize: 35.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: IconButton(
                icon: Icon(
                  MdiIcons.closeThick,
                ),
                color: Colors.green,
                iconSize: 40.0,
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
