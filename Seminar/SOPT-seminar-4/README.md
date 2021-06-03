# Network

클라이언트가 서버에게 데이터를 **요청(request)** 하면, 서버는 클라에게 데이터를 **응답(response)** 한다.

→ 이때 정해진 형태로 요청하고, 정해진 형태로 응답을 받는다. → 이 정해진 형태를 **HTTP 프로토콜** 이라고 한다.

- `클라이언트`
    - 서버에 **데이터처리를 요청**하는 객체
    - 필요한 정보를 서버에 요청하고, **받아와서 보여주는 역할**을 한다.
- `서버`
    - 클라이언트에게 네트워크를 통해 정보나 서비스를 제공하는 컴퓨터나 프로그램
    - 클라이언트가 요청을 하면 데이터를 처리하여 결과를 보내준다.

## HTTP 프로토콜

- **GET** - 데이터를 얻고 싶을 때 요청
- HEAD - 헤더 정보를 얻고 싶을 때 요청
- **POST** - 내용을 전송할 때
- PUT - 내용을 갱신할 때
- DELETE - 내용을 삭제할 때
- OPTIONS - 가능한 메소드 옵션을 파악할 때
- TRACE - 리소스가 수신되는 경로를 파악할 때
- PATCH - 리소스를 일부 수정할 때

## REST

Respresentational State Transfer

자원을 이름으로 구분해, 자원의 정보를 주고받는 것

→ ex) 클라이언트는 서버에게 URI를 통해 GET요청을 하고, JSON형태로 데이터를 받는다.

- 행위
    - HTTP 메서드 사용
- 자원
    - **URI**를 통해 오브젝트에 접근함
- 메시지
    - **JSON 포맷**으로 메시지를 받음
        - 데이터를 표현하는 방법 중 하나!
        - **key - value**형태, ""를 이용해 표기함
        - 중첩 가능
        - 객체, 배열 등 사용 가능

        ```swift
        {
        	"success": true,
        	"message": "회원가입 성공",
        	"data": {
        		"nickname": "name1"
        	}
        }
        ```
<br><br>

# Codable

그렇다면 받은 JSON 데이터를 어떻게 처리할까? (JSON → 구조체를 이용한 DataModel) 또는 swift 데이터 모델의 내용을 JSON형태의 데이터로 어떻게 전환할까?

→ Encode / Decode 를 이용하여 둘 사이의 전환이 가능하다.

- Encode: swift의 DataModel → 데이터(ex. JSON)으로 변환
- Decode : 받은 데이터(ex. JSON) → swift의 DataModel

## Encode (암호화)

swift의 데이터 모델을 데이터(ex. JSON)로 변환하는 과정

- `Encodable 프로토콜`을 채택한다.

    ```swift
    struct 데이터모델 : Encodable
    ```

