//클래스, 구조체, 그리고 열거형은 콜렉션, 목록, 또는 시퀀스의 멤버 요소에 접근할 수 있는 단축키인 서브 스크립트 (subscripts) 를 정의할 수 있습니다.

//서브 스크립트 구문 (Subscript Syntax)
//서브 스크립트를 사용하면 인스턴스 이름 뒤에 대괄호에 하나 이상의 값을 작성하여 타입의 인스턴스를 조회할 수 있습니다.

subscript(index: Int) -> Int {
    get {
        // Return an appropriate subscript value here.
    }
    set(newValue) {
        // Perform a suitable setting action here.
    }
}

//다음은 정수의 n-배-테이블을 표시하기 위한 TimesTable 구조체를 정의하는 읽기전용 서브 스크립트 구현의 예입니다:
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"

//서브 스크립트 사용
//"서브 스크립트"의 정확한 의미는 사용되는 컨텍스트에 따라 다릅니다. 일반적으로 서브 스크립트는 콜렉션, 목록, 또는 시퀀스에 멤버 요소에 접근하는 바로가기로 사용됩니다.

//예를 들어 Swift의 Dictionary 타입은 Dictionary 인스턴스에 저장된 값을 설정하고 조회하기 위해 서브 스크립트를 구현합니다.

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

//서브 스크립트 옵션 (Subscript Options)
//클래스 또는 구조체는 필요한 만큼 서브 스크립트 구현과 값의 타입 또는 서브 스크립트 대괄호 내에서 포함된 값을 기반으로 유추하여 적절한 서브 스크립트를 제공할 수 있습니다. 이러한 여러개의 서브 스크립트 정의를 서브 스크립트 오버로딩 (subscript overloading) 이라 합니다.

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

//타입 서브 스크립트 (Type Subscripts)
//인스턴스 서브 스크립트는 특정 타입의 인스턴스를 호출하는 서브 스크립트 입니다. 타입 자체에서 호출되는 서브 스크립트도 정의할 수 있습니다. 이런 종류의 서브 스크립트를 타입 서브 스크립트 (type subscript) 라고 합니다.

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet { //type subscript
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
