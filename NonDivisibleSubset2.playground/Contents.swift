//: Playground - noun: a place where people can play

import Foundation

typealias Factors = [Int:Int]

// you end up with a graph, where you need to calculate the longest possible edge where no two nodes can be divided by the divisor.
// for each node, you need to build possible edges, but you can remove each node you've already built from from subsequent builds. If a node was already built from, the set of edges which was built is the set of all possible edges containing the node, therefore there can be no new edges made which will contain it, so no need to use it again.
// now to think about this in terms of an array or dictionary. As an array, you hold Structs, which have factors<[Int:Int]>, and a dict of other indexes they can be added to.
// when we build, we start with an array of nothing, and we check the current node isn't already in the array (go back to front) bailing out if we find ourselves. Meanwhile check against item in this edge if it breaks the divisor limit. The longer the edge, the harder to work out.
// if it passes the check, we build again from the new index with the set containing the previous set and the new item.

// Well fuck, you were supposed to solve for where the sum of the numbers is not divisible, not the product
// In the case of the sum, you want to calculate connecting nodes very differently
// A connecting node is one where the the factors of the divisor do NOT emerge for the sum of the two items
// Building a list is a matter of checking if we can add... wait... I'm solving for sums, why am I calculating connecting nodes so wierdly?
// The can add is really a can multiply. Can add is a matter of summing and then doing our factor magic.

class NonDivisibleSubset {
    
    struct Item {
        
        let factors: Factors
        var connectingNodes: [Int]
        
        init(factors: Factors) {
            self.factors = factors
            self.connectingNodes = []
        }
        
        mutating func addConnection(to newNodeIndex: Int) {
            connectingNodes = [newNodeIndex]
        }
        
    }
    
    let divisorFactors: Factors
    let bias: Int
    var world:[Item]
    var largestSubsetSize: Int {
        return 1
    }
    
    
    init(numbers:[Int], divided by: Int){
        let divisorFactorsResult: FactorCalculationResult = calculateFactors(in: by)
        guard case let FactorCalculationResult.success(divisorFactors) = divisorFactorsResult else {
            fatalError()
        }
        self.divisorFactors = divisorFactors
        var bias = 0
        print("Hello", divisorFactors)
        self.world = numbers.map({ (number: Int) -> Item? in
            var item: Item?
            // Not the right time to do this...
            // We want to have a world of all the numbers which can be added to at least one other number, and each of them should have a set of the indexes to which they can be added.
            // Every time we construct an edge, we need to check that the new one we're adding is in the sets of every other item in the list.
            switch calculateFactors(in: number, filter: divisorFactors) {
            case .success(let value):
                item = Item(factors: value)
            case .filteredZeroRemain:
                bias += 1
            case .filteredTooLarge:
                break
            }
            return item
        }).filter({ $0 != nil }).map{ $0! }
        self.bias = bias
        self.calculateConnectingNodes()
    }
    
    private func canAdd(_ current: Factors, with new: Factors) -> Factors? {
        var tooHigh = true
        var newFactors = Factors()
        for key in divisorFactors.keys {
            newFactors[key] = (current[key] ?? 0) + (new[key] ?? 0)
            if newFactors[key]! < divisorFactors[key]! {
                tooHigh = false
            }
        }
        return tooHigh ? nil : newFactors
    }
    
    private func calculateConnectingNodes() {
        var index = 1
        print(world.count)
        while index < world.count {
            var subsetIndex = index + 1
            while subsetIndex < world.count {
                if canAdd(world[index].factors, with: world[subsetIndex].factors) != nil {
                    world[index].addConnection(to: subsetIndex)
                    world[subsetIndex].addConnection(to: index)
                }
                subsetIndex += 1
            }
            index += 1
        }
        for item in world {
            print(item)
        }
    }
    
    func calculateLongestEdge(fromIndex: Int, withEdge: [Int]) -> Int{
        var fromItem = world[fromIndex]
        print("Calculating edge, checking", fromIndex, withEdge)
        for item in withEdge {
            if self.canAdd(self.world[item].factors, with: fromItem.factors) == nil {
                return withEdge.count
            }
        }
        print("Can add")
        let newEdge = withEdge + [fromIndex]
        var max = newEdge.count
        for item in fromItem.connectingNodes {
            if newEdge.contains(item)  {
                print("Skipping item", item)
                continue
            }
            let newMax = calculateLongestEdge(fromIndex: item, withEdge: newEdge)
            if newMax > max {
                max = newMax
            }
        }
        return max
    }
    
    func largestNonDivisibleSubsetSize() -> Int {
        var maxSize = 0
        var index = 0
        while index < world.count {
            let longestEdge = self.calculateLongestEdge(fromIndex: index, withEdge: [])
            if longestEdge > maxSize {
                maxSize = longestEdge
            }
            index += 1
        }
        return maxSize + bias
    }
    
}

enum FactorCalculationResult {
    case success(Factors)
    case filteredZeroRemain
    case filteredTooLarge
}

func calculateFactors(in number: Int, filter: Factors? = nil) -> FactorCalculationResult {
    var quotient = number
    var isReal = false
    var factors = Factors()
    
    if let filter = filter {
        var index = 0
        var tooHigh = true
        for key in filter.keys {
            var done = false
            while !done {
                let maybeRemainder = quotient.quotientAndRemainder(dividingBy: key)
                print(maybeRemainder, key)
                if maybeRemainder.remainder == 0 {
                    let current = factors[key]
                    factors[key] = current == nil ? 1 : current! + 1
                    quotient = maybeRemainder.quotient
                } else {
                    done = true
                }
            }
            if let value = factors[key]  {
                isReal = true
                if value < filter[key]! {
                    tooHigh = false
                }
            } else {
                factors[key] = 0
            }
            index += 1
        }
        print(isReal, tooHigh)
        return isReal ? (!tooHigh ? .success(factors) : .filteredTooLarge) : .filteredZeroRemain
    } else {
        var index = 2
        isReal = true
        while quotient != 1, index <= number {
            let maybeRemainder = quotient.quotientAndRemainder(dividingBy: index)
            if maybeRemainder.remainder == 0 {
                let current = factors[index]
                factors[index] = current == nil ? 1 : current! + 1
                quotient = maybeRemainder.quotient
            } else {
                index += 1
            }
        }
        return .success(factors)
    }
}

let test = NonDivisibleSubset(numbers: [278, 576, 496, 727, 410, 124, 338, 149, 209, 702, 282, 718, 771, 575, 436], divided: 7)
print(test.largestNonDivisibleSubsetSize())