- Encode 예시
    - 상황 : name(String), age(Int)으로 구성된 swift DataModel의 내용을 JSON형태의 데이터로 변환하고 싶다
    - 방법
        - 먼저 `DataModel`을 만들어준다.

            ```swift
            struct PersonDataModel : Encodable {
                // Encodable 을 채택하여 swift데이터모델의 내용을 JSON 형태의 데이터로 변환한다.
                var name : String
                var age : Int
            }
            ```

        - DataModel에 들어갈 내용을 지정한다.

            ```swift
            // 뷰컨내부
            let personData = PersonDataModel(name: "김씨워터", age: 20)
            ```

        - Swift에서 지원하는 JSONEncoder를 이용할 것이므로 인스턴스를 하나 생성해준다!

            ```swift
            // 뷰컨의 viewDidLoad 내부

            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            ```

        - 오류처리를 해준다. (try - catch이용)
            - `jsonEncoder.encode`에서 `encode 함수`에는 throws가 붙어있으므로 try-catch문으로 오류처리를 해주어야 한다.
            - encode가 실패하면 catch문 내부로 가서 `print(error)`를 실행하게 된다.

            ```swift
            // 뷰컨의 viewDidLoad 내부

            do {
            	let data = try jsonEncoder.encode(personData)
            	print(String(data: data, encoding: .utf8)!)      
            }
            catch {
            	print(error)
            }
            ```

    - 실행결과

        datamodel내용이 JSON형태의 데이터로 바뀌었음을 확인할 수 있다!
        
        ![image](https://user-images.githubusercontent.com/68391767/120708238-4abf9300-c4f6-11eb-8578-c4e7f6d2512e.png)

<br>

## Decode (해독)

받은 데이터(ex. JSON파일)를 swift의 데이터 모델로 변환하는 과정

- `Decodable 프로토콜`을 채택한다.

    ```swift
    struct 데이터모델 : Decodable
    ```

- Decode 예시
    - 상황 : drink(String), price(Int), orderer(String)으로 구성된 JSON형태의 데이터를 swift Datamodel로 변환하고 싶다
    - 방법
        - dataModel을 만들고 Decodable 프로토콜을 채택한다.

            ```swift
            struct CoffeeDataModel : Decodable {
                var drink : String
                var price : Int
                var orderer : String
            }
            ```

        - JSON형식의 데이터를 swift DataModel로 변환해줄거니까, JSON형식의 dummyData를 만들어준다. (원래는 서버에서 넘겨주는 데이터겠져)

            ```swift
            let dummyData = """
                    {
                        "drink" : "아메리카노",
                        "price" : 2000,
                        "orderer" : "iOS사랑해"
                    }
            """.data(using: .utf8)!
            ```

        - Swift에서 지원하는 JSONDecoder를 이용해줄 것이므로, `JSONDecoder`인스턴스를 하나 생성해준다.

            ```swift
            // 뷰컨의 viewDidLoad안에 작성
            let jsonDecoder = JSONDecoder() // 디코더 인스턴스 생성
            ```

        - `decode함수`를 사용해줄 것이므로, 오류처리(try-catch)를 해준다.
            - decode함수에는 `throw`가 붙어있기 때문에 try-catch를 이용해주어야만 한다.
            - 만약 decode함수가 실패하면, catch문 내부로 이동하여 `print(error)`가 실행된다.
            - `dump(order)` : order의 자세한 정보를 출력한다.

            ```swift
            do{
            	let order = try jsonDecoder.decode(CoffeeDataModel.self, from: dummyData)
            	print("디코더 성공")
            	dump(order)   
            }
            catch{
            	print(error)
            }
            ```

    - 결과
      
      ![image](https://user-images.githubusercontent.com/68391767/120708290-59a64580-c4f6-11eb-9526-b357519c5b61.png)
      
      
      
     
<br>

### Key의 이름이 변경되었을 때 처리하는 방법 - CodingKeys 사용

**CodingKeys**를 사용하면 서버에서 갑자기 JSON 데이터의 Key값을 바꿨을때, 우리가 굳이 모든 프로퍼티 하나하나 이름을 바꿔줄 필요가 없다!

- 사용방법
    - DataModel 구조체 안에 `CodingKeys`를 선언해준다. (이름은 꼭 CodingKeys로!)

        ```swift
        enum CodingKeys : String, CodingKey {
        	case drink
        	case price = "price_coffee"
        	case orderer
        }
        ```

        이렇게 하면 만약에 서버에서 넘겨준 데이터의 키값이 price → price_coffee로 바뀌었을 때  대응할 수 있게 된다.

- 상황 : 원래 키값이 orderer이었다가 orderer_coffee로 바뀐 경우

    ```swift
    // 원래 데이터
    {
    	"drink" : "아메리카노",
    	"price" : 2000,
    	"orderer" : "iOS사랑해"
    }
    ```

    ```swift
    // 바뀐 데이터
    {
    	"drink" : "아메리카노",
    	"price" : 2000,
    	"orderer_coffee" : "iOS사랑해"
    }
    ```

    - 이때 구조체 내부의 CodingKeys를 이렇게 작성해준다.

        ```swift
        enum CodingKeys : String, CodingKey {
        	case drink
        	case price 
        	case orderer = "orderer_coffee"
        }
        ```

    - 그러면 정상적으로 decoding이 진행된다.


<br>

### Key-Value한 쌍이 없을 때 처리하는 방법 - 직접 Decode , 기본값 할당

만약 key-value한 쌍이 아예 넘어오지 않으면 init을 이용해 초기값을 할당한다.

```swift
struct CoffeeDataModel : Decodable {
    var drink : String
    var price : Int
    var orderer : String
    
    enum CodingKeys : String, CodingKey {
        case drink
        case price
        case orderer = "orderer_coffee"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        drink = (try? values.decode(String.self, forKey: .drink)) ?? ""
        price = (try? values.decode(Int.self, forKey: .price)) ?? 0
        orderer = (try? values.decode(String.self, forKey: .orderer)) ?? ""
    }
}
```

- 여기서 만약 try? 했을때 decode실패하면 ?? 뒤의 값이 기본값으로 할당된다.

    ```swift
    // 아래 데이터가 들어왔을 때
    {
    	"drink" : "아메리카노",
    	"price" : 2000   
    }
    ```
    
    ![image](https://user-images.githubusercontent.com/68391767/120708339-67f46180-c4f6-11eb-9805-87aebf134caa.png)
    
<br>

## Codable

Encode와 Decode 묶어서 Codable로 사용가능

```swift
struct CoffeeDataModel : Codable {
    var drink : String
    var price : Int
    var orderer : String
   
	// ...
}
```

<br><br>

# Cocoapod

- 외부 라이브러리를 관리하기 쉽도록 도와주는 의존성 관리 도구
- iOS와 관련된 각종 오픈소스 라이브러리를 손쉽게 프로젝트에 추가할 수 있음

<br>

# Alamofire

## Info.plist 파일 수정하기

Alamofire를 사용하려면 꼭 Infoplist에서 추가해주어야 하는 것이 있다.

![image](https://user-images.githubusercontent.com/68391767/120708580-b6a1fb80-c4f6-11eb-8e75-81af2f4cf425.png)

- App Transport Security Settings를 추가해주고
- 그 하위에 Allow Arbitrary Load를 추가한 후 No → YES로 바꿔준다.

<br>

## 탈출클로저 Escaping

- 탈출 클로저 만드는 방법
    - 매개변수로 넘어온 클로저 앞에 `@escaping`을 달아준다.

    ```swift
    class ViewController : UIViewController {
    	var sampleClosure : () -> Void = {}

    	override func viewDidLoad() {
    		super.viewDidLoad()
    		
    		// 아래의 func callback의 파라미터로 closure을 줌	
    		callback {
    			print("Closure가 실행되었습니다.")
    		}
    	}
    	
    	func callback(closure: @escaping () -> Void) {
    		sampleClosure = closure
    		sampleClosure()
    	}
    }
    ```

- 탈출클로저를 만들면
    - 해당 클로저를 외부의 변수나 상수에 저장할 수 있다.

        (탈출클로저가 아닌 경우에 파라미터로 받은 클로저는 직접 실행만 가능할 뿐, 외부변수나 상수에 대입 불가능)

    - 해당 함수가 끝나고 리턴 이후에 해당 클로저를 실행할 수 있다.
    - 탈출클로저로 만들면 **함수의 실행 순서**를 정할 수 있다.
- 탈출클로저를 사용하여 서버에서 데이터를 받아오는 작업이 끝났을 때 탈출 클로저를 호출하면 함수가 리턴되더라도 서버 작업완료될 때 전달받을 수 있다.

    → 데이터를 안전하게 받을 수 있다!

    - 만약 탈출클로저를 사용하지 않으면 데이터를 받기 전에 함수가 종료되어버릴 수도 있음

<br>

## 싱글턴 패턴 Singleton

특정 용도로 객체를 하나만 생성해 공용으로 사용하고 싶을 때 사용하는 디자인 유형이다.

- 상황 : UserInfo 저장하는 클래스가 하나 있고 ViewController 3개에서 각각 정보를 받으면?
    - 원래같으면 각각 뷰컨에서 인스턴스가 하나씩 생성된다.

    ```swift
    // UserInfo를 저장하는 클래스
    class UserInfo {
    	var id : String?
    	var password : String?
    	var name : String?
    }
    ```

    - 인스턴스1 : id가 "seawater"이고 pw, name은 nil

        ```swift
        // ViewController A
        let userInfo = UserInfo()
        userInfo.id = "seawater"
        ```

    - 인스턴스 2: pw가 1234이고 id, name은 nil

        ```swift
        // ViewController B
        let userInfo = UserInfo()
        userInfo.pw = "1234"
        ```

    - 인스턴스3 : name이 "hs"이고 id, pw는 nil

        ```swift
        // ViewController C
        let userInfo = UserInfo()
        userInfo.name = "hs"
        ```

    - 하지만 원하는건 한 인스턴스 안에 id : "seawater", pw: "1234" , name : "hs"가 모두 저장되길 원함
- 해결방안: 해당 인스턴스가 최초로 생성될 때 **전역으로 생성**하고, 그 이후에는 여기만 접근하게 한다.
    - static으로 인스턴스를 미리 선언한다.

        ```swift
        class UserInfo {
        	static let shared = UserInfo()

        	var id: String?
        	var password: String?
        	var name: Sring
        }
        ```

    - 각각의 뷰컨들에서 아래와 같은 방식으로 값을 할당한다.

        ```swift
        let userInfo = UserInfo.shared
        userInfo.id = "seawater"
        ```
<br>

## Postman 사용하기

Postman에서 서버가 구현한 API를 테스트할 수 있다.

## GET 방식 통신 예시

### 1️⃣ NetworkResult.swift

네트워크 결과를 나누기 위해 enum형으로 선언한다.

```swift
import Foundation

// 서버통신 결과 저장

enum NetworkResult<T> {
    case success(T)     // 서버 통신 성공했을 때
    case requestErr(T)  // 요청 에러 발생했을 때
    case pathErr        // 경로 에러 발생했을 때
    case serverErr      // 서버의 내부적 에러가 발생했을 때
    case networkFail    // 네트워크 연결 실패했을 때
}
```

### 2️⃣ XXXDataModel.swift

JSON 데이터를 담아내기 위해서 데이터 구조체를 만들고, Codable을 채택해준다.

→ 서버에서 넘어온 JSON 데이터를 swift의 DataModel로 만든다고 하면, 이때 swift의 DataModel을 만들어 주는 것

```swift
import Foundation

// MARK: - Welcome
struct PersonDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Person
}

// MARK: - DataClass
struct Person: Codable {
    let name, profileMessage: String

    enum CodingKeys: String, CodingKey {
        case name
        case profileMessage = "profile_message"
    }
}
```

- 쉽게 만드는 사이트

    [Instantly parse JSON in any language | quicktype](https://app.quicktype.io)

### 3️⃣ 0000Service.swift

실질적으로 네트워크를 처리하는 부분이다. escaping clousre를 활용하여 통신 결과값을 뷰컨에 전달한다.

```swift
import Foundation
import Alamofire

// 통신하는 부분!!!!!

struct GetPersonDataService{
    // 1. 싱글턴 패턴 인스턴스 생성
    static let shared = GetPersonDataService()
    
    func getPersonInfo(completion : @escaping (NetworkResult<Any>) -> Void) {
        // 2.  @escaping 클로저를 사용해 escape closure형태로 completion을 정의한다.
        // 해당 네트워크 작업이 끝날 때 네트워크 결과를 호출한다.
        
        // 3. 데이터를 받아오려는 주소를 정의함
        let URL = "https://mocki.io/v1/e5b82f33-832c-43ae-83c8-c3e053a4ead7"
        
        // 4. 필요한 헤더를 key-value형태로 정의함 (나중에 서버 붙일때 필요한 헤더 있는지 확인할 것)
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        
        // 5. 요청서 작성
        // (주소)로 (Get)방식을 이용해 (JSONEncoding)방식으로 (header)정보를 헤더에 담아 Request를 보내기 위한 정보를 묶어 dataRequest에 저장함
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // 6. 통신이 완료되면 클로저를 통해 dataRequest라는 이름으로 결과가 도착한다.
        /*
         dataResponse.result => 통신이 성공했는지 실패했는지 여부
         dataResponse.response?.statusCode => Response의 statusCode
         dataResponse.value => Response의 결과 데이터
         */
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {
            // 통신이 성공했는지, 실패했는지 판단
            case .success:
                // statuscode값 저장해놓기 (ex. 200, 400 이런거)
                guard let statusCode = dataResponse.response?.statusCode else {
                    return
                }
                
                // response 결과 데이터 저장해놓기
                guard let value = dataResponse.value else { return }
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            // 통신이 실패한 경우(아예 통신 자체의 실패)
            case .failure:
                completion(.pathErr)
            }
            
            
        }
        
    }
    
    // statusCode를 바탕으로 어떻게 결과값을 처리할지 정의함.
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        // 200 : 성공한 경우 (isValidData로 데이터 넘겨줌)
        case 200:
            return isValidData(data: data)
        // 400 : 요청이 잘못되었다는 경우 .pathErr 리턴
        case 400:
            return .pathErr
        // 500 : 서버 에러
        case 500:
            return .serverErr
        // 기타 : 네트워크 에러
        default:
            return .networkFail
        }
    }
    
    // statusCode가 200대 일 때 데이터를 가공하기 위한 함수
    private func isValidData(data: Data)-> NetworkResult<Any> {
        
        // JSON데이터 해독
        let decoder = JSONDecoder()
        
        // Decode하는 중... -> 실해파면 pathErr
        guard let decodeData = try? decoder.decode(PersonDataModel.self, from: data)
        else { return .pathErr }
        
        // 성공하면 success
        return .success(decodeData.data)
    }
}
```

### 4️⃣ 000ViewController.swift

싱글턴 패턴을 통해 공용 인스턴스에 접근해서 통신하는 메서드를 호출한다.

- escaping closure값을 받아와서 분기처리를 한 후 데이터를 가공한다.

```swift
import UIKit

class SampleNetworkViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func getButtonClicked(_ sender: Any) {
        
        // GetPersonDataService 구조체에서 공용 인스턴스에 접근한다.
        GetPersonDataService.shared.getPersonInfo { (response) in
            switch(response){
            
            case .success(let personData):
                if let data = personData as? Person {
                    
                    self.nameLabel.text = data.name
                    self.messageLabel.text = data.profileMessage
                }
            
            case .requestErr(let message) :
                print("requestERR", message)
            case .pathErr :
                print("pathERR")
            case .serverErr:
                print("serverERR")
            case .networkFail:
                print("networkFail")
                
            }
            
        }
    }
    
}
```
