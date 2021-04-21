# Storyboard에서 Assistant 연결하기

View Controller를 클릭한 후, 우측 Inspctor 창에서 Custom Class에 연결할 클래스 이름을 적어줍니다. 

ViewController.swift 파일의 ViewController클래스와 연결하기 위해 View Controller를 적어주었습니다.

![image](https://user-images.githubusercontent.com/68391767/115564396-64fd3300-a2f3-11eb-804e-654f8dc1c7f2.png)

그리고 Assistant 를 열어줍니다. 단축키 `Control+Option+Command+Return`을 이용하거나, 스토리보드 우측 상단에 있는 Editor Option Menu에서 열 수 있습니다.

![image](https://user-images.githubusercontent.com/68391767/115564485-75151280-a2f3-11eb-833c-73faad63eded.png)


그러면 이제 해당 파일과 잘 연결된 것을 볼 수 있습니다!


<br>

# UI 요소 연결하기

Assistant와 연결할 요소를 Control을 누른 채로 옆의 코드에 드래그해줍니다. 이후 Outlet이라는 표기와 함께 변수 이름을 선언할 수 있습니다. 

(변수이름은 lowerCamelCase!)
![image](https://user-images.githubusercontent.com/68391767/115564638-9bd34900-a2f3-11eb-9220-70abe7a6159c.png)

![image](https://user-images.githubusercontent.com/68391767/115564656-a1309380-a2f3-11eb-983d-56229c2bcdc4.png)

저는 label을 연결시켰고, 이름을 titleLabel로 해줬습니다. → `@IBOutlet` 연결 완료

그리고 같은 방법으로 Button을 Control을 누른채로 드래그 하였는데, 이때는 Action 이라는 표기와 함께 메서드의 이름을 선언하게 됩니다.

저는 `changeButtonClicked`라는 이름으로 메서드를 생성했습니다.

![image](https://user-images.githubusercontent.com/68391767/115564683-a8f03800-a2f3-11eb-8ccf-e85743ebf091.png)

→ `@IBAction` 연결 완료

(_sender: Any) 부분의 sender에는 해당 버튼의 객체가 parameter로 들어옵니다.

<br>

# Interface Builder Annotation

→ `@IBAction`, `@IBOutlet`

이들은 Storyboard와의 연결고리를 담당합니다. 이 키워드를 통해 StoryBoard에 있는 컴포넌트와 연결이 가능해집니다.

## @IBAction

```swift
// 예시
@IBAction func changeButtonClicked(_ sender: Any) {
}
```

StoryBoard 상에 선언한 View 객체에게 특정 이벤트가 발생했을 경우(터치, 드래그, 편집 등등) Controller에게 알리는 역할을 합니다.

이 메서드는 이벤트 발생 시 호출되며, 메서드 내에는 **특정 이벤트가 발생했을 때 실행되는 동작들을 정의**합니다.

## @IBOutlet

```swift
// 예시
@IBOutlet weak var titleLabel: UILabel!
```

처리한 결과를 View에 알리고 원하는 동작을 이끄는 역할을 합니다.

View에 존재하는 요소와 Controller를 연결하는 **변수의 개념**으로 생각하면 됩니다.

→ 연결된 항목들은 나중에 값이 변경되기 때문에 연결해주는 것입니다! 아무런 변경이 일어나지 않으면 굳이 연결해줄 필요가 없겠죠,,

- 코드에서 만들어 놓은 @IBOutlet을 호출하고 .(점)을 찍으면 다양한 프로퍼티, 메서드를 호출할 수 있습니다.

    ```swift
    titleLabel.~~~~~ 
    ```

<br><br>

# 화면전환 - Modal

모달은 특정 위치를 누르면 **기존의 창 위에 새로운 창이 뜨는 것**을 말합니다. Modal 방식은 **주로 이용자들의 이목을 집중시켜야 하는 화면을 띄울때** 사용합니다.

- 간략한 정보, **흐름에서 벗어난 정보**를 보여줄때 사용합니다.


## 1. Seuge를 이용하여 Modal 전환하기

먼저 두 View Controller를 생성한 후, 첫 뷰컨에 Button을 삽입합니다.

![image](https://user-images.githubusercontent.com/68391767/115565452-58c5a580-a2f4-11eb-9171-60fff9b1e992.png)

첫번째 뷰컨에 삽입한 Button을 클릭하고 모달로 띄우고자 하는 화면에 `Control + 드래그` 해줍니다.

![image](https://user-images.githubusercontent.com/68391767/115565507-65e29480-a2f4-11eb-9366-d9ea6f20cbc4.png)


그러면 이런게 뜰텐데,, 하나씩 살펴보면

- `Show` : Navigation Controller가 연결되어 있다면 Push처리를 하고, 아닌 경우에는 Present Modally로 처리합니다.
- `Show Detail` : 아이패드에서 사용하는 방식으로, Push 대신 Replace 방식을 사용합니다.
- `Present Modally` : Present 방식의 화면 전환으로, Modal Style, Transition Style 을 변경해서 다양한 방식이 가능합니다.
- `Present As Popover` : 아이패드에서 사용되는 전환방식입니다. 작은 Popup 형태의 View를 띄웁니다.

우리는 Modal 방식 (present)을 이용할 것이므로, **Present Modally**를 선택합니다!

![image](https://user-images.githubusercontent.com/68391767/115565553-6e3acf80-a2f4-11eb-8538-acec6ca85aa4.png)

그러면 화살표 표시와 함께 다음 화면이 모달창으로 전환됩니다!! 여기서 화살표가 바로! Seuge 입니다.

<br>

## 2. 코드를 이용하여 Modal 전환하기 - present, dismiss

`present메서드`를 이용해 Modal 뷰를 띄우고, `dismiss 메서드`를 통해 띄워진 모달 뷰를 사라지게 합니다.

** 코드를 이용한 방식은 Seuge와 함께 사용하면 오류가 날 수 있습니다.

swift 코드를 이용하여 Modal로 화면을 전환하기 위해서는 각 뷰컨마다 class를 하나씩 생성해서 연결해줘야 합니다.

Cocoa Touch Class를 새로 생성하여 UIViewController를 상속받는 클래스 두 개를 만들어 줍니다.

![image](https://user-images.githubusercontent.com/68391767/115565586-7561dd80-a2f4-11eb-8bd0-ebf55b5b7dd3.png)

그리고 두 View Controller 모두 코드와 스토리보드와 연결해주기 위해 Custom Class에 클래스명을 작성해줍니다. 아래에 있는 Storyboard ID도 동일하게 작성해줍니다.

![image](https://user-images.githubusercontent.com/68391767/115565634-7e52af00-a2f4-11eb-95f8-b8575c104d88.png)

<br>

### 2-1) present 사용하기

그리고 첫번째 뷰컨의 Assistant를 열어 코드를 작성해줍니다! Button을 Control+드래그 해서 IBAction 을 만들어준 후 코드를 작성합니다.

```swift
@IBAction func modalButtonClicked(_ sender: Any) {
    
  guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
     
  self.present(nextVC, animated: true, completion: nil)
        
}
```

`guard 구문`을 통해 SecondViewController를 nextVC에 연결해주고 `.present 메서드`를 통해 nextVC를 모달로 띄워줍니다.


이후 코드와 연결한 버튼을 클릭하면 다음 뷰컨으로 잘 넘어가는 것을 볼 수 있습니다!

<br>

### 2-2) dismiss를 이용하여 뒤로가기

먼저 두 번째 뷰컨에 뒤로가기 버튼을 만들고 @IBAction 으로 연결해줍니다.

![image](https://user-images.githubusercontent.com/68391767/115565844-b1953e00-a2f4-11eb-95c2-6cf467cb9e41.png)

그리고 Button과 연결한 메서드에 다음과 같은 코드를 작성해줍니다.

```swift
@IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
```

`dismiss 메서드`는 present로 띄워진 뷰를 사라지게 하는 메서드입니다.

<br>

## Modal 전환방식 바꾸기

### modalPresentationStyle

새로운 Modal창을 어떻게 보여줄지 옵션을 이용해 설정할 수 있습니다.

```swift
(뷰컨인스턴스).modalPresentationStyle = .(옵션)
```

- automatic - 시스템에서 정한 기본 옵션 (위를 남기고 덮음)
- fullScreen - 위를 남기기 않고 새로운 모달로 창을 끝까지 덮음
- overCurrentContext - 새로운 모달창이 투명하면 이전 뷰도 함께 보임

<br>

### modalTransitionStyle

새로운 Modal창을 전환하는 방법을 옵션을 이용해 설정할 수 있습니다.

```swift
(뷰컨인스턴스).modalTransitionStyle = .(옵션)
```

- coverVertical - 아래에서 나와 뷰를 올리는 방식
- crossDissolve - 뷰가 교차되면서 전환되는 방식
