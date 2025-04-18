# ✨ README.md

## 🌍 Flutter Regional Search App

Flutter 기반의 위치 기반 지역 장소 검색 애플리케이션입니다.


## 🛍️ 기능 소개

- 사용자가 **검색어**를 입력해 지역 장소를 검색할 수 있음
- 또는 **현재 위치**(기본은 서울시청 또는 Geolocator 사용)를 기준으로 주변 장소 자동 탐색
- 각 장소 클릭 시 In-App WebView 또는 외부 브라우저로 상세 페이지 이동
- 유효하지 않은 링크는 별도 안내 텍스트로 표시


## 🔧 사용 기술

| 기술 스택        | 설명 |
|------------------|------|
| Flutter          | UI 개발 및 전체 앱 구조 |
| Riverpod         | 상태 관리 (viewmodel 기반 구조화) |
| Dio              | RESTful API 통신 처리 |
| flutter_dotenv   | 환경 변수 관리 및 시크릿 키 분리 |
| geolocator       | 디바이스 현재 위치 정보 가져오기 |
| url_launcher     | 외부 브라우저로 `http` 링크 처리 |
| flutter_inappwebview | 인앱 웹 페이지 뷰어 |


## ⚖️ API

| API 서비스        | 역할 |
|-------------------|------|
| Naver Local API   | 지역 장소 검색 기능 제공 |
| VWorld Open API   | 위도/경도 기반 행정동 주소 변환 |


## 📂 디렉토리 구조

```
/lib
  ├─ data
  │   ├─ model                # 데이터 모델
  │   └─ repository           # API 레포지토리
  ├─ ui
  │   ├─ home                 # 홈화면 + 검색
  │   └─ detail               # 상세 페이지 (웹뷰)
  ├─ main.dart
.env                    # 환경 변수 파일

```


## 🔐 환경변수 설정 (.env)

```env
NAVER_CLIENT_ID=NAVER_CLIENT_ID
NAVER_CLIENT_SECRET=NAVER_CLIENT_SECRET
VWORLD_API_KEY=VWORLD_API_KEY
```

> ※ `.env`는 `.gitignore`에 반드시 추가하고 절대 커밋하지 말 것!




✔ `.env` 파일은 개인적으로 안전하게 보관하며, 커밋에서 제거되었는지 항상 확인할 것
✔ 퍼블릭 저장소로 전환 전, 민감정보 제거 여부 최종 점검!