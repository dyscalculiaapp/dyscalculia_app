import 'package:flutter/material.dart';

class NoticeDialog extends StatelessWidget {
  final String notice;

  NoticeDialog({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 10.0,
      shadowColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0),
        side: BorderSide(color: Colors.green, width: 2.0), // 다이얼로그 테두리 색
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '안내장',
                style: TextStyle(
                  fontFamily: 'static',
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Text(
                notice,
                style: TextStyle(
                  fontFamily: 'static',
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  '닫기',
                  style: TextStyle(
                    fontFamily: 'static',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
