# fifteen_minute_diary

### 15분 동안만 작성할 수 있는 일기장 앱입니다.

업데이트 예정

먼 미래 업데이트
- [ ] Feat: 커피 사기 기능 추가
- [ ] Feat: 애플 로그인시 UI에러 확인하기 => 리포지토리에 이슈로 올라옴
--------------------------------------------------------------------------
차후 업데이트
- [ ] Docs: readme 업데이트
- [ ] Feat: 사진 올릴 때 타이머 멈추기
- [ ] Feat: 일기 삭제시 경고주기
- [ ] Fix: 데이터 업로드 다운로드시 다이얼로그 안내해주기
- [ ] Style: 기본 조커이미지 변경하기
- [ ] Feat: 캘린더에 같이 일기 데이터베이스에서 꺼낼때 전부 안꺼내고 해당 월 + - 1월 의 데이터베이스만 꺼내기
- [ ] Fix: 조커 게시글 삭제 불가능 추가
- [ ] Feat: 백업 불러오기시 통계 내용 업데이트 하기
- [ ] Feat: 글쓴 다음에도 통계내용 업데이트 하기
- [ ] Feat: 검색 부분에 게시글이 하나도 없는 경우에는 글쓰라는 이미지 추가

최근 업데이트
- [X] Fix: 해시태그 백업 불러오지 못하는 에러 해결
- [X] Style: 검색 일기 목록 정렬화
- [X] Feat: 태그 선택시 상태변화 추가
- [X] Fix: 태그 2가지 선택시 태그 전부 지워지는 에러 수정
- [X] Refactor: TagController 제거
- [X] Feat: 태그 지정시 필터링하는 기능 추가하기
- [X] Refactor: Tabbar Stateful 에서 stateless로 변경
- [X] Docs: readme 업데이트

commit 규칙
1. Feat : 새로운 기능에 대한 커밋
2. Fix : 버그 수정에 대한 커밋
3. Build : 빌드 관련 파일 수정에 대한 커밋
4. Chore : 그 외 자잘한 수정에 대한 커밋
5. Ci : CI관련 설정 수정에 대한 커밋
6. Docs : 문서 수정에 대한 커밋
7. Style : UI 수정 또는 코드 스타일 혹은 포맷 등에 관한 커밋
8. Refactor :  코드 리팩토링에 대한 커밋
9. Test : 테스트 코드 수정에 대한 커밋

---

1월 28일 일기

드디어 머릿속으로 생각한 커다란 기능은 마무리 되었다.

그래도 이만큼 달려 왔다는 것이 너무나 감사하게 느껴진다.

오늘은 둘러보기 부분의 마지막 검색 부분을 만들어 보았다. 처음에는 카드가 커지는 방법으로 검색이 되게 할까 생각했는데

내일기 목록에서 해당 일기로 넘어가는 액션이 좀 더 괜찮아 보여서 해당 방법을 이용해 보기로 했다.

처음에는 탭을 넘어가면서 카로셀이 아직 생성되지 않아 페이지를 넘어갈 수 없는 에러가 있었는데 우선은 500밀리세컨드를 기다리는 방법으로

회피해버렸다......


이제 주변에서 지적받은 세세한 부분에 대해서 업데이트를 할 예정이다.

가령 업로드나 다운로드 안내메세지라던지 하는 것들이다.

빨리 내 작품이 세상에 나와서 누군가 한명이라도 고객의 의견을 받는 날이 왔으면 한다.

내일은 친구랑 같이 카페에 가기로 했다.

가서 벨로그에 올해 1월 빡세게 앱개발한 후기를 적어볼까 한다.

제발 리젝없이 출시되기를!!!

---

라이센스 표기

initSplashScreen에 이용한 ui 라이센스
## **unDraw image licence**

**Copyright 2021 Katerina Limpitsouni**

All images, assets and vectors published on unDraw can be used for free. You can use them for noncommercial and commercial purposes. You do not need to ask permission from or provide credit to the creator or unDraw.

More precisely, unDraw grants you an nonexclusive, worldwide copyright license to download, copy, modify, distribute, perform, and use the assets provided from unDraw for free, including for commercial purposes, without permission from or attributing the creator or unDraw. This license does not include the right to compile assets, vectors or images from unDraw to replicate a similar or competing service, in any form or distribute the assets in packs or otherwise. This extends to automated and non-automated ways to link, embed, scrape, search or download the assets included on the website without our consent.

## **Drawer Default Image**

 Icons made by [Freepik](https://www.freepik.com) from [www.flaticon.com](https://www.flaticon.com/)