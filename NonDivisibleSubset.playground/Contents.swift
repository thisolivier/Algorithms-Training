//: Playground - noun: a place where people can play

import Foundation

func findLargestNonDivisibleSetSize(set: [Int], divisor: Int) -> Int {
    func recurse(holder:[Int], world:[Int]) -> Int {
        var newWorld = world
        var maxValue = holder.count
        for _ in 0..<world.count {
            if let item = newWorld.popLast() {
                
                let canAdd = holder.reduce(true) { (result: Bool, next: Int) in
                    return result ? (next + item).quotientAndRemainder(dividingBy: divisor).remainder != 0 : result
                }
                
                if canAdd {
                    var newHolder = holder
                    newHolder.append(item)
                    
                    let recurseValue = recurse(holder: newHolder, world: newWorld)
                    if maxValue < recurseValue {
                        maxValue = recurseValue
                    }
                }
            }
        }
        return maxValue
    }
    
    return recurse(holder: [], world: set)
}


print(findLargestNonDivisibleSetSize(set: [1, 7, 2, 4], divisor: 3))
