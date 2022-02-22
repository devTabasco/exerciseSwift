//인스턴스 메서드 (Instance Methods)
//인스턴스 메서드 (Instance methods) 는 특정 클래스, 구조체, 또는 열거형의 인스턴스에 속하는 함수입니다.

class Counter {
    var count = 0
    
    //각 함수들이 인스턴스 메서드
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

//self property
//이 규칙의 주요 예외사항은 인스턴스 메서드에 파라미터 명이 그 인스턴스에 프로퍼티 명과 동일할 때 발생합니다. 이러한 경우 파라미터 명이 더 우선시 되고 프로퍼티를 참조하려면 더 규정된 방식으로 참조해야 합니다.

//struct Point {
//    var x = 0.0, y = 0.0
//    func isToTheRightOf(x: Double) -> Bool {
//        return self.x > x
//    }
//}
//let somePoint = Point(x: 4.0, y: 5.0)
//if somePoint.isToTheRightOf(x: 1.0) {
//    print("This point is to the right of the line where x == 1.0")
//}
// Prints "This point is to the right of the line where x == 1.0"


//인스턴스 메서드 내에서 값 타입 수정
//구조체와 열거형은 값 타입 입니다. 기본적으로 값 타입의 프로퍼티는 인스턴스 메서드 내에서 수정될 수 없습니다.
// x, y 값을 수정하려면, mutating func 을 활용해야한다.

//struct Point {
//    var x = 0.0, y = 0.0
//    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
//        x += deltaX
//        y += deltaY
//    }
//}
//var somePoint = Point(x: 1.0, y: 1.0)
//somePoint.moveBy(x: 2.0, y: 3.0)
//print("The point is now at (\(somePoint.x), \(somePoint.y))")
//// Prints "The point is now at (3.0, 4.0)"
//
//
////let 으로 선언하는 경우 Point의 값을 변경할 수 없으니 당연히 mutating을 활용할 수 없다.
//let fixedPoint = Point(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)
//// this will report an error


//변경 메서드 내에서 self 할당 (Assigning to self Within a Mutating Method)
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}


//열거형의 변경 메서드는 동일한 열거형에서 다른 케이스로 암시적으로 self 파라미터를 설정할 수 있습니다.
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off

//타입 메서드 (Type Methods)
//인스턴스 메서드는 특정 타입의 인스턴스에서 호출하는 메서드 입니다. 타입 자체에서 호출되는 메서드도 정의할 수 있습니다. 이런 종류의 메서드를 타입 메서드 (type methods) 라고 합니다.

class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()


