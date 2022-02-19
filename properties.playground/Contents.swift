//property 중 computed properties는 enum, class, structure 모두 활용가능하나,
//stored properties는 class, structure에서만 활용 가능

//Stored Properties : 변수&상수 선언해주는 것

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6


//Structure에 stored properties
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6 <- let 이기 때문에 변경할 수 없어서 에러

//지연 저장된 프로퍼티 (Lazy Stored Properties)
//처음 사용될 때까지 초기값은 계산되지 않는 프로퍼티

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter()를 불러오는 과정이 오래걸릴 수 있으니 리소스 낭비를 막기위해 lazy처리를 하면,
//append만 했을 때는 DataImporter를 불러오지 않아 처리가 빠르다.

//Computed Properties
//수식으로 선언하는 것
//다른 프로퍼티와 값을 간접적으로 조회하고 설정하는 getter와 옵셔널 setter를 제공합니다.
//Java에서 static func 의 경우 사용하는 mutator를 말하는 듯.

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0) // -> Point를 넣었을 때 중앙값의 Point를 return 해줌
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"


//짧은 Setter 선언 (Shorthand Setter Declaration)
//따로 이름을 설정하지 않고, newValue를 사용해 표현해줄 수 있다.

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//짧은 Getter 선언 (Shorthand Getter Declaration)
//get의 경우도 별도 변수를 선언해주지 않고, 한 번에 선언이 가능하다.

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//읽기전용 계산된 프로퍼티 (Read-Only Computed Properties)
//set, get이 없는 경우
//let으로 선언한 경우에만 get, set을 이용해 값을 변경해주는게 의미가 있는데,
//var로 선언한 경우에는 어차피 변경이 가능하므로, java로 치면 public과 static의 차이라고 볼 수 있는듯.

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"

//프로퍼티 관찰자 (Property Observers)
//정의한 저장된 프로퍼티, 상속한 저장된 프로퍼티, 상속한 계산된 프로퍼티 의 경우 observers를 추가할 수 있음.
//프로퍼티에 관찰자를 정의하는 방법은 2가지 willSet : 저장되기 직전에 호출, didSet : 저장되자마자 호출

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) { //newTotalSteps를 newValue로 바꿔 쓸수 있음.
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps


//프로퍼티 래퍼 (Property Wrappers)
//프로퍼티 래퍼 (property wrapper)는 프로퍼티가 저장되는 방법을 관리하는 코드와 프로퍼티를 정의하는 코드 사이에 분리 계층을 추가합니다. 예를 들어 쓰레드 안정성 검사를 제공하거나 기본 데이터를 데이터베이스에 저장하는 프로퍼티가 있는 경우 모든 프로퍼티에 해당 코드를 작성해야 합니다.

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}


struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"



//컴파일러가 인식하는 코드
//struct SmallRectangle {
//    private var _height = TwelveOrLess()
//    private var _width = TwelveOrLess()
//    var height: Int {
//        get { return _height.wrappedValue }
//        set { _height.wrappedValue = newValue }
//    }
//    var width: Int {
//        get { return _width.wrappedValue }
//        set { _width.wrappedValue = newValue }
//    }
//}

//래핑된 프로퍼티를 위한 초기값 설정 (Setting Initial Values for Wrapped Properties)
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    //SmallNumber 의 정의는 init(), init(wrappedValue:), init(wrappedValue:maximum:) 의 3개의 초기화를 포함합니다.
    
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

//프로퍼티에 래퍼를 적용하지 않고 초기값을 지정하지 않으면 Swift는 래퍼를 설정하기 위해 init() 을 사용합니다.

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"


struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

//프로퍼티에 초기값을 지정할 때 Swift는 래퍼를 설정하기 위해 init(wrappedValue:) 를 사용합니다.

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"

//사용자 속성 후에 소괄호 안에 인자를 작성하면 Swift는 래퍼를 설정하기 위한 인자를 받을 수 있는 초기화를 사용합니다. 예를 들어 초기값과 최대값을 제공하면 Swift는 init(wrappedValue:maximum:) 초기화를 사용합니다.

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3" -> 초기값

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"


//프로퍼티 래퍼 인자를 포함하면 할당을 사용하여 초기값을 지정할 수도 있습니다. Swift는 할당을 wrappedValue 인자처럼 취급하고 이 인자를 받을 수 있는 초기화를 사용합니다.
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"

//프로퍼티 래퍼에서 값 투영 (Projecting a Value From a Property Wrapper)
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false" -> projectedValue를 출력

someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"

//더 많은 정보의 노출이 필요한 래퍼는 다른 데이터 타입의 인스턴스를 반환하거나 투영된 값으로 래퍼의 인스턴스를 노출하기 위해 self 를 반환할 수 있습니다.

enum Size {
    case small, large
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int

    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small: //self.small
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}

//타입 프로퍼티 (Type Properties)
//해당 타입의 인스턴스가 아닌 타입 자체에 속하는 프로퍼티를 정의할 수도 있습니다. 생성하는 해당 타입의 인스턴스 수에 관계없이 이러한 프로퍼티의 복사본은 하나만 있습니다. 이런 프로퍼티의 종류를 타입 프로퍼티 (type properties) 라고 합니다.

//타입 프로퍼티 구문 (Type Property Syntax)
//static type

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    //class는 override가능
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//타입 프로퍼티 조회와 설정 (Querying and Setting Type Properties)
//타입 프로퍼티는 인스턴스 프로퍼티처럼 점 구문으로 조회되고 설정합니다. 그러나 타입 프로퍼티는 해당 타입의 인스턴스가 아닌 타입 에 대해 조회되고 설정합니다.

print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
