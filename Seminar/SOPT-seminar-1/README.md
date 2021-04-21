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
