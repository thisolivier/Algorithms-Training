//: Playground - noun: a place where people can play

import UIKit

func printMaxArr(input:Array<Int>){
    var currMax = input[0]
    for value in input{
        if value > currMax {
            currMax = value
        }
    }
}
