//: Playground - noun: a place where people can play

import Foundation

//struct Square {
//
//    let arrayValue: [Int]
//    let rows: Int
//
//    init(array: [Int]) {
//        guard (Float(array.count).squareRoot().truncatingRemainder(dividingBy: 1)) == 0 else {
//            preconditionFailure("Not a square")
//        }
//        self.arrayValue = array
//        self.rows = Int(Float(array.count).squareRoot())
//        Square.checkNumbers(self)
//    }
//
//    static func checkNumbers(_ square: Square) {
//        var numbersSet = Set<Int>()
//        for index in 1 ... square.arrayValue.count {
//            if !square.arrayValue.contains(index) {
//                print("Not good numbers, set doesn't contain \(index)")
//            }
//            let number = square.arrayValue[index]
//            if numbersSet.contains(number) {
//                print("Not good numbers, \(number) is in there twice")
//            } else {
//                numbersSet.insert(number)
//            }
//        }
//    }
//
//}
//
//let newSquare = Square(array: [5,3,4,1,5,8,6,4,2])
//print(newSquare.rows)


func formingMagicSquare(s: [[Int]]) -> Int {
    var edgeTotals = [Int:Int]()
    for index in 0 ..< (s.count * 2) + 1 {
        var total: Int = 0
        if index <= 2 {
            total = s[index][0]
            total += s[index][1]
            total += s[index][2]
        } else if index <= 5 {
            total = s[0][index - 3] + s[1][index - 3] + s[2][index - 3]
        } else {
            let corner = (index - 6) * 2
            total = s[0][corner] + s[1][1] + s[2][2 - corner]
        }
        if let currentTotal = edgeTotals[total] {
            edgeTotals[total] = currentTotal + 1
        } else {
            edgeTotals[total] = 1
        }
        print(edgeTotals)
    }
//    var maybeMagic: Int = -1
//    var count: Int = -1
//    for tuple in edgeTotals {
//        if tuple.value > count {
//            count = tuple.value
//            maybeMagic = tuple.key
//        }
//    }
    let magicConstant: Float = 15 // Constant for a 3x3 magic square
    let cost: Float = edgeTotals.reduce(0.0) { cost, item in
        cost + (abs(Float(item.key) - magicConstant) / Float(item.value))
        // The problem is overlapping rows
        // If the count for a given line total is 2, you only need to count the cost of fixing it once
        // All factors of 2 that aren't factors of 3 can be solved by diving the cost in two
        // Factors of 3 should have the cost cut in 3, but if the count is 6 this logic breaks down
    }
    return Int(cost)
}

print(formingMagicSquare(s: [[4,9,2],[3,5,7],[8,1,5]]))

