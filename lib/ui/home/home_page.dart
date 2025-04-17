import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            ///컬럼내 타이틀로 변경
            hintText: '검색어를 입력해 주세요',

            border: WidgetStateInputBorder.resolveWith((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.focused)) {
                return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                );
              }
              return OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ); // 기본 테두리 반환
            }),
          ),
        ),
      ),
      body: Container(
        ///title,category,roadAddress
        child: Column(
          children: [Text('title'), Text('category'), Text('roadAddress')],
        ),
      ),
    );
  }
}
