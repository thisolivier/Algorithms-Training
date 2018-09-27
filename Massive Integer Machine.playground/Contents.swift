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
    
    init(number: Int) {
        self.add(number)
        print("Initialised Geteger ", stringValue)
    }
    
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
                self.arrayValue.insert(toAdd, at: index)
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
    
}

var myMachine = Geteger(number: 56779)
myMachine.add(30997)
print(myMachine.stringValue)
