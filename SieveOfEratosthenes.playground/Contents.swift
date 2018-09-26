//: Playground - noun: a place where people can play

import UIKit

struct Seive{
    let range:Int
    let primes:[Int]
    init(maxVal:Int){
        self.range = maxVal
        assert(maxVal > 2, "You must have a maximum value higher than 2")
        var numbers:[Int] = Array(2...maxVal)
        var pointer = 0
        while pointer < numbers.count{
            let current = numbers[pointer]
            numbers = numbers.filter {$0 == current || $0 % current > 0}
            pointer += 1
        }
        self.primes = numbers
    }
}

let mySeive = Seive(maxVal: 1000)
print(mySeive.primes)
