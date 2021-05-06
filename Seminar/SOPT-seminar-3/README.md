# 데이터 전달

데이터 전달에는 "직접 전달방식"과 "간접 전달방식"이 있습니다. 

- **직접 전달방식 (동기방식)** 은 데이터를 보내는 곳에서 받는 곳에 직접적으로 넘겨주는 방식입니다.
    1. present / push 할 때에 프로퍼티에 접근해서 넘겨주는 방식
    2. Seuge prepare 메서드를 활용해서 데이터를 넘겨주는 방식
    3. Protocol / Delegate를 활용해서 **데이터를 넘겨받는 방식**
    4. Closure를 활용해서 **데이터를 넘겨받는 방식**
    5. Notification Center를 이용해서 데이터를 넘기는 방식
- **간접 전달방식 (비동기 방식)** 은 데이터를 다른 곳에 던져두고 받는 곳에서 필요할 때 꺼내가는 방식입니다.
    1. AppDelegate.swift를 활용한 방식
    2. UserDefaults를 사용하는 방식
    3. CoreData of Realm을 활용하는 방식

<br>

## 직접 전달 방식

### 1. present / push 할 때 **프로퍼티에 접근**해서 넘겨주는 방식

#### 💎 property ?

  - 클래스 / 구조체 / 열거형에 연관되어있는 값(변수, 상수) 등을 프로퍼티라고 합니다.


#### 💎 원리 ?

   편의상 데이터를 주는 뷰컨을 A뷰컨, 받는 뷰컨을 B뷰컨이라고 하겠습니다.

   - B 뷰컨에 데이터를 받을 프로퍼티를 만들고, A 뷰컨에서 B 뷰컨을 나타내는 인스턴스를 만들어줍니다.
   - 그러면 A 뷰컨에서 (B뷰컨인스턴스).(B뷰컨내 프로퍼티) 로 만든 프로퍼티에 접근이 가능해집니다!

```swift
// A뷰컨
@IBOutlet weak var propertyTextField: UITextField!

// ...

guard let vc = storyboard?.instantiateViewController(identifier: PropertySecondViewController.identifier) as? PropertySecondViewController else { return }
            
/* vc.text = (넘기고 싶은 데이터) */
vc.text = self.propertyTextField.text ?? "" // propertyTextField의 text를 vc(다음 컨트롤러인스턴스)의 text 프로퍼티에 전달해준다.
 ```
    

 ``` swift
// B뷰컨 - PropertySecondViewController
var text : String = "" // text 변수에 값을 전달받는다.
 ```

#### 💎 주의점

- VC를 push하거나 present까지 해야만 데이터가 전달된다.

<br>

### 2. Seuge의 prepare 메소드를 이용해 데이터를 넘겨주는 방식

#### 💎 Seuge

- 두 뷰 사이의 관계를 의미합니다. (뷰컨 사이 화살표)
- 화살표가 시작하는 뷰컨인 **출발점(source)**, 화살표가 도착하는 뷰컨인 **도착점(destination)**으로 이루어져있습니다.
- 화면 전환이 일어나기 전, `prepare(for: sender)` 메서드가 호출됩니다.
  → 이 메서드를 override하여 데이터를 넘겨줍니다.

#### 💎 원리 ?

- 화면 전환이 일어나기 전에 호출되는 `prepare(for: sender)` 메서드를 활용하여 화면이 전환되기 전 데이터를 전달하고, 화면전환된 이후 그 결과를 확인할 수 있도록 합니다.
- `seuge.destination` 은 다음 목적지가 어디인지 나타냅니다.
- 뷰컨 A에 뷰컨 B를 나타내는 인스턴스 vc (seuge.destination을 뷰컨B로 타입캐스팅)를 만들어줍니다.
- 이후에는 property에 접근해 넘겨주는 방식과 같습니다.
  - 뷰컨 B에서 프로퍼티를 만들고(아래는 `text`), 뷰컨 A에서 만든 인스턴스를 통해 접근합니다. (`vc.text`)

```swift
// 뷰컨A  (데이터 뷰컨 A->B로 전달)
override func prepare(for seuge: UIStoryboardSegue, sender: Any?) {

// seuge가 가리키는 곳(목적지)이 SeugeSecondViewController라면 !
  if seuge.destination is SeugeSecondViewController {
    // 해당 seuge의 destination을 타입캐스팅 해서 vc에 SeuguSecondViewController 인스턴스를 선언한다.
    let vc = seuge.destination as? SeugeSecondViewController
    // destination을 통해 접근한 이후에는 똑같이 프로퍼티에 접근해서 데이터를 넘겨준다.
    vc?.text = self.seugeTextField.text ?? ""
  }
}
```

```swift
// 뷰컨 B (데이터 A->B로 전달)
var text : String = ""
```
