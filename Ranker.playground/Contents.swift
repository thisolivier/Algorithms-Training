//: Climbing the Leaderboard - challenge: https://www.hackerrank.com/challenges/climbing-the-leaderboard/

import Foundation

func cheatTree(arrayWithDuplates: [Int]) -> [(Int, Int)] {
    var output = [(Int, Int)]()
    var last:(Int, Int) = (-1, 0)
    for item in arrayWithDuplates {
        if item != last.0 {
            last = (item, last.1 + 1)
            output.append(last)
        }
    }
    return output
}

func judge(context: [Int], alice: [Int]) -> [Int] {
    let sneakyTree = cheatTree(arrayWithDuplates: context)
    var output = [Int]()
    for score in alice {
        var index: Float = Float(sneakyTree.count - 1) / 2
        if index.truncatingRemainder(dividingBy: 1) != 0 {
            index += 0.5
        }
        var flag = true
        var count: Int = 0
        while flag {
            if (count > sneakyTree.count*2) {
                print("Nooope!")
                break
            }
            let above = sneakyTree[Int(index - 1)]
            let current = sneakyTree[Int(index)]
            if score < above.0 && score >= current.0 {
                output.append(Int(index + 1))
                flag = false
            } else if score < above.0 {
                if index == Float(sneakyTree.count - 1) {
                    output.append(Int(index) + 2)
                    flag = false
                } else {
                    index = (Float(sneakyTree.count - 1 - Int(index))/2) + index
                }
            } else if index == 1 {
                output.append(1)
                flag = false
            } else {
                print("""
                    ----
                    Looping no \(count) position \(index) count \(sneakyTree.count)
                    Above val \(above.0), rank \(above.1)
                    Alice \(score)
                    Current val \(current.0), rank \(current.1)
                """)
                let newIndex = index/2
                index = (index == newIndex) ? index - 1 : newIndex
            }
            if index.truncatingRemainder(dividingBy: 1) != 0 {
                index += 0.5
            }
            count += 1
        }
    }
//    for intTuple in sneakyTree {
//        var flag = ""
//        if let index = output.index(of: intTuple.1) {
//            flag = " - [\(alice[index]) on \(index)th try]"
//        }
//        print("\(intTuple.1) - \(intTuple.0)\(flag)")
//    }
    return output
}

let context = [100, 100, 99, 99, 70, 69, 68, 67, 66, 65, 65, 63, 62, 61, 60, 59, 50, 2, 1, 1, 1]
let alice = [0, 1, 3, 20, 70, 100]

print(judge(context: context, alice: alice))
