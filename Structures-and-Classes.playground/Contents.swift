//구조체 vs 클래스

//클래스에는 structure가 가지지 못한기능이 있다.
//1. 상속
//2. typeCasting을 하면, 런타임에 클래스 인스턴스의 타입을 확인하고 해석가능
//3. 초기화 해제 구문(Deinitalizers)을 사용하면 클래스의 인스턴스가 할당된 리소스를 해제할 수 있도록 함.
//4. 참조 카운팅은 하나 이상의 클래스 인스턴스 참조를 허락함.

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution() //이런식으로 struct는 UpperCamelCase, 프로퍼티는 lowerCamelCase로 구분
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//structure나 class는 인스턴스를 생성해 활용해야 한다.
let someResolution = Resolution()
let someVideoMode = VideoMode()

//인스턴스 내 프로퍼티는 . 을 이용해 접근 가능
print("The width of someResolution is \(someResolution.width)")

// 초기화 하면서 인스턴스 생성 구문
let vga = Resolution(width: 640, height: 480)

//structure와 enum은 인스턴스 복사가 가능한 value type 이다. -> 레퍼런스도 참조하지 않는 hard copy가 일어난다.
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd //인스턴스 복사

cinema.width = 2048

//Class의 경우 참조타입(reference type)이다.

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty //softcopy -> reference를 공유함.
alsoTenEighty.frameRate = 30.0

print(tenEighty.frameRate) //30.0 출력

//따라서 new instence로 만들어주는 것이 적절할 것.
//let alsoTenEighty = VideoMode()

//식별연산자 Identity Operrators
//Class에서 동일한 reference를 바라보고 있는지 확인하기 위해 === 또는 !== 를 이용한다. true/false 반환
//java에서 instanceof와 같음
