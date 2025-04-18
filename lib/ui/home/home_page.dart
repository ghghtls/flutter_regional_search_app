import 'package:flutter/material.dart';
import 'package:flutter_regional_search_app/ui/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void onSearch(String text) {
    //TODO 홈뷰델의 locationSearch 메서드 호출
    ref.read(HomeViewModelProvider.notifier).locationSearch(text);
    print('onSearch 호출됨');
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(HomeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textEditingController,
          onSubmitted: onSearch,
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
      body:
          homeState.location.isEmpty
              ? Center(child: Text('검색 결과가 없습니다'))
              : ListView.builder(
                itemCount: homeState.location.length,
                itemBuilder: (context, index) {
                  final loc = homeState.location[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          loc.category,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 4),
                        Text(
                          loc.roadAddress,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
