//초기화(initialization)

//저장된 프로퍼티에 초기값 설정 (Setting Initial Values for Stored Properties)

//초기화 구문
//init() {
//    // perform some initialization here
//}

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0 //32도로 초기화
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"

//초기화 파라미터 (Initialization Parameters)

//캘빈과 화씨를 넣었을 때 2개의 초기화를 통해 섭씨를 구해놓는 구조
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0

//파라미터 명과 인자 라벨 (Parameter Names and Argument Labels)
//받아온 인자로 값 초기화
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//옵셔널 프로퍼티 타입 (Optional Property Types)
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

//구조체 타입에 대한 멤버별 초기화 구문 (Memberwise Initializers for Structure Types)
//struct Size {
//    var width = 0.0, height = 0.0
//}
//let twoByTwo = Size(width: 2.0, height: 2.0)

//값 타입을 위한 초기화 구문 위임 (Initializer Delegation for Value Types)
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//초기화 해제 동작 (How Deinitialization Works)
//deinit {
//    // perform the deinitialization
//}

//초기화 해제 구문 동작 (Deinitializers in Action)
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

