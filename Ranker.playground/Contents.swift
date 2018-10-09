//: Climbing the Leaderboard - challenge: https://www.hackerrank.com/challenges/climbing-the-leaderboard/

import Foundation

struct AliceScore {
    
    let index: Int
    let score: Int
    var cost: Int = 0
    var rank: Int = -1
    var logs: [String]
    
    mutating func log(_ log: String, shouldPrint: Bool = false) {
        if shouldPrint {
            print(log)
        }
        logs.append(log)
    }
    
}

func climbingLeaderboard(scores: [Int], alice: [Int]) -> [Int] {
    
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
    
    let sneakyTree = cheatTree(arrayWithDuplates: scores)
    let aliceScores:[AliceScore] = alice.map { (score: Int) in
        
        var aliceScore = AliceScore(index: alice.index(of: score)!, score: score, cost: 0, rank: -1, logs: [])
        var index = -1
        var minIndex: Int = 0
        var maxIndex: Int = sneakyTree.count - 1
        var emergencyStop = false
        aliceScore.log("no.\(aliceScore.index) Alice Scored \(aliceScore.score)")
        
        while aliceScore.rank == -1, !emergencyStop {
            let newIndex = (maxIndex + minIndex) / 2
            index = newIndex == index ? index + 1 : newIndex
            aliceScore.log("🎯 - Moving leaderboard index to \(index) using limits \(maxIndex), \(minIndex)")
            let currentLeaderboardItem = sneakyTree[index]
            
            if score >= currentLeaderboardItem.0 && index == 0 {
                aliceScore.rank = 1
                aliceScore.log("🏆 - Index of first place")
            } else if score < currentLeaderboardItem.0 && index + 1 == sneakyTree.count {
                aliceScore.rank = sneakyTree.count + 1
                aliceScore.log("💩 - Last place \(index)")
            } else if index + 1 < sneakyTree.count {
                let belowLeaderboardItem = sneakyTree[index + 1]
                if score < currentLeaderboardItem.0 && score >= belowLeaderboardItem.0 {
                    aliceScore.rank = belowLeaderboardItem.1
                    aliceScore.log("🏆 - Am below whats above, but above or equal to index \(index)")
                }
            }
            
            if score < currentLeaderboardItem.0 {
                minIndex = Int(index)
                aliceScore.log("🌠 - New ceiling index \(index)")
            } else {
                maxIndex = Int(index)
                aliceScore.log("🎈 - New floor index \(index)")
            }
            
            if aliceScore.cost == 14 {
                aliceScore.log("🤮 - \(score) on \(alice.index(of: score)!) try")
                emergencyStop = true
            } else {
                aliceScore.cost += 1
            }
        }
        return aliceScore
    }
    
    for scoreAndRank in sneakyTree {
        var flag = ""
        for score in aliceScores.filter( { (aliceScore: AliceScore) in
            return aliceScore.score == scoreAndRank.0
        }) {
            flag = flag + " - [\(score.score) on \(score.index)th try]"
        }
        print("\(scoreAndRank.1) - \(scoreAndRank.0)\(flag)")
    }
    
    let failures:[AliceScore] = aliceScores.filter{ $0.rank == -1}
    for failureScore in failures {
        print("""
            -----

            no.\(failureScore.index) Alice Scored \(failureScore.score)
            -----
            """)
        for log in failureScore.logs {
            print(log)
        }
    }
    
    return aliceScores.map{ $0.rank }
}

let context = [295, 294, 291, 287, 287, 285, 285, 284, 283, 279, 277, 274, 274, 271, 270, 268, 268, 268, 264, 260, 259, 258, 257, 255, 252, 250, 244, 241, 240, 237, 236, 236, 231, 227, 227, 227, 226, 225, 224, 223, 216, 212, 200, 197, 196, 194, 193, 189, 188, 187, 183, 182, 178, 177, 173, 171, 169, 165, 143, 140, 137, 135, 133, 130, 130, 130, 128, 127, 122, 120, 116, 114, 113, 109, 106, 103, 99, 92, 85, 81, 69, 68, 63, 63, 63, 61, 57, 51, 47, 46, 38, 30, 28, 25, 22, 15, 14, 12, 6, 4]
let alice = [1, 1, 5, 5, 6, 14, 19, 20, 23, 25, 29, 29, 30, 30, 32, 37, 38, 38, 38, 41, 41, 44, 45, 45, 47, 59, 59, 62, 63, 65, 67, 69, 70, 72, 72, 76, 79, 82, 83, 90, 91, 92, 93, 98, 98, 100, 100, 102, 103, 105, 106, 107, 109, 112, 115, 118, 118, 121, 122, 122, 123, 125, 125, 125, 127, 128, 131, 131, 133, 134, 139, 140, 141, 143, 144, 144, 144, 144, 147, 150, 152, 155, 156, 160, 164, 164, 165, 165, 166, 168, 169, 170, 171, 172, 173, 174, 174, 180, 184, 187, 187, 188, 194, 197, 197, 197, 198, 201, 202, 202, 207, 208, 211, 212, 212, 214, 217, 219, 219, 220, 220, 223, 225, 227, 228, 229, 229, 233, 235, 235, 236, 242, 242, 245, 246, 252, 253, 253, 257, 257, 260, 261, 266, 266, 268, 269, 271, 271, 275, 276, 281, 282, 283, 284, 285, 287, 289, 289, 295, 296, 298, 300, 300, 301, 304, 306, 308, 309, 310, 316, 318, 318, 324, 326, 329, 329, 329, 330, 330, 332, 337, 337, 341, 341, 349, 351, 351, 354, 356, 357, 366, 369, 377, 379, 380, 382, 391, 391, 394, 396, 396, 400]

let scores = climbingLeaderboard(scores: context, alice: alice)
print(scores)
