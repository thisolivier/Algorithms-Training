//: Climbing the Leaderboard - challenge: https://www.hackerrank.com/challenges/climbing-the-leaderboard/

import Foundation

func climbingLeaderboard(scores: [Int], alice: [Int]) -> [Int] {
    var output = [Int]()
    var list: Node!
    var tempNodeBuffer: Node? = nil
    for score in scores {
        if let previous = tempNodeBuffer {
            tempNodeBuffer = Node(value: score, previous: previous)
        } else {
            list = Node(value: score, previous: nil)
            tempNodeBuffer = list
        }
    }
    for score in alice {
        var position: Node = list
        while score < position.value {
            position = position.next ?? Node(value: -1, previous: tempNodeBuffer)
        }
        print(position.rank)
        output.append(position.rank)
    }
    return output
}

class Node {
    
    let value: Int
    let rank: Int
    var next: Node? = nil
    
    init(value: Int, previous: Node?) {
        self.value = value
        if let previous = previous {
            self.rank = previous.value == value ? previous.rank : previous.rank + 1
            previous.next = self
        } else {
            self.rank = 1
        }
    }
    
}

print(climbingLeaderboard(scores: [100, 90, 90, 80, 70, 60, 32, 1], alice: [1, 0, 50, 44, 90]))
