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


