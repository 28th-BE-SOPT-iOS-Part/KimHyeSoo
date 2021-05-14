
|Week|내용|과제결과|
|:---:|:---------------|:-------------------|
|1주차|iOS 기초, H.I.G를 통한 컴포넌트의 이해, 화면 전환| [1주차과제결과](https://github.com/28th-BE-SOPT-iOS-Part/KimHyeSoo/tree/main/KakaoTalk-Clone#1%EC%A3%BC%EC%B0%A8-%EA%B3%BC%EC%A0%9C---%EA%B8%B0%EB%B3%B8ui%EC%9A%94%EC%86%8C-%ED%99%94%EB%A9%B4%EC%A0%84%ED%99%98) |
|2주차|Autolayout을 통한 기초 UI구성, Scroll View의 이해| [2주차과제결과](https://github.com/28th-BE-SOPT-iOS-Part/KimHyeSoo/tree/main/KakaoTalk-Clone#2%EC%A3%BC%EC%B0%A8-%EA%B3%BC%EC%A0%9C---view-autolayout-scrollview) ||
|3주차|TableView, CollectionView, 데이터 전달 방식| [3주차과제결과](https://github.com/28th-BE-SOPT-iOS-Part/KimHyeSoo/blob/main/KakaoTalk-Clone/README.md#3%EC%A3%BC%EC%B0%A8-%EA%B3%BC%EC%A0%9C---%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%A0%84%EB%8B%AC-tableview-collectionview)|
|4주차|Cocoapods & Networking + 솝커톤 전 보충 세미나|[4주차과제결과](https://github.com/28th-BE-SOPT-iOS-Part/KimHyeSoo/tree/main/KakaoTalk-Clone#4%EC%A3%BC%EC%B0%A8-%EA%B3%BC%EC%A0%9C---networking)|
|5주차|디자인 합동 세미나||
|6주차|서버 합동 세미나 + 솝커톤||
|7주차|클론 코딩을 통한 실전 UI 구성, Animation, 통신 보충||
|8주차|기획 경선 + 앱잼 전 보충 세미나 + 앱스토어 배포 가이드||


#  1주차 과제 - 기본UI요소, 화면전환

![image](https://user-images.githubusercontent.com/68391767/113694639-f9b83c00-970a-11eb-8f81-950f0d910a02.png)
![image](https://user-images.githubusercontent.com/68391767/113694738-19e7fb00-970b-11eb-988e-740d014f829d.png)


## 결과
✅ 모든 TextField에 clear 버튼 달기 (Appears while editing)

✅ TextField에 placeholder달기

✅ 모든 항목이 채워져 있지 않으면 동작이 일어나지 않도록 하기

✅ 비밀번호는 Secure Text Entry 설정하기

✅ 로그인 → 회원가입 : navigation / 로그인 → 확인 : modal / 회원가입 → 확인 : modal

<img src="https://user-images.githubusercontent.com/68391767/113690321-3b92b380-9706-11eb-9e11-17554b459863.gif" width="300"><img src="https://user-images.githubusercontent.com/68391767/113690334-3f263a80-9706-11eb-9a4c-48ff4b412e86.gif" width="300">

✅ 아이디 만드는 창(두번째)에서 비밀번호와 비밀번호 확인을 다르게 입력하면 alert 창을 띄움

<img src="https://user-images.githubusercontent.com/68391767/114045054-b30d4200-98c2-11eb-9537-71b0a66e1982.png" width="300">

<br><br>

#  2주차 과제 - View, AutoLayout, ScrollView

![image](https://user-images.githubusercontent.com/68391767/115887914-59457400-a48d-11eb-9a22-40aca6e48634.png)

## 결과

### 1. 과제결과

<img src="https://user-images.githubusercontent.com/68391767/115889180-aaa23300-a48e-11eb-904b-2b5a2653ee50.gif" width="300"><img src="https://user-images.githubusercontent.com/68391767/115888859-5b5c0280-a48e-11eb-94f5-388dc2b55df3.gif" width="300">

### 2. 모두 입력x, 비밀번호 != 비밀번호확인 일때 alert

<img src="https://user-images.githubusercontent.com/68391767/115888689-294aa080-a48e-11eb-8aed-c20a3f07e61c.gif" width="300"><img src="https://user-images.githubusercontent.com/68391767/115888602-0fa95900-a48e-11eb-9d9e-b08d9880cfbc.gif" width="300">

<br><br>

# 3주차 과제 - 데이터전달, tableView, CollectionView

## 결과

### 1. (과제1) tableView를 활용하여 친구목록 만들기

완료!!!! headerview를 이용했습니다.

<img src="https://user-images.githubusercontent.com/68391767/117372141-07c4cc80-af04-11eb-86fb-ebfd3d2f423f.png" width="300">

<br>

### 2. (과제2) 해당 tableView에서 셀 클릭했을 때 사진/이름 넘기기

delegate로 할려다가 넘 어려워서 segue prepare 메소드 이용했습니다..

<br>

그리고.. 
일단 친구 목록 사진과 이름은 넘겼는데 문제점을 발견했습니다.. 
1. 프사 사진 크기.. 왜이러죠..
2. 이거 하니까 친구목록은 보내지는데 헤더뷰에 제 프로필 사진 버튼 누르면 안뜨는 문제.. 어디가 잘못된건지 코드를 찬찬히 봐야겠군요.

<img src="https://user-images.githubusercontent.com/68391767/117372765-0647d400-af05-11eb-9f76-7b2738e7ea9b.gif" width="300">




<br>

### 3. (과제3) collectionView를 활용하여 더보기 탭 구성

완료!!


<img src="https://user-images.githubusercontent.com/68391767/117372826-24153900-af05-11eb-86f9-dfb46c1cc2b4.png" width="300">

<br>

### 4. (도전과제1) Actionsheet

완료!!!

<img src="https://user-images.githubusercontent.com/68391767/117373017-76565a00-af05-11eb-8d00-9b20e2488020.png" width="300">

### 5. (도전과제2) TableView Swipe

완료!!

<img src="https://user-images.githubusercontent.com/68391767/117373239-d0571f80-af05-11eb-9e5b-8cf4bfefb9c8.gif" width="300">

<br> 

### 6. (도전과제6) Contextual menu

To be continue...


<br><br>

# 4주차 과제 - NetWorking

![image](https://user-images.githubusercontent.com/68391767/118280197-ef0d7580-b506-11eb-8007-d2f53196fc3e.png)

## 결과

### 1. (과제1) 회원가입

완료


<img src="https://user-images.githubusercontent.com/68391767/118284992-03a03c80-b50c-11eb-8cc8-45e102d4038d.gif" width="300"><img src="https://user-images.githubusercontent.com/68391767/118281095-d0f44500-b507-11eb-9aaf-85a32178aba2.gif" width="300"><img src="https://user-images.githubusercontent.com/68391767/118285549-86c19280-b50c-11eb-9e6d-25dd31b25834.gif" width="300">
<br>

### 2. (과제2) 로그인

완료



<img src="https://user-images.githubusercontent.com/68391767/118284642-9ab8c480-b50b-11eb-9481-43519f5cb2f8.gif" width="300"><img src="https://user-images.githubusercontent.com/68391767/118285364-511ca980-b50c-11eb-966c-78a3aa4f7502.gif" width="300">

<br>

### 3. (도전과제1) 토근저장

to..be..continue..
