# 🚀 jobGo (잡고) : 당신의 커리어를 잡다!
> **ChatGPT API를 활용한 지능형 구인·구직 웹 서비스** <br>
<br>

## 1. 💡 프로젝트 개요 (Overview)

### 🎯 기획 배경 및 목적
최근 LLM(거대 언어 모델)이 다양한 산업군에 확산되는 흐름 속에서, 구직자의 자기소개서 작성과 기업의 채용 공고 작성에 따르는 피로도를 낮추고자 기획했습니다. 기존 구인구직 사이트(사람인, 잡코리아)의 기본 기능에 **OpenAI API를 활용한 AI 첨삭 및 맞춤법 교정 기능을 더해, 사용자 편의성을 극대화한 지능형 매칭 플랫폼**을 목표로 개발했습니다.

### 🤝 협업 방식
- **코드 리뷰 및 형상 관리:** GitHub Flow 전략 사용, PR 전면 리뷰 후 Merge 진행
- **커뮤니케이션:** Slack, Discord

<br>

## 2. 🛠 기술 스택 (Tech Stack)

**Backend**
- `Java 8` `Spring Framework` `Spring Web Security`

**Frontend**
- `JavaScript` `jQuery` `AJAX` `JSP` `HTML/CSS`

**Database & Tools**
- `MySQL` `STS4 (v5.0.7)`

**External APIs**
- `OpenAI API (ChatGPT)` : 구인 공고 생성 및 맞춤법 교정
- `Kakao Map / Local API` : 위치 기반 정보 시각화
- `Naver Login API` : 소셜 로그인 기반 인증

<br>

## 3. 🏗 시스템 아키텍처 (Architecture)

- **디자인 패턴:** 유지보수성과 확장성을 고려하여 **Spring MVC 패턴**(View > Controller > Service > DAO > Database)을 엄격히 준수하여 결합도를 낮췄습니다.

<br>

## 4. 📌 주요 기능 (Core Features)

1. **✨ AI 구인 공고 어시스턴트 (OpenAI 연동)**
   - 기업 회원이 핵심 키워드만 입력하면, AI가 맞춤형 채용 광고 멘트를 자동 생성하여 문서 작성 시간을 단축합니다.
2. **📝 AI 맞춤법 교정 커뮤니티**
   - 구직자 간 소통 게시판에 OpenAI API를 적용, 게시글 작성 시 문맥에 맞는 맞춤법 교정 기능을 제공하여 완성도 높은 소통을 지원합니다.
3. **🔒 Spring Security 기반 인증/인가**
   - 자체 회원가입 외에도 네이버 소셜 로그인 API를 연동하여 접근성을 높였으며, 역할(일반/기업/관리자)에 따른 철저한 권한 제어를 구현했습니다.
4. **🗺 위치 기반 시각화 및 어드민 통합 관리**
   - 카카오 지도 API를 통해 근무지 정보를 직관적으로 제공하고, 어드민 페이지에서 사이트 내 전체 트래픽과 게시물을 통합 관리합니다.

- **배운 점:** 외부 API(AI, 지도, 핀테크)를 연동하면서 RESTful API의 설계 원칙과 JSON 데이터 핸들링에 대한 깊은 이해를 얻을 수 있었습니다. 또한, Spring Security를 적용하며 웹 보안의 중요성과 세션 기반 인증의 흐름을 체화했습니다.
- **향후 개선 계획:** 현재 동기적으로 처리되는 일부 무거운 로직들을 비동기 큐(Queue) 방식으로 개선하여 서버의 부하를 더 줄이는 방향으로 고도화하고 싶습니다.
