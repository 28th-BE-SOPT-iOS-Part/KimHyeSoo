# Layout

## Safe Area?

아이폰 X 부터 나온 개념으로, M자 탈모 아이폰이 등장하면서 상단의 노치와 하단의 홈바에는 콘텐츠가 제대로 표시되지 않기 때문에, 이 부분을 제외하고 **콘텐츠가 안전하게 표시될 수 있는 영역**을 의미합니다.

- Storyboard에서 뷰컨생성하면 Safe Area를 볼 수 있습니다.

![image](https://user-images.githubusercontent.com/68391767/115361632-b9bd8280-a1fb-11eb-8dca-dc49f33895ec.png)

<br>

## View Hierarchy

- **View 안에 View 를 담을 수 있으며**, 이렇게 하면 View의 상하관계가 생깁니다.
- **부모-자식관계**가 형성됩니다. (부모: superview , 자식: subview)
    - subview는 반드시 1개의 superview만 가질 수 있습니다.
    - superview와 subview는 상대적인 관계이므로 subview 아래에 새로운 subview가 생긴다면 새로 생긴 subview에 대해 superview가 되는 것!

<br>

## Layout 잡는 방법

크게 세 가지로 나눌 수 있습니다.

1. Frame 기반으로 레이아웃 잡기 (Frame-based)
2. Autoresizing masks
3. Autolayout

### 🍎 1. Frame 기반 레이아웃 잡기 (frame-based)

frame을 통해 **superview에서 얼마나 떨어져 있는지 + 얼만큼의 width와 height를 가지고 있는지** 잡아준다.

- **frame ❓** superView 좌표시스템(기준) 안에서 자신의 View 위치와 크기를 나타내는 값
- 코드로 하나하나 모든 view의 frame 을 잡아주는 방식이다.
- superview 기준으로 절대값을 잡아서 움직인다.

    → 기기마다 대응하거나 유지보수가 힘들다. (레이아웃 변화 → 다시,,)

### 🍎 2. Autoresizing masks

superView의 frame 자체가 변경되었을 때, view의 frame을 변경하는 방식이다.

- 외부의 변화에만 대응 가능하다.

### 🍎 3. Autolayout

**View 사이의 관계**를 정의하는 방식의 레이아웃이다.

- 해당 제약조건(Constraint)을 바탕으로 각 뷰의 크기를 결정한다. → 제약조건이 충분하지 않으면 에러!
- 외부와 내부 변경에 동적으로 대응할 수 있다.

    ![image](https://user-images.githubusercontent.com/68391767/115361878-fab59700-a1fb-11eb-9eae-cc70764a9bdb.png)

<br>

## Autolayout 자세히 보기 👀

### Autolayout 의 용어
<img src="https://user-images.githubusercontent.com/68391767/115361938-06a15900-a1fc-11eb-86d3-dcae2c1e8d09.png" width="400px">

- Width : 정렬 사각형의 너비
- Height : 정렬 사각형의 높이
- Top :  정렬 사각형의 상단
- Bottom : 정렬 사각형의 하단
- Baseline : 텍스트의 하단 (텍스트가 들어가는 뷰)
- Horizontal : 수평
- Vertical : 수직
- Leading : 리딩, 좌측
- Trailing : 트레일링, 우측
- CenterX : 수평중심
- CenterY : 수직중심

<br>

### Autolayout 설정방법

> 1) 오른쪽 하단의 Add New Constraint를 통해 제약조건을 설정해주는 방법

(각 숫자옆에 화살표 버튼을 누르면 어느 View와의 관계를 설정할지 나온다 → 3-2방법에서 사용됨.)
<img src="https://user-images.githubusercontent.com/68391767/115362092-2a649f00-a1fc-11eb-8d70-35057be9c5dd.png" width="400px">


1. `Spacing to nearest neighbor` : **가장 인접한 뷰**와 얼만큼의 constraint를 가질것인가 ? → 빨간색으로 들어와야 활성화됨.
2. `Constrain to margins` : margin을 고려해서 설정할 것인지?
3. `Width, Height` : 가로 세로길이에 관한 constraint
4. `Aspect Ratio` : 해당 뷰의 가로:세로 비율을 고정한다. (ex. **해당 화면 1:1 잡기 등.. → Multiplier 1:1 로 설정하기**!)

- 설정된 Constraint는 해당 뷰를 클릭한 후 inspector 창에서 확인할 수 있다.

    <img src="https://user-images.githubusercontent.com/68391767/115362138-32bcda00-a1fc-11eb-8e78-7c0516117829.png" width="400px">

![image](https://user-images.githubusercontent.com/68391767/115362171-3badab80-a1fc-11eb-97b6-3c0c2273159f.png)

제약조건을 다 설정하고 나서 preview 창을 띄워 보면 이렇게 기종에 관계없이 모두 같은 레이아웃으로 잘 나오는 것을 볼 수 있을 것이다.!!

<br>

> 2) 두 View 사이의 관계를 정의해주는 방법

설정할 View를 선택한 후, 관계를 설정해 줄 View에 Control 을 누른 채로 드래그해줍니다. (왼쪽에서 해도 되고, stroyboard 상에서 해도 된다. 나는 스토리보드 위에서 해주면 가끔 모든 항목이 나오지 않아서 왼쪽에서 해줬다.)

→ 나는 가장 아래의 view를 가장 위의 View와의 관계를 통해 레이아웃을 설정하기 위해서 아래의 뷰를 선택하고 control을 누른 채로 가장 위의 view로 드래그했다. <br>
<img src="https://user-images.githubusercontent.com/68391767/115362331-626be200-a1fc-11eb-891d-bb59810429b9.png" width="400px">

그러면 이제 여러가지 항목들이 나오는데, Command를 선택한 채로 항목을 선택하면 다중선택을 할 수 있습니다.

<br>

### AutoLayout 의 계산방식

> FirstItem.Attribute1 = (Multiplier) * SecontItem.Attribute2 + Constant

해당되는 Constraint 를 선택하면 우측 Inspector 창에 아래와 같이 나오게 됩니다.

![image](https://user-images.githubusercontent.com/68391767/115362381-6ef03a80-a1fc-11eb-848b-adc6c2e13692.png)

1. FirstItem.Attribute1 은 View3.Width
2. SecondItem.Attribute2 는 View1.Width
3. Multiplier는 1
4. Constant는 0

위 내용의 의미는, View3의 Width 가 View1의 Width 크기의 `1배 + 0` 만큼이라는 이야기 입니다.



![image](https://user-images.githubusercontent.com/68391767/115362413-77487580-a1fc-11eb-85a8-86498620912c.png)

Constant → 30, Multiplier → 1:2으로 바꾼 후,

2위 내용의 의미는 View3의 Width가 View1의 Width크기의 `1/2배 +  30` 이라는 이야기 입니다.

만약 View1.Width가 200이라면, View3.Width는 200/2 + 30 = 130이 된다는 의미죠!

<br>

### Intrinsic Size

`Label`은 애초에 폰트 크기와 텍스트가 정해져 있기 때문에 컨텐츠 자체의 본질적인 크기인 `Intrinsic Size` 계산을 할 수 있습니다. 그래서 **우리가 따로 Width를 잡아주지 않아도 에러가 발생하지 않습니다.**

- Imageview, TextView 는 컨텐츠에 따라 크기가 변하고
- Label, Button, Switch, TextField에서는 width 와 height를 구할 수 있습니다.

이러한 점은 `UIView`와 큰 차이점을 보이는데, UIView 같은 경우에는 **내부 컨텐츠의 크기를 정할 수 없기 때문에** Instrinsic Size 계산을 할 수 없습니다. 그래서 top, leading만 잡아주면 에러가 납니다!

![image](https://user-images.githubusercontent.com/68391767/115362516-96470780-a1fc-11eb-8e93-d5ffea519a93.png)

uiview 에서는 에러가 납니다. (top, leading만 설정해준 후,, 어떤게 더 필요한지 살펴보면 width와 height를 더 설정해줘야 한다고 나오네요.)

<br><br>

# StackView


스택뷰(StackView)는 **View 들을 일정한 간격으로 배치**하기 위해 사용합니다. StackView를 배치한 후 그 내부에 View들을 추가하여 사용하면 됩니다.

물론, View 사이의 관계는 Constraint로도 설계할 수 있지만 Stack View를 이용하면 보다 편하게 배치할 수 있습니다.

![image](https://user-images.githubusercontent.com/68391767/115363050-11a8b900-a1fd-11eb-86b5-110221ccb09c.png)

- `Horizontal Stack View` : View 들을 가로로 배치한다.
- `Vertical Stack View` : View 들을 세로로 배치한다.

StackView에 View를 넣어준 후, View들을 바로 아래계층에 나란히 배치해줍니다. 저는 Vertical Stack View 아래에 View 3개를 배치해주었습니다.

![image](https://user-images.githubusercontent.com/68391767/115363233-3c930d00-a1fd-11eb-8750-c4241cf8bc8b.png)


<br>

## Stack View - Distribution

[https://developer.apple.com/documentation/uikit/uistackview/distribution](https://developer.apple.com/documentation/uikit/uistackview/distribution) 

> The distribution property determines the layout of the arranged views along the stack's axis.

View를 배치한 후, 다시 Stack View에 들어가보면 Inspector 창에 Distribution 이라는 항목을 볼 수 있습니다.

여기에서는 총 5개의 설정을 볼 수 있습니다. 

![image](https://user-images.githubusercontent.com/68391767/115363353-59c7db80-a1fd-11eb-9b82-533390ada9c2.png)


<br>

### 1.  Fill

나머지 View들이 자신의 크기를 갖고, 크기가 설정되지 않은 마지막 View는 StackView의 남은 공간에 꽉 채워지게 됩니다. <br>

<img src="https://user-images.githubusercontent.com/68391767/115363368-5fbdbc80-a1fd-11eb-982f-c15dcce32a2f.png" width="300px">


<br>

### 2. Fill Equally

StackView의 축을 따라 **모든 View가 같은 크기**로 채워지도록 합니다.<br>

<img src="https://user-images.githubusercontent.com/68391767/115363409-69dfbb00-a1fd-11eb-98c2-160b2a66a778.png" width="300px">

<br>

### 3. Fill Proportionally

비율에 맞춰 StackView를 채웁니다. <br>
<img src="https://user-images.githubusercontent.com/68391767/115363437-6f3d0580-a1fd-11eb-88b2-e37152ad239c.png" width="300px">


<br>

### 4. Equal Spacing

모든 View 들이 일정한 간격으로 배치되어 StackView를 채웁니다. <br>
<img src="https://user-images.githubusercontent.com/68391767/115363462-7532e680-a1fd-11eb-9bf2-978096ac8373.png" width="300px">


<br>

### 5. Equal Centering

모든 View가 일정한 Center to Center 간격으로 배치됩니다. <br>
<img src="https://user-images.githubusercontent.com/68391767/115363551-87ad2000-a1fd-11eb-8a0b-38c3539d81ad.png" width="300px">

<br>

Vertical Stack View 에서 Fill Equally 를 한 결과는 아래와 같습니다

<img src="https://user-images.githubusercontent.com/68391767/115363603-91cf1e80-a1fd-11eb-94dc-5604f50a5af7.png" width="300px">


<br>


### Stack View - Spacing

Spacing 숫자를 설정해주면, 각 view 별로 얼만큼의 간격을 갖는지 설정할 수 있습니다.

<img src="https://user-images.githubusercontent.com/68391767/115363655-9c89b380-a1fd-11eb-86a6-f01f28b8d4e3.png" width="300px">
<img src="https://user-images.githubusercontent.com/68391767/115363682-a3182b00-a1fd-11eb-95ef-44cee42cbc98.png" width="300px">

<br><br>
# Scroll View

ScrollView는 스크롤을 이용해 상하좌우로 움직이며 화면보다 넓은 추가적인 컨텐츠를 보여줄 수 있도록 하는 기능입니다.

<br> 

## Scroll View 사용방법

### 1. Freeform 선택

먼저 View Controller를 선택하고, Simulated Size를 Fixed → `Freefrom` 으로 변경해줍니다. 이후 원하는 크기로 설정해줍니다.

<img src="https://user-images.githubusercontent.com/68391767/115365312-3a31b280-a1ff-11eb-9253-407de66bcdcc.png" width="600px">

아래는 height를 2000으로 설정해줬더니, 화면이 길~어졌습니다 ^^..

<img src="https://user-images.githubusercontent.com/68391767/115365472-61887f80-a1ff-11eb-9b46-5258a0967007.png" width="600px">

<br>

### 2. Scroll View 불러오기

Command+shift+L 로 Scroll View를 가져온 후, autolayout을 설정해줍니다. (상하좌우 0,0,0,0으로 설정해줬습니다.) 그러면 빨갛게 오류가 날텐데 Inspector 창에서 Content Layout Guides를 해제해줍니다. <br>

<img src="https://user-images.githubusercontent.com/68391767/115365612-82e96b80-a1ff-11eb-91f6-ccdb9bbac92f.png" width="400px">

<br>

### 3. ScrollView 내부에 새로운 View 추가하기 + Layout 설정하기

ScrollView 내부에 새로운 View를 끌어다 생성합니다.

이후 새롭게 만든 view와 Scroll View를 포함하고 있는 가장 상위 View와의 관계를 설정해줍니다.

- `Equals Width`, `Equals Height` 설정
- Autolayout Constraints 0, 0, 0, 0 으로 설정
- Weight와 Height의 `Multiplier`를 1로 변경

→ 가장 상위 View와 ScrollView 내의 View의 크기를 1:1 크기로 하게 됩니다. <br>

<img src="https://user-images.githubusercontent.com/68391767/115365671-9268b480-a1ff-11eb-8183-d104222b9a40.png" width="400px">

<br>

### 4. Priority  낮추기 **

세로 스크롤을 해주기 위해서, 세로 부분의 Constraint의 `Prioity`를 낮춰주어야 합니다. (1000→250) 이렇게 낮춰주게 되면 나중에 스크롤이 가능해집니다! (Content View 내부 요소의 레이아웃에 따라 자동적으로 Conents View의 길이가 늘어납니다.) <br>

<img src="https://user-images.githubusercontent.com/68391767/115365762-a57b8480-a1ff-11eb-9ba0-4c619e10d1c7.png" width="400px">


<br>

### 5. 내부에 요소들을 추가하고 마지막 요소에는 bottom Constraint 까지 추가해주기!

가장 아래 있는 요소는 `bottom Constaint`까지 추가해주어야 스크롤이 가능해집니다! (끝이 어딘지 명확해져서 Content View의 heigth를 알 수 있게 되니까요!)

<img src="https://user-images.githubusercontent.com/68391767/115365837-b6c49100-a1ff-11eb-91d8-967898392460.png" width="300px">


<br>

### 6. 빌드 후 simulator 실행하면 스크롤 잘 되는것을 확인할 수 있습니다.
