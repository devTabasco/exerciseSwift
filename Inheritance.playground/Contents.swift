//기본 클래스 정의 (Defining a Base Class)
//다른 클래스에서 상속하지 않은 클래스를 기본 클래스 (base class) 라고 합니다.

class Vehicle { //base Class
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let someVehicle = Vehicle() //인스턴스 생성

print("Vehicle: \(someVehicle.description)")
// Vehicle: traveling at 0.0 miles per hour


//하위 클래스 (Subclassing)
//하위 클래스 (Subclassing) 는 기존 클래스를 기반으로 새로운 클래스를 만드는 작업입니다.

class Bicycle: Vehicle { //상속받아서 만든 클래스
    var hasBasket = false
}

let bicycle = Bicycle() //인스턴스 생성
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour

class Tandem: Bicycle { //또다시 하위 클래스 생성
    var currentNumberOfPassengers = 0
}

let tandem = Tandem() // 인스턴스 생성 & 상위클래스의 모든 프로퍼티를 사용 가능
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour

//재정의 (Overriding)
//하위 클래스는 상위 클래스에서 상속할 인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로퍼티, 또는 서브 스크립트 자체 사용자 구현을 제공할 수 있습니다. 이것을 재정의 (overriding) 이라 합니다.


//재정의 방지 (Preventing Overrides)
//final 표시를 통해 실수로 메서드, 프로퍼티, 또는 서브 스크립트를 재정의 하는 것을 방지할 수 있습니다.
