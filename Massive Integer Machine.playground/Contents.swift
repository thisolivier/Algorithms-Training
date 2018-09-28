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
    
    // TODO: Rewrite using <T>().enumerated().map { (index: Int, element: <T>) in ... }
    mutating func multiply(by number: Int) {
        let walkableNum = String(number).flatMap{Int(String($0))!}
        let length = walkableNum.count - 1
        var multiGet = Geteger(number: 0)
        var walkableNumIndex = 0
        while walkableNumIndex <= length {
            let key = walkableNum[walkableNumIndex]
            var toAdd = 0
            for arrayValueIndex in 0..<self.arrayValue.count {
                let chunk = (self.arrayValue[arrayValueIndex] * key * Int(pow(10, arrayValueIndex) as NSDecimalNumber))
                // All chunks are the same size, just shifted. Need an add function that doesn't increace cost just because new col
                print("Chunk", chunk)
                toAdd += chunk
            }
            // You need to make sure toAdd doesn't become another massive int - some bit shifting maybe?
            print("toAdd", toAdd)
            multiGet.add(toAdd * Int(pow(10, length - walkableNumIndex) as NSDecimalNumber))
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
print("\(factorial) != ", factorialVictim.stringValue)


