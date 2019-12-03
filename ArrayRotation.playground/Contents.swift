import UIKit

func rotateLeft(by: Int, array: [Int]) -> [Int] {
    let length = array.count
    var newArray: [Int] = array
    
    for index in 0..<length {
        var location = (index - by) % length
        if location < 0 {
            location += length
        }
        newArray[location] = array[index]
    }
    return newArray
}

var array = [1,2,3,4,5]

print(array)
let newArray = rotateLeft(by: 3, array: array)
print(newArray)
