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
