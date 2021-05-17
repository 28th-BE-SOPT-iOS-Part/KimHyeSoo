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

<br>

### 3. delegation을 활용한 방식

#### 💎 delegate pattern ?

- '위임하다', '대표하다'라는 뜻을 가진 delegate는 객체 지향 프로그래밍에서 하나의 객체가 모든 일을 하는 것이 아니라, **처리해야 하는 일 중 일부를 다른 객체에게 위임하는 것을 의미**합니다.
- protocol 형태로 구현됩니다. → [protocol 설명](https://github.com/hyesuuou/iOS-Dev/blob/main/Protocol.md)

#### 💎 delegate 데이터전달 예시

- 프로토콜을 만들어줍니다. `SampleProtocol` 이라는 프로토콜 안에 `dataSend`라는 기능을 만들어주었습니다. (프로토콜이므로 기능에 대한 구현은 하지 않습니다.)

```swift
protocol SampleProtocol
{
    // data라는 String 형을 넘기려고 한다.
    func dataSend(data : String)
}
```

- 데이터가 뷰컨 B → 뷰컨 A로 전달된다고 할 때, 뷰컨 B에서 `SampleProtocol`을 타입으로 하는 `delegate` 프로퍼티를 생성해줍니다.

```swift
/* SampleProtocol 형의 delegate 프로퍼티를 생성한다.*/
var delegate : SampleProtocol?
```

- `delegate?.dataSend(data: text)`를 통해 버튼이 눌렸을 경우 dataSend 기능을 실행해줍니다.

```swift
@IBAction func dataSendButtonClicked(_ sender: Any) {
    
	/* 버튼을 눌렀을 때 delegate의 dataSend에다가 textField의 text를 담아준다.*/
        if let text = dataTextField.text {
            /* delegate 사용 */
            delegate?.dataSend(data: text)
        }
    
        /* 이후 navigation pop 처리*/
        self.navigationController?.popViewController(animated: true)
        
    }
```

→ 아직까지는 dataSend가 어떻게 일어나는지 구현을 해주지 않았는데, 이 구현을 뷰컨 A에서 해주려고 합니다. 

- 이제 뷰컨 A에 와서 **프로토콜을 채택해줍니다**. 이후 fix를 이용해 필요한 기능을 구현해줍니다. 여기서는 dataSend 구현이 필요하기 때문에 fix를 누르면 바로`dataSend`를 구현하도록 코드가 생깁니다~!

```swift
/* dataSend 함수에서 data파라미터를 받아서 dataLebl*/
// delegateDataLabel -> 받은 데이터를 나타낼 
func dataSend(data: String) {
  delegateDataLabel.text = data
}
```

- 그리고 뷰컨 B의 delegate(대리자) 역할을 뷰컨A (현재뷰컨)에서 하도록 하는 코드를 적어줍니다. 이제 대신 처리할 부분은 뷰컨 A에서 처리하게 됩니다.

```swift
guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DelegateSecondViewController") as? DelegateSecondViewController else { return }
        
        /* 두 번째 뷰컨 (DelegateSeconViewController 가 대신해서 처리할 부분이 현재 뷰컨(self)!*/
        /* delegate 위임(채택) */
        nextVC.delegate = self
```

<br><br>

# TableView?

- ScrollView 를 상속받아 ScrollView의 메서드나 프로퍼티에 접근이 가능합니다.
- 목록 형태의 뷰 (한 방향으로만 스크롤) 를 구현하는데에 사용합니다.
- 재사용 큐를 활용하여 메모리를 관리합니다.
- 아이폰의 설정앱이나, 앱스토어에 있는 앱 목록에서 TableView가 사용된 것을 볼 수 있습니다.

## TableView의 구조

- tableView는 row가 모여 하나의 section이 되고
- section들이 모여 하나의 tableView를 구성하게 됩니다.
- 여기서 section은 header와 footer를 가질 수도 있습니다.

![image](https://user-images.githubusercontent.com/68391767/118553431-462b7880-b79b-11eb-8f10-1d7249d35ab4.png)

<br>

## TableView의 스타일

### 1. 테이블 뷰 스타일

- Plain
- Group
- Inset Grouped

![image](https://user-images.githubusercontent.com/68391767/118553471-52afd100-b79b-11eb-9659-e686e1589e8c.png)

<br>

### 2. 테이블  뷰 Cell 의 스타일

- Content Only
- With Accessory View
    - Accessory View→ 여러 스타일 적용 가능
        - basic, right detail, subtitle, left detail, + custom
- In edit mode

![image](https://user-images.githubusercontent.com/68391767/118553507-5f342980-b79b-11eb-8e72-63f09e011709.png)

<br>

## Table View 구현하기

- tableView 를 뷰컨에 추가한 후, 레이아웃을 잡아줍니다.
- Cell 을 구현합니다.
    - 방법
        1. 스토리 보드 내의 TableView Cell 활용
        2. Xib 파일 따로 분리해서 Cell UI 구성
        3. Codebase로 Cell 구성
    - Cell 구분선?
        - Separator을 사용해서 leftInset, rightInset 조절한다.
        - UIView를 올려서 height 1로 잡는다
    - 보이는 셀의 높이 (코드로 다시 구현하기는 해야 함) → 우측 Inspector 메뉴에서 `Row Height` 을 해당 높이로 설정 (스토리보드 예쁘게 보이는 용..)
- UITableViewCell을 상속받는 클래스 생성
    - `TableViewCell`을 클릭하고 클래스 지정 + Identifier 지정하기
- UIViewController를 상속받는 클래스도 생성
    - 뷰컨선택후 클래스 지정하기
- `TableViewCell` 하위의 `Content View` 클릭하고 Automatic누른 후 TableViewCell 파일 클릭
    - TableViewCell 내부의 요소들 IBOutlet으로 선언
    - Cell을 구분하기 위한`Identifier`를 `static`을 활용해 타입 프로퍼티로 선언

        ```swift
        // SoptTableViewCell.swift
        static let identifier : String = "SoptTableViewCell"
        ```

    - 값을 넣어주는 `setData 함수` 만들기

        ```swift
        func setData (imageName : String, title : String, subtitle : String)
        {
        	if let image = UIImage(named: imageName) {
        		iconImageView.image = image
        	}
        	titleLabel.text = title
        	subtitleLabel.text = subtitle

        }
        ```

    - awakeFromNib() ?
        - 객체가 초기화(인스턴스화)된 후 호출되는 메서드
        - 뷰컨의 ViewDidLoad()와 비슷한 개념
        - `Init(coder:)`가 먼저 실행된 후, 호출됨
            - Init(coder:) 시점 : frame, layer관련없는 값들만 접근 가능
            - awakeFromNib() 시점 : Frame, Layer, @IBOutlet 관련값 접근 가능
- 뷰컨 파일 (SoptViewController.swift)을 클릭하고
    - `TableView`를 `@IBOutlet`으로 선언
    - 해당 뷰컨의 Extension 만들고, `UITableViewDelegate` & `UITableViewDataSource`채택

        ```swift
        extension SoptViewController : UITableViewDelegate {

        }
        extension SoptViewController : UITableViewDataSource {

        }
        ```

        - `UITableViewDelegate` 프로토콜

           ![image](https://user-images.githubusercontent.com/68391767/118553573-7246f980-b79b-11eb-96bd-2fa1ec2e67d9.png)

            - 화면에 보이는 모습과 행동을 담당 → 테이블 뷰의 동작, 모양 관리
                - Cell을 터치하면 무엇을 하는지

                    ```swift
                    func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
                    ```

                - Cell의 높이

                    ```swift
                    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
                    ```

                    - 사용예시

                        ```swift
                        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                        	return 106   // 한 행당 106의 높이로
                        }
                        ```

                - Cell의 들여쓰기
        - `UITableViewDataSource` 프로토콜

            ![image](https://user-images.githubusercontent.com/68391767/118553594-78d57100-b79b-11eb-87d2-42defaac370a.png)

            - 테이블을 만들 때 필요한 정보(데이터)를 제공
                - **(필수) Cell 몇 개 그릴지**

                    ```swift
                    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
                    ```

                    - 사용예시

                        ```swift
                        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                        	return serviceList.count // serviceList의 원소 수만큼 cell 그림
                        }
                        ```

                - **(필수) Cell에 어떤 내용을 담을지**

                    ```swift
                    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                    ```

                    - 사용 예시

                     ![image](https://user-images.githubusercontent.com/68391767/118553856-d36ecd00-b79b-11eb-92a2-cd0b8e8967be.png)

                        - withidentifier : tableViewCell에서 작성한 identifier (재사용큐에서 cell을 구분)
                        - indexPath : 행을 식별하는 인덱스 경로
                            - indexPath.row : 행 접근 가능
                            - indexPath.section : 섹션 접근 가능
                - Section의 타이틀은 뭘로 할지
- 구조체를 이용해 `새로운 데이터형`(DataModel) 만들기 (ex. ServiceListDataModel.swift)

    ```swift
    // 이미지이름, 제목, 부제목 담을 데이터형 생성
    struct ServiceListDataModel
    {
    	var iconImageName : String  
    	var title : String 
    	var subtitle : String
    }
    ```

- 다시 뷰컨파일로 돌아와서 만든 데이터형을 담는 배열 선언하기

    ```swift
    // SoptViewController.swift

    var serviceList : [ServiceListDataModel] = []
    ```

    - 선언해준 Array에 임의로 데이터 추가하기 → setServiceList()함수 선언..

        ```swift
        func setServiceList(){ 
        	serviceList.append(....)
        }
        ```

    - 이후 ViewDidLoad에서 setServiceList를 호출하면 내용 모두 들어가있는 상황이 됨.
- TableView의 delegate와 dataSource의 위임자를 설정
    - 자기자신(self)로 설정해줌 → 위임자는 SoptViewController.swift가 된다.

    ```swift
    override func viewDidLoad(){
    	super.viewDidLoad()
    	setServiceList()

    	serviceTableView.delegate = self
    	serviceTableView.dataSource = self
    }
    ```

<br>

## TableView의 크기가 유동적으로 변하도록

KeyWord :  `automaticDimension`

1. 각 height 를 automaticDemansion으로 지정

```swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	return UITableView.automaticDimension
}
```

2. 추정치 높이 잡아주기

```swift
tableView.estimateRowHeight = 100
```

3. Layout 잡기

<br>

## delegate / Datasource 분리해서 구현하기

→ 비슷한 테이블이 여러 VC에서 쓰일 때 사용하면 좋은 방식

![image](https://user-images.githubusercontent.com/68391767/118553656-8d196e00-b79b-11eb-8819-6afef971a380.png)

```swift
// FirstTableVC.swift
let sampleSource = SampleTableDatasource()
let sampleDelegate = SampleTableDelegate()
```

<br><br>

# CollectionView

- 그리드 형태로 나열된 뷰를 구현할 때 쓰임
- UIScrollView를 상속받았음
- Delegate Pattern을 활용해 구현
- 테이블 뷰 보다 더 복잡하고 다양한 형태로 커스터마이징 가능

## CollectionView 구현하기

- UIViewController 상속받는 클래스 / UICollectionView 상속받는 클래스 각각 생성
- 스토리보드에 CollectionView 올린 후 layout 설정
- `Estimate Size` → None으로 설정
    - Estimate size? → 초기에 셀들의 위치를 임시 배정함
    - UICollectionViewDelegateFlowLayout 프로토콜을 이용하여 코드로 사이즈를 적어줄거면 None으로 설정해줘야 함
- View Controller 클래스 매칭
- `CollectionViewCell` 클릭 후 클래스 매칭 + Identifier 설정
- Content View 선택 후 Automatic 눌러서 `CollectionViewCell 파일`로 바꾸기
    - identifier 선언

        ```swift
        // MusicCollectionViewCell.swift
        static let identifier : String = "MusicCollectionViewCell"
        ```

    - 내부 요소들 IBOutlet 연결
    - `setData` 함수 작성

        ```swift
        func setData(imageName : String, title: String, subtitle: String) {

        	if let image = UIImage(named: imageName) {
        		albumImageView.image = image
        	}
        	titleLabel.text = title
        	subtitleLabel.text = subtitle

        }
        ```

- `ViewController (MusicViewController.swift)`
    - MusicCollectionView를 @IBOutlet으로 선언
    - delegate / datasource 를 self로 지정

        ```swift
        musicCollectionView.delegate = self
        musicCollectionView.dataSource = self
        ```

    - 프로토콜 채택
        - UICollectionViewDataSource
        - UICollectionViewDelegate
        - UICollectionViewDelegateFlowLayout
- `DataModel 구조체` 생성

    ```swift
    // 사진이름, 노래제목, 가수 담는 데이터형 생성 (MusicDataModel.swift)
    struct MusicDataModel {
    	var coverName : String
    	var musicTitle : String
    	var singer : String
    }
    ```

- `View Controller`
    - 만든 구조체 타입을 구지는 빈 Array 선언

        ```swift
        private var musicList : [MusicDataModel] = []
        ```

    - 빈 Array에 데이터 넣는 setMusicList() 함수 선언

        ```swift
        func setMusicList(){
        	musicList.append(...)
        }
        ```

    - ViewDidLoad에 setMusicData()를 넣어 뷰가 시작될 때 이미 모두 append 되어있도록 한다.
- 채택한 프로토콜을 구현한다.
    - `UICollectionViewDataSource`

        ```swift
        extension MusicViewController : UICollectionViewDataSource {
        	
        	// Cell을 몇 개 만들지
        	func collectionView(_ collectionView: UICollectionView, numberOfItemInSection section: Int) -> Int {
        		return musicList.count
        	}
        	
        	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        		guard let musicCell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as? MusicCollectionViewCell else { return UICollectionViewCell() }

        		musicCell.setData(imageName: musicList[indexPath.row].coverName,
        											title : musicList[indexPath.row].musicTitle,
        											subtitle: musicList[indexPath.row].singer)
        		return musicCell
        	}

        }
        ```

    - `UICollectionViewDelegateFlowLayout`
        - Cell의 간격, 크기를 결정한다.
        - 자주 사용하는 메서드
            - `sizeForItemAt`
                - 각 Cell의 크기 결정
                - 각 Cell 들의 크기를 CGSize 형태로 return gksek.
                - indexPath를 가져오면 row나 section별로 다르게 크기를 지정도 가능
            - `ContentInset`
                - Cell에서 외부에 존재하는 Inset의 크기를 결정

                    ```swift
                    return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                    ```

                    ![image](https://user-images.githubusercontent.com/68391767/118554449-690a5c80-b79c-11eb-8380-ec1de0d91449.png)
		    
		    
            - `minimumLineSpacing`
                - Cell 들의 위, 아래 간격 지정
            - `minimumInteritemSpacing`
                - Cell 들의 좌우 간격 지정

            ![image](https://user-images.githubusercontent.com/68391767/118554425-61e34e80-b79c-11eb-9851-d5b576613cd4.png)

        ```swift
        extension MusicViewController : UICollectionViewDelegateFlowLayout {

        	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        		// 현재 실행되고 있는 기기의 width 가져와서 저장
        		let width = UIScreen.main.bounds.width
        		

        		let cellWidth = width*(177/375)
        		let cellHeight = cellWidth * (205/177)

        		return CGSize(width: cellWidth, height: cellHeight)
        	}

        	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        		return UIEdgeInsets.zero /// inset 사용x->zero
        	}

        	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        		return 5  // 상하 5포인트
        	}

        	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        		return 3  // 좌우 3포인트
        	} 

        }
        ```

       ![image](https://user-images.githubusercontent.com/68391767/118554394-58f27d00-b79c-11eb-9045-c80c211bb308.png)
       
