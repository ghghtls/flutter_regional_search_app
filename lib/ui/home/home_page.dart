import 'package:flutter/material.dart';
import 'package:flutter_regional_search_app/ui/detail/detail_page.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.gps_fixed),
            tooltip: '현재 위치로 검색',
            onPressed: () async {
              try {
                // 현재 위치 기반 장소 검색 요청
                await ref
                    .read(HomeViewModelProvider.notifier)
                    .searchFromCurrentLatLng();
              } catch (e) {
                // 오류 처리 (필요하면 SnackBar 등으로 사용자에게 알리기)
                print('위치 기반 검색 실패: $e');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Expanded(
            child:
                homeState.location.isEmpty
                    ? Center(child: Text('검색 결과가 없습니다'))
                    : ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      itemCount: homeState.location.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final loc = homeState.location[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(loc);
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
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
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  loc.roadAddress,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
