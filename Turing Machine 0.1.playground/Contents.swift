// For Rikhil

//: Turing Machine - noun: model of computation defining abstract machine: manipulates symbols on a strip of tape according to a rules dict. Instructions capable of simulating any algorithm's logic can be constructed.

import Foundation

struct TuringMachine {
    
    private var flag: Int = 0
    private var count: Int = 0
    private var limit: Int?
    private var tape: Tape = Tape() {
        didSet {
            if self.count == limit ?? -1 {
                assertionFailure("Hit the limiter")
            } else {
                self.count += 1
            }
        }
    }
    private var state: State {
        get {
            return State(flag: self.flag, value: self.tape.head)
        }
    }
    private var viewPosition: Int = 12 {
        didSet {
            self.viewPosition = self.viewPosition < 3 ? 3 : self.viewPosition > 20 ? 20 : self.viewPosition
        }
    }
    
    mutating func execute(_ instructions: Instructions, executionLimit: Int? = 1000) {
        self.limit = executionLimit
        while true {
            let instruction = instructions.getInstrucion(for: self.state)
            self.viewMachine(newValue: instruction.value)
            self.viewPosition = instruction.direction == .right ? viewPosition + 1 : viewPosition - 1
            self.tape.move(newValue: instruction.value, direction: instruction.direction)
            self.flag = instruction.flag
        }
    }
    
    private func viewMachine(newValue: Character) {
        let leftSide = self.tape.readTape(numberOfChars:  self.viewPosition - 3, direction: .left)
        let rightSide = self.tape.readTape(numberOfChars: 23 - self.viewPosition, direction: .right)
        let head = "".padding(toLength: viewPosition, withPad: " ", startingAt:0)+"/\(newValue)\\"
        print("""
            ...\(leftSide)|\(self.tape.head)|\(rightSide)...
            \(head)                     \(self.count)
            """)
    }
    
}

struct Tape {
    var head: Character = "B"
    private var rhs: String = ""
    private var lhs: String = ""
    
    mutating func move(newValue: Character, direction: Instruction.Direction) {
        switch direction {
        case .left:
            rhs.append(newValue)
            self.head = lhs.count > 0 ? lhs.removeLast() : Character("B")
        case .right:
            lhs.append(newValue)
            self.head = rhs.count > 0 ? rhs.removeLast() : Character("B")

        }
    }
    
    func readTape(numberOfChars: Int, direction: Instruction.Direction) -> String {
        switch direction {
        case .right:
            let first10 = String(rhs.characters.suffix(numberOfChars))
            return first10.padding(toLength: numberOfChars, withPad:"B", startingAt: 0)
        case .left:
            let first10 = String(lhs.characters.suffix(numberOfChars))
            return String(String(first10.reversed()).padding(toLength: numberOfChars, withPad:"B", startingAt: 0).reversed())
        }
    }
    
}

struct State: Hashable {
    
    let flag: Int
    let value: Character
    
    var hashValue: Int {
        return self.flag.hashValue + self.value.hashValue
    }
    
    static func == (lhs: State, rhs: State) -> Bool {
        return rhs.flag == lhs.flag && rhs.value == lhs.value
    }
    
}

struct Instruction: Hashable {
    
    enum Direction {
        case left, right
    }
    
    let value: Character
    let direction: Direction
    let flag: Int
    
    var hashValue: Int {
        return self.direction.hashValue * self.flag.hashValue * self.value.hashValue
    }
    
    static func == (lhs: Instruction, rhs: Instruction) -> Bool {
        return lhs.flag == rhs.flag && lhs.direction == rhs.direction && lhs.value == rhs.value
    }
    
}

struct Instructions {
    var instructions: Dictionary<State, Instruction> = [:]
    
    mutating func add(when value: Character, withFlag flag: Int, newValue: Character, newFlag: Int, thenMove direction: Instruction.Direction) {
        let state = State(flag: flag, value: value)
        guard instructions[state] == nil else {
            preconditionFailure("Already have matching instruction")
        }
        instructions[state] = Instruction(value: newValue, direction: direction, flag: newFlag)
    }
    
    // It's the instructions which fail if there's none available, not the machine
    func getInstrucion(for state: State) -> Instruction {
        guard let instruction = self.instructions[state] else {
            preconditionFailure("Instructions are not complete")
        }
        return instruction
    }
}

///// GO
var mrTuring = TuringMachine()
var instructions = Instructions()
instructions.add(when: "B", withFlag: 0, newValue: " ", newFlag: 1, thenMove: .right)
instructions.add(when: "B", withFlag: 1, newValue: "O", newFlag: 2, thenMove: .right)
instructions.add(when: "B", withFlag: 2, newValue: "l", newFlag: 3, thenMove: .right)
instructions.add(when: "B", withFlag: 3, newValue: "i", newFlag: 4, thenMove: .right)
instructions.add(when: "B", withFlag: 4, newValue: "v", newFlag: 5, thenMove: .right)
instructions.add(when: "B", withFlag: 5, newValue: "i", newFlag: 6, thenMove: .right)
instructions.add(when: "B", withFlag: 6, newValue: "e", newFlag: 7, thenMove: .right)
instructions.add(when: "B", withFlag: 7, newValue: "r", newFlag: 8, thenMove: .right)
instructions.add(when: "B", withFlag: 8, newValue: " ", newFlag: 9, thenMove: .right)
instructions.add(when: "B", withFlag: 9, newValue: " ", newFlag: 10, thenMove: .right)
instructions.add(when: "B", withFlag: 10, newValue: " ", newFlag: 18, thenMove: .right)
instructions.add(when: "B", withFlag: 18, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: " ", withFlag: 16, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: "r", withFlag: 16, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: "e", withFlag: 16, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: "l", withFlag: 16, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: "i", withFlag: 16, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: "v", withFlag: 16, newValue: "B", newFlag: 16, thenMove: .left)
instructions.add(when: "O", withFlag: 16, newValue: "B", newFlag: 17, thenMove: .left)
instructions.add(when: " ", withFlag: 17, newValue: "B", newFlag: 17, thenMove: .left)
instructions.add(when: "B", withFlag: 17, newValue: "B", newFlag: 0, thenMove: .right)


mrTuring.execute(instructions, executionLimit: 30)
