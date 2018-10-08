//: Playground - noun: a place where people can play

import UIKit

protocol Formatter {
    var rawText: String? { get set }
    var formattedText: String? { get }
    
    func format() -> String?
}

extension Formatter {
    
    var formattedText: String? {
        return format()
    }
    
}

