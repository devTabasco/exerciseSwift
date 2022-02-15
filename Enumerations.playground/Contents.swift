//문자열, 문자, 정수, 부동소수 타입 가능
//case 초기값 제공을 위해 초기화 가능

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum CompassPoint2 {
    //1줄로도 표현 가능
    case north, south, east, west
}

//이 경우 derectionToHead는 자동으로 CompassPoint type으로 지정된다.
var derectionToHead = CompassPoint.west

//따라서 그 이후로는 아래와 같이 type을 제오하고 사용할 수 있다.
derectionToHead = .north

//switch 문에서 열겨형을 이용해 value를 matching할 수도 있다.
//enum의 모든 case를 입력하지 않으려면, default 값을 만들어주서야, 컴파일이 된다.

switch derectionToHead{
case .north:
    print("정답!")
case .west:
    print("땡!")
case .east:
    print("땡!")
case .south:
    print("땡!")
}

//CaseIterable을 통해 allCases를 사용할 수 있음.
//CaseIterable은 Case를 하나씩 반복하면서 돌아다니는 것

enum Beverage: CaseIterable{
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverrages available")

for beverage in Beverage.allCases{
    print(beverage)
}


//Barcode에 upc와 qrCode 정도를 enum을 이용해 한 번에 담아 관리 할 수 있다.

enum Barcode{
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

//enum의 암시적으로 할당된 원시값(Implicitly Assigned Raw Values)

//Int형의 경우 원시값은 초기화 되어있지 않다면 0부터 증가
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//String의 경우 그 자체가 원시값(raw value)
enum CompassPoint3: String {
    case north, south, east, west
}

print(CompassPoint3.west.rawValue)  //west

//rawValue를 이용해 초기값을 선언해줄 수 있음. 아래의 경우 uranus로 초기화
let possiblePlanet = Planet(rawValue: 7)


//rawValue가 11로 선언되지만, 11의 rawValue는 없기 때문에 nil이 출력됨. 따라서 else문이 출력 됨.
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//재귀 열거
//enum ArithmeticExpression {
//    case number(Int)
//    indirect case addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//}
//
//indirect enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//    case multiplication(ArithmeticExpression, ArithmeticExpression)
//}
//
//let five = ArithmeticExpression.number(5)
//let four = ArithmeticExpression.number(4)
//let sum = ArithmeticExpression.addition(five, four)
//let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//
//func evaluate(_ expression: ArithmeticExpression) -> Int {
//    switch expression {
//    case let .number(value):
//        return value
//    case let .addition(left, right):
//        return evaluate(left) + evaluate(right)
//    case let .multiplication(left, right):
//        return evaluate(left) * evaluate(right)
//    }
//}
//
//print(evaluate(product))
//// Prints "18"
