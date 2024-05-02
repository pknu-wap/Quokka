# 앱 1팀

## 프로젝트 소개
- 시간이 애매하거나 귀찮을 때 이용할 수 있는 부경대학교 학생들을 위한 심부름 서비스 앱입니다!
<br>

  <div align=center><h1> 주요 기능</h1></div>
<ul>
- 부경대 이메일(@pukyong.ac.kr)을 이용하여 부경대 학생만을 위한 심부름 서비스
- 심부름 요청서 작성, 요청서 조회, 심부름 현황 조회, 쪽지 기능

<br>
<br>
</ul>

<div align=center><h1>🙋‍♂️ 팀원 구성 🙋‍♀️</h1></div>
  
| **이제희** | **민경윤** | **김수현** | **이강민** | **정다은** |
| :------: |  :------: | :------: | :------: | :------: |
| [<img src="https://avatars.githubusercontent.com/JehuiLee" height=150 width=150> <br/> @JehuiLee](https://github.com/JehuiLee) | [<img src="https://avatars.githubusercontent.com/unh6unh6" height=150 width=150> <br/> @unh6unh6](https://github.com/unh6unh6) | [<img src="https://avatars.githubusercontent.com/suhyun113" height=150 width=150> <br/> @suhyun113](https://github.com/suhyun113) | [<img src="https://avatars.githubusercontent.com/mututu17" height=150 width=150> <br/> @mututu17](https://github.com/mututu17) | [![쿼카캐](https://github.com/pknu-wap/2024-1_App1/assets/142780364/722c5729-8f0f-443f-9049-2b8e7694bab9) <br/> 정다은]() |

</div>

<br>

<div align=center><h1>📚 기술 스택</h1></div>

<div align=center>
  
  <img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
  <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">

  <br>

  <img src="https://img.shields.io/badge/mariaDB-003545?style=for-the-badge&logo=mariaDB&logoColor=white">
  <img src="https://img.shields.io/badge/amazonaws-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white">
  <br>

  <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
  <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
  <img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
  
  <br>
</div>

<div align=center><h1> 페이지별 기능</h1></div>

### 로그인 페이지
- 학번과 비밀번호를 입력하여 가입된 회원일 경우 로그인하여 심부름 목록 화면으로 넘어갈 수 있습니다.
- 아직 회원이 아닐 경우 회원가입을 버튼을 눌러 회원가입을 할 수 있습니다.

### 회원가입 페이지
- 부경대학교 학생 이메일(pukyong.ac.kr)을 이용하여 이메일로 인증번호를 받고 입력하여 부경대생만 회원가입이 가능합니다.
- 부경대학교 모바일 학생증 사진을 받아와 OCR API를 이용하여 학과, 학번, 이름을 폼에 기입합니다. 만약 틀린 정보가 있다면 수정할 수 있습니다.
- 닉네임을 입력하고 공백과 특수문자를 제외한 2 ~ 12자가 맞는지 유효성 검사 후 중복 확인 버튼을 통해 중복된 닉네임이 있는지 확인합니다.
- 비밀번호를 입력하고 영어 대문자, 소문자, 숫자, 특수문자를 포함하여 8 ~ 20자가 맞는지 확인합니다.
- 비밀번호 입력칸에 한 번 더 입력하여 비밀번호가 일치하는지 확인합니다.

### 메인 페이지
- 심부름 목록이 등록 시간 최신순으로 보여집니다.
- 심부름을 최신순, 거리순, 금액순으로 정렬해서 볼 수 있는 버튼과 모집 중인 심부름만 볼 수 있는 체크박스가 있습니다.
- 심부름 목록에는 요청서의 제목, 도착지, 보수, 요청한 사람의 닉네임과 평점 총 5가지가 표시됩니다.
- 하단 바에는 홈 버튼, 마이 페이지, 글쓰기, 심부름 히스토리 버튼이 있습니다.
- 현재 진행 중인 심부름이 있을 경우에는 심부름 현황 버튼이 활성화됩니다.

### 요청서 작성 페이지
- 제목을 입력하고 몇 시 몇 분까지 요청할 수 있는 일정과 심부름 보수를 입력하고 추가 요청사항이 있다면 입력합니다.
- 도착지는 지도 API를 이용하여 원하는 위치에 핀을 꽂는 방식으로 진행됩니다.
