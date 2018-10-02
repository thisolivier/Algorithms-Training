//: Climbing the Leaderboard - challenge: https://www.hackerrank.com/challenges/climbing-the-leaderboard/

import Foundation

func climbingLeaderboard(scores: [Int], alice: [Int]) -> [Int] {
    var output = [Int]()
    for aliceScore in alice {
        var rank = 0
        var last = -1
        for score in scores {
            if score != last {
                rank += 1
            }
            last = score
            if score <= aliceScore {
                output.append(rank)
                break
            }
        }
        if last == scores.last {
            output.append(rank + 1)
        }
    }
    return output
}

print(climbingLeaderboard(scores: [100, 90, 90, 80, 70, 60, 32, 1], alice: [1, 0, 50, 44, 90]))
