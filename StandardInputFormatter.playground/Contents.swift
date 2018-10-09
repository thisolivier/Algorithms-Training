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

print(HackerRankArrayFormatter(rawText: "5 5 6 14 19 20 23 25 29 29 30 30 32 37 38 38 38 41 41 44 45 45 47 59 59 62 63 65 67 69 70 72 72 76 79 82 83 90 91 92 93 98 98 100 100 102 103 105 106 107 109 112 115 118 118 121 122 122 123 125 125 125 127 128 131 131 133 134 139 140 141 143 144 144 144 144 147 150 152 155 156 160 164 164 165 165 166 168 169 170 171 172 173 174 174 180 184 187 187 188 194 197 197 197 198 201 202 202 207 208 211 212 212 214 217 219 219 220 220 223 225 227 228 229 229 233 235 235 236 242 242 245 246 252 253 253 257 257 260 261 266 266 268 269 271 271 275 276 281 282 283 284 285 287 289 289 295 296 298 300 300 301 304 306 308 309 310 316 318 318 324 326 329 329 329 330 330 332 337 337 341 341 349 351 351 354 356 357 366 369 377 379 380 382 391 391 394 396 396 400").formattedText)
