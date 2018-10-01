//: Geteger - noun: an integer so large it cannot be stored in an Int of any kind

import Foundation

struct Geteger {
    
    var arrayValue: [Int] = [0]
    
    var stringValue: String {
        get {
            return arrayValue.reduce("") { (result: String, value: Int) in
                return String(value) + result
            }
        }
    }
    
    init(number: Int = 0) {
        self.add(number)
    }
    
    // TODO: Rewrite using <T>().enumerated().map { (index: Int, element: <T>) in ... }
    mutating func add(_ number: Int) {
        let arrayInput = String(number).flatMap{Int(String($0))!}
        let endIndex = arrayInput.count - 1
        var carried = 0
        var index = 0
        while (index <= endIndex) || (carried != 0) {
            let toAdd = index > endIndex ? carried : arrayInput[endIndex - index] + carried
            if self.arrayValue.count - 1 >= index {
                self.arrayValue[index] += toAdd
            } else {
                self.arrayValue.append(toAdd)
            }
            if self.arrayValue[index] > 9 {
                self.arrayValue[index] = Int(Float(arrayValue[index]).truncatingRemainder(dividingBy: 10))
                carried = 1
            } else {
                carried = 0
            }
            index += 1
        }
    }
    
    mutating func minusOne() {
        for var index in 0..<self.arrayValue.count {
            if self.arrayValue[index] == 0 {
                self.arrayValue[index] = 9
            } else {
                self.arrayValue[index] -= 1
                return
            }
        }
    }
    
    // TODO: Rewrite using <T>().enumerated().map { (index: Int, element: <T>) in ... }
    mutating func multiply(by number: Int) {
        let walkableNum = String(number).flatMap{Int(String($0))!}
        let length = walkableNum.count - 1
        var multiGet = Geteger(number: 0)
        var walkableNumIndex = 0
        while walkableNumIndex <= length {
            let key = walkableNum[walkableNumIndex]
            let zerosToAddBasedOnColOfInput = Int.init(truncating: pow(10, length - walkableNumIndex) as NSDecimalNumber)
            for arrayValueIndex in 0..<self.arrayValue.count {
                // Chunks are constant size, need to add using bit shifting more efficiently
                let zerosToAddBasedOnMyCols: Int = Int.init(truncating: pow(10, arrayValueIndex) as NSDecimalNumber)
                let chunk = (key * zerosToAddBasedOnColOfInput * zerosToAddBasedOnMyCols * self.arrayValue[arrayValueIndex])
                print("Chunk", chunk)
                multiGet.add(chunk)
            }
            walkableNumIndex += 1
        }
        self.arrayValue = multiGet.arrayValue
    }
    
}

//var myMachine = Geteger(number: 56779)
//print("Initialised myMachine<Geteger>", myMachine.stringValue)
//myMachine.add(30997)
//print("+ 30997 =", myMachine.stringValue)
//myMachine.multiply(by: 25)
//print(". 25 =", myMachine.stringValue)

var factorial = 20
var factorialVictim = Geteger(number: factorial)
for factorialIndex in 1..<factorial {
    factorialVictim.multiply(by: factorial - factorialIndex)
}
print("\(factorial)! = ", factorialVictim.stringValue)
factorialVictim.minusOne()
print(factorialVictim.stringValue)

