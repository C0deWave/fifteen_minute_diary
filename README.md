# fifteen_minute_diary

### 15분 동안만 작성할 수 있는 일기장 앱입니다.

업데이트 예정
- [ ] Docs: readme 업데이트
- [ ] Style: login_screen ui 구현
- [ ] Feat: firebase를 이용한 로그인 연동
- [ ] Feat: 일기를 하나만 쓰도록 제한하기
- [ ] Feat: 남은 시간이 없을때 알림 피드백 주기
- [ ] Feat: 글쓴 기록 애니메이션 추가
- [ ] Feat: 캘린더 뷰에서 총 일기 쓴 시간 환산하기
- [ ] Feat: Post_controller 테스트 코드 만들어 보기
- [ ] Feat: 위젯테스트 만들어보기

최근 업데이트
- [X] Refactor: 싱글톤 해제
- [X] Feat: HiveDatabase 테스트 코드 작성
- [X] Feat: Timer Controller  테스트 코드 작성
- [X] Docs: readme 업데이트

commit 규칙
1. Feat : 새로운 기능에 대한 커밋
2. Fix : 버그 수정에 대한 커밋
3. Build : 빌드 관련 파일 수정에 대한 커밋
4. Chore : 그 외 자잘한 수정에 대한 커밋
5. Ci : CI관련 설정 수정에 대한 커밋
6. Docs : 문서 수정에 대한 커밋
7. Style : 코드 스타일 혹은 포맷 등에 관한 커밋
8. Refactor :  코드 리팩토링에 대한 커밋
9. Test : 테스트 코드 수정에 대한 커밋

---

1월 6일 일기

벌써 한달의 1/5가 지나갔다. 이번달 안에 앱을 만들겠다는 목표를 잘 이루기 위해서는 더 노력해야겠다.
오늘은 테스트 케이스를 만들었는데 만들면서 싱글톤은 유닛테스트에 비 효율적이라는 것을 배워나갔다.
또한 Get이 내부적으로 컨트롤러를 싱글톤의 형태로 관리를 해준다는 것도 알게되어 컨트롤러의 싱글톤 패턴을 해제했다.
많은 것을 배웠지만 진행적인 부분에서는 많이 부족한것 같다.
앞으로 클래스를 만들 때에는 테스트코드도 같이 만드는 습관을 가져 봐야겠다.
오늘도 4km를 달렸다.
이번달에 100km를 달릴수 있을지 나도 궁금하다.

---

라이센스 표기

initSplashScreen에 이용한 ui 라이센스
## **unDraw image licence**

**Copyright 2021 Katerina Limpitsouni**

All images, assets and vectors published on unDraw can be used for free. You can use them for noncommercial and commercial purposes. You do not need to ask permission from or provide credit to the creator or unDraw.

More precisely, unDraw grants you an nonexclusive, worldwide copyright license to download, copy, modify, distribute, perform, and use the assets provided from unDraw for free, including for commercial purposes, without permission from or attributing the creator or unDraw. This license does not include the right to compile assets, vectors or images from unDraw to replicate a similar or competing service, in any form or distribute the assets in packs or otherwise. This extends to automated and non-automated ways to link, embed, scrape, search or download the assets included on the website without our consent.