# Animation

## Animation이 왜 사용될까?

### 1. 시스템 상태를 나타내기 위해서

→ 로딩하는 동안 아무런 일도 일어나지 않으면 좋지 않은 사용자 경험 제공

- 로딩바
- 당겨서 새로 고침
- 스플래쉬(Splash)화면
    - 앱을 처음 실행했을 때 토큰 만료 여부, 자동 로그인여부, 네트워크 상태 체크, 저장된 데이터 체크 등 파악하는데에 시간이 필요하기 때문에 사전에 필요한 사항들 진행
    - 필요한 사항을 진행하는 동안 스플래쉬 화면을 띄워준다.

### 2. 메뉴 및 전환을 나타내기 위해서

- 메뉴 펼치기, 접기
- 화면 전환

→ 아무거나 쓰면 오히려 서비스의 몰입감을 해칠 수 있음

### 3. 시각적인 피드백을 주기 위해

- 버튼 눌린 표시
- 성공적으로 기능이 수행되었다는 표시
    - face id lock 해제 애니메이션
    - 탭바 인디케이터

<br>

## Loading

### H.I.G에서의 Loading

- 앱이 로딩중이라면 그것을 **명확하게** 표현하라
    - Activity Spinner
    - Progress Bar
- 컨텐츠를 최대한 **빨리** 보여줘라
- 컨텐츠가 로딩되는 중, 즐겁게 해주거나 힌트를 줄 수도 있다.
    - 로딩 중, 시각적 장치나 읽을 거리를 제공
- 로딩 스크린을 커스터마이징 해라
    - 커스텀 로딩화면

<br>

### Activity Indicator를 이용하여 로딩 중 나타내기

'시작'버튼을 눌렀을 때 ActivityIndicator를 재생시키고, '멈춰!'버튼을 눌렀을 때 AcitivityIndicator를 종료시킨다.

→ 보통은 네트워크 통신을 시작할 때 start / 통신이 종료되고 데이터를 받아와 뷰를 그릴때 stop을 해준다.

(통신 시작→ActivityIndicator&Lottie 재생 → 네트워크 처리 시작 → 네트워크 처리 종료 → ActivityIndicator&Lottie종료)

- `lazy 키워드`를 사용하여 변수를 선언한다.
    - 해당 변수가 실제로 사용되는 시점에 초기값이 계산된다.
    - 클로저 내부에서 self 형태로 접근할 수 있다. (lazy가 없다면 self.view.center에서 오류가 발생한다.)

```swift
lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView() // 나중에 반환될 값
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        activityIndicator.center = self.view.center // self.view.center: 현재 뷰컨 뷰의 중심
        
        activityIndicator.color = .purple
        activityIndicator.hidesWhenStopped = true   // 해당 Indicator가 숨겨지면 멈출지
        activityIndicator.style = .medium
        
        activityIndicator.stopAnimating()   // 최초에 해당 Indicator가 선언되었을 때 멈춘 상태로 있기 위해서
        return activityIndicator
    }()
```

- viewDidLoad에서 위에서 만든 activityIndicator를 addSubview 해준다.
    - activityIndicator가  lazy 키워드와 함께 선언되었으므로 addSubview가 호출되는 순간 메모리에 할당된다.

    ```swift
    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.addSubview(activityIndicator)     
    }
    ```

- IBOutlet으로 연결한 시작버튼, 종료버튼에 start와 stop을 작성한다.

    ```swift
    @IBAction func startButtonClicked(_ sender: Any) {
    	activityIndicator.startAnimating()
    }
    ```

    ```swift
    @IBAction func stopButtonClicked(_ sender: Any) {
    	activityIndicator.stopAnimating()
    }
    ```

<br>

### Lottie파일을 이용해 Indicator 만들기

- Lottie?
    - Airbnb에서 개발한 라이브러리로, 애펙으로 만든 애니메이션을 다른 플랫폼에서도 쉽게 사용할 수 있도록 도와주는 라이브러리이다.
    - 디자이너가 애펙파일→JSON파일로 뽑아주면, 그대로 사용하면 된다.
    - 모두 재생되는 것이 아니므로, JSON player같은 걸로 잘 재생되는지 확인한다.
    - [https://svgsprite.com/tools/lottie-player/](https://svgsprite.com/tools/lottie-player/)
    - Lottie로 재생되지 않는다면 GIF를 재생할 수 있는 라이브러리(GIFU)를 사용하자
- AnimationView를 활용하여 JSON파일을 재생할 수 있다.
- 만드는 방법 (시작버튼을 누르면 재생되고, 멈춤을 누르면 정지됨)
    - Podfile에 lottie를 추가해준 후, pod install 한다.

        ```swift
        pod 'lottie-ios'
        ```

    - 애니메이션.json 파일을 프로젝트에 불러온다.
        - Add files to "~" 클릭
        - 해당 파일 선택
    - lazy키워드를 이용해 변수를 선언하고, 값들을 설정해준다.

        ```swift
        lazy var lottieView : AnimationView = {
        	let animationView = AnimationView(name: "7thSeminar_Lottie_sample")
        	animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        	animationView.center = self.view.center
        	animationView.contentMode = .scaleAspectFill
        	animationView.stop()
        	animationView.isHidden = true
        	return animationView   
        }()
        ```

        - 처음 생성될 때 숨긴 상태에서 정지시킨다. → `isHidden` / `stop()`
        - contentMode 도 설정해준다.
    - viewDidLoad에 addSubview를 해준다.

        ```swift
        override func viewDidLoad() {
                super.viewDidLoad()
                self.view.addSubview(lottieView)
                
            }
        ```

    - startButton/stopButton에 play()와 stop()을 추가한다.
        - start 버튼을 누르면 재생한다.

            ```swift
            @IBAction func startButtonClicked(_ sender: Any) {
                    lottieView.isHidden = false
                    lottieView.play()
                }
            ```

        - stop 버튼을 누르면 멈춘다.

            ```swift
            @IBAction func stopButtonClicked(_ sender: Any) {
                    lottieView.isHidden = true
                    lottieView.stop()
                }
            ```

<br>

## 당겨서 새로고침

- Refresh Control
- Scroll View, TableView, CollectionView에서 사용 가능하다.

### TableView에서 당겨서 새로고침하기

- TableViewCell.swift파일과 ViewController파일을 만들고 연결한다.
    - TableViewCell → Cell 에 대한 클래스 매칭 / Identifier 설정
    - ViewController → 뷰컨 클래스 지정 / dalegate, dataSource / TableView IBOutlet으로 연결
- Refresh Control 붙이기
    - UIRefreshControl 인스턴스를 생성한다.

        ```swift
        let refreshControl = UIRefreshControl()
        ```

    - 위에서 생성한 인스턴스의 값이 바뀔 때나 동작할 때 어떤 함수가 동작할지 `#selector`안에 넣어주고 `addTarget`을 매칭해준다.
        - #selector : 함수의 매개변수로 다른 함수를 사용할때 쓰는 키워드

        ```swift
        func initRefresh(){
                refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
                sampleTableView.refreshControl = refreshControl
        }
        ```

        - refreshTable함수
            - refreshControl이 동작했을때 실행되는 함수
            - 해당 DispatchQueue를 통해서 현재로부터 새로고침을 중단하는 부분

            ```swift
            @objc func refreshTable(refresh: UIRefreshControl){
                    print("새로고침 시작")
            				// 현재로부터 새로고침을 중단함
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){ // 1초
                        self.sampleTableView.reloadData()
                        refresh.endRefreshing()
                    }
                }
            ```

    - ViewDidLoad에서 호출한다.

        ```swift
        override func viewDidLoad() {
                super.viewDidLoad()
                
                sampleTableView.delegate = self
                sampleTableView.dataSource = self
                initRefresh()
                // Do any additional setup after loading the view.
        }
        ```

- 배경색, 색상, 텍스트 등 설정 가능
    - backgroundColor : 배경색
    - tintColor : refreshControl 색상
    - attributedTitle : 텍스트

    ```swift
    func initRefresh(){
            refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
            
            refreshControl.backgroundColor = .yellow
            refreshControl.tintColor = .purple
            refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
            
            sampleTableView.refreshControl = refreshControl
        }
    ```

    ![image](https://user-images.githubusercontent.com/68391767/121213723-74dbd100-c8b9-11eb-9bb0-2d037ab9acd2.png)

    
- Lottie 사용해보기
    - AnimationView사용하여 lottieView선언하기

        ```swift
        import Lottie
        //...
        lazy var lottieView : AnimationView = {
                let animationView = AnimationView(name: "7thSeminar_Lottie_sample")
                animationView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                animationView.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 40)
                animationView.contentMode = .scaleAspectFill
                animationView.stop()
                animationView.isHidden = true
                return animationView
                
            }()
        ```

    - 기존 refreshControl 안보이게 하고 lottieView추가하기
        - `refreshControl.addSubview(lottieView)` → lottie형태의 뷰 올리기
        - `refreshControl.tintColor = .color` → 기존의 refreshControl 안보이게 처리하기

        ```swift
        func initRefresh(){
                refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
                refreshControl.addSubview(lottieView)
                refreshControl.tintColor = .clear   // 기존 모양이 보이지 않도록 처리
            
                sampleTableView.refreshControl = refreshControl
            }
        ```

    - 새로고침할때 lottieView가 보이도록 / 딜레이 이후 lottieView가 숨겨지도록 코드 작성하기

        ```swift
        @objc func refreshTable(refresh: UIRefreshControl){
                print("새로고침 시작")
                lottieView.isHidden = false
                lottieView.play()
                
                // 딜레이 후 안보이도록
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    self.sampleTableView.reloadData()
                    self.lottieView.isHidden = true
                    self.lottieView.stop()
                    refresh.endRefreshing()
                }
            }
        ```

<br>

## Splash 화면

- 딜레이 걸고 시간내에 필요한 작업을 수행한다.

<br>

## 코드로 Animation 구현하기

### 방법

1. UIView의 Animate 사용하기 (iOS 4~)
2. Core Animation 사용하기 (iOS 10~)

<br>

### Animation작성하기

- **Closure기반** 작성
- Animation이 실행되는 동안에는 User Interaction이 일시적으로 disable되었다가 이후 다시 enable된다
- 가능한 속성이 정해져있다.
    - 좌표, 레이아웃 관련값 - frame, bounds, center
    - 모양 관련값 - transform
    - 색상 관련값 - alpha, backgroundColor

<br>

### 구성

```swift
UIView.animate(withDuration: <#T##TimeInterval#>,
               delay: <#T##TimeInterval#>,
               options: <#T##UIView.AnimationOptions#>,
               animations: <#T##() -> Void#>,
               completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
```

- withDuration** : 몇 초동안 애니매이션이 진행될지 결정 (2.0 : 2초)
- delay : 몇 초 이후에 시작될지 결정
- options : 애니메이션의 옵션 결정 / 배열을 사용해 동시에 옵션 지정 가능 [.repeat, .autoreverse]
    - `.allowUserInteraction` : 애니메이션 도중 터치 활성화
    - `.repeat` : 애니메이션 무한반복
    - `.autorevrse` : 반대로도 실행가능 (.repeat과 함께 사용)
    - `.curveEaseInout`(기본값) / `.curveEaseln` / `.curveEaseOut` 등.. : 속도지정
- animations** : 실제로 애니메이션이 될 부분을 정의 (어떤 애니메이션을 할지)
    - frame, bounds, center : 뷰의 위치와 크기
    - transform : 좌표 행렬값
    - alpha : 투명도
    - backgroundColor : 배경색
    - contentStretch : 확대 / 축소 영역
- completion : 애니메이션이 모두 종료된 후 실행
    - 클로저 형태로 작성
    - 없다면 nil

<br>

### 작성예시

- 3초동안 애니메이션 실행

```swift
UIView.animate(withDuration: 3.0) {
	print("3초동안 애니메이션 실행할 부분")
}
```

- 2초 딜레이 / 4초동안 autoreverse, repeat 걸고 애니메이션 끝나면 completion 실행

```swift
UIView.animate(withDuration: 4.0, 
							delay: 2.0, 
							options: [.repeat, .autoreverse]){
	print("애니메이션 실행 부분")
} completion: { finished in
	print("애니메이션 끝나고 실행되는 부분")
}

```

- 4초동안 imageView가 뷰의 가운데로 오게 함

```swift
UIView.animate(withDuration: 4) {
	self.sampleImageView.center = self.view.center
}
```

<br>

### CGAffineTransform

- CGAffineTransform을 사용하여 뷰 늘리기, 회전, 움직이기 가능
    - 늘리기

        ```swift
        UIView.animate(withDuration: 4) {
        	let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
        	self.sampleImageView.transform = scale
        }
        ```

    - 회전하기

        ```swift
        UIView.animate(withDuration: 4) {
        		let rotate = CGAffineTransform(rotationAngle: .pi) // 180도만큼 회전
          self.sampleImageView.transform = rotate
        }
        ```

    - 이동 : 현재 x, y 좌표에서 해당 값만큼 더한 곳으로 이동함

        ```swift
        UIView.animate(withDuration: 4) {
        		let trans = CGAffineTransform(translationX: 100, y: 100)
            self.sampleImageView.transform = trans
        }
        ```

- concatenating으로 동시에 묶기
    - 묶어서 combine에 저장하고 한번에 적용하기

        ```swift
        UIView.animate(withDuration: 3) {
        	let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
        	let rotate = CGAffineTransform(rotationAngle: .pi)
        	let move = CGAffineTransform(translationX: 100, y: 100)
                    
        	let combine = scale.concatenating(rotate).concatenating(move)
        	self.sampleImageView.transform = combine
        }
        ```

<br>

### .identity

애니메이션 실행 후 다시 원래대로 돌아가고 싶다면 completion부분에 .identity를 주면 된다.

```swift
UIView.animate(withDuration: 3) {
	let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
	let rotate = CGAffineTransform(rotationAngle: .pi)
	let move = CGAffineTransform(translationX: 100, y: 100)
            
	let combine = scale.concatenating(rotate).concatenating(move)
	self.sampleImageView.transform = combine

} completion: { finished in
	UIView.animate(withDuration: 2.0){
	self.sampleImageView.transform = .identity
	}
}
```

3초동안 애니메이션 실행 후 2초동안 다시 돌아감

<br>

### Constraint에 Animation 걸어주기

- Constraint를 선택하고 IBOutlet으로 연결시켜준다. → `NSLayoutConstraint` 형으로 연결된다.
- 똑같이 animation을 걸어준다.

    ```swift
    self.sampleTopConstraint.constant = 400
    	UIView.animate(withDuration: 3) {
    		self.view.layoutIfNeeded()
    		self.sampleImageView.alpha = 0.5
    }
    ```

    - `layoutIfNeeded()`
        - 수정된 레이아웃대로 다시 그려달라고 요청함
        - 애니메이션이 먹히지 않을때 사용하면 된다
        - 위에서는 Constraint에 준 애니메이션(`self.sampleTopConstraint.constant = 400`)이 작동하지 않아서, 해당 코드를 바깥으로 빼고 안쪽에 `self.view.layoutIfNeeded()`를 해주었다.

<br>

### Completion 지옥 탈출하기.. → animateKeyFrames

- 만약 내가 애니메이션1→애니메이션2→애니메이션3→애니메이션4 순서로 실행하고 싶다면?

    ```swift
    UIView.animate(withDuration: 3) {
                print("애니메이션1")
            } completion: { _ in
                UIView.animate(withDuration: 3) {
                    print("애니메이션2")
                } completion: { _ in
                    UIView.animate(withDuration: 3) {
                        print("애니메이션3")
                    } completion: { _ in
                        UIView.animate(withDuration: 3) {
                            print("애니메이션4")
                        }
                    }
                }
            }
    ```

    → 코드가 난장판이 된다..

- 이럴때는 animateKeyFrames를 이용하면 잘 정리할 수 있다.

    아래는 각각 1초씩 총 4초동안 진행되는 애니메이션이다.

    ```swift
    UIView.animateKeyframes(withDuration: 4, delay: 0) {
    	UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4){
    		print("애니메이션1")
    	}
    	UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4){
    		print("애니메이션2")
    	}
    	UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 1/4){
    		print("애니메이션3")
    	}
    	UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4){
    		print("애니메이션4")
    	}
    }
    ```

    - `withDuration` : 총 애니메이션 길이
    - `withRelativeStartTime` : 각 애니메이션이 언제 시작할지 (0~1 내 상대값)
    - `relativeDuration` : 얼마나 지속될지 (0~1 내 상대값)
