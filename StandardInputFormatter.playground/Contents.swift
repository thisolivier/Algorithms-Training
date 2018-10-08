//: Playground - noun: a place where people can play

import UIKit

protocol Formatter {
    
    associatedtype OutputType
    
    var rawText: String { get set }
    var formattedText: OutputType { get }
    
    func format() -> OutputType
}

extension Formatter {
    
    var formattedText: OutputType {
        return format()
    }
    
}

struct HackerRankArrayFormatter: Formatter {
    
    var rawText: String
    
    internal func format() -> [Int] {
        return rawText.split(separator: " ").map{ Int($0)! }
    }
    
}

print(HackerRankArrayFormatter(rawText: "295 294 291 287 287 285 285 284 283 279 277 274 274 271 270 268 268 268 264 260 259 258 257 255 252 250 244 241 240 237 236 236 231 227 227 227 226 225 224 223 216 212 200 197 196 194 193 189 188 187 183 182 178 177 173 171 169 165 143 140 137 135 133 130 130 130 128 127 122 120 116 114 113 109 106 103 99 92 85 81 69 68 63 63 63 61 57 51 47 46 38 30 28 25 22 15 14 12 6 4").formattedText)
