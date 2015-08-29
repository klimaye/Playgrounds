//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

println("Hello Praeses")

for i in 1...10 {
    println(i)
}

//immutable and optionals
let cannotChange    = "immutable"
var canChange       = "mutable"


//variable types and assignment
var name:String?
var job:String!
var city:String

name = "abc"
job = "boj"
city = "shv"

let assign1:String = name!

let assign2:String = job

let assign3:String = city

//println("\(name), \(job), \(city)")

//structs and classes
struct MyStruct : Equatable {
    let immutable:String
    var mutable:String //can be changed if instance assigned to a var
}

func == (lhs:MyStruct, rhs:MyStruct) -> Bool {
    return lhs.immutable == rhs.immutable
}

var mine = MyStruct(immutable: "immutable", mutable: "mutate")
mine.mutable = "a"


let imm = MyStruct(immutable: "don't touch", mutable: "same here")

imm.mutable

let same = MyStruct(immutable: "immutable", mutable: "mutate")

mine == same

//class
class MyClass {
    let immutable:String
    var mutable:String
    
    init(imm:String, mut:String) {
        self.immutable  = imm
        self.mutable    = mut
    }
    
    func say(message:String) {
        println("instance says \(message)")
    }
    
    class func say(message:String) {
        println("class says \(message)")
    }
    
    static func shout(message:String) {
        println("class shouts \(message)")
    }
    
    func values() -> (String, String) {
        return (self.immutable, self.mutable)
    }
}
//tuples
func makeNetworkRequest(requestUrl:String) -> (statusCode:Int, error:String) {
    return (404, "Not found")
}

let instance = MyClass(imm: "A", mut: "B")
instance.say("Praeses")
println("\(instance.values())")
MyClass.say("LLC")
MyClass.shout("Corp")

var optional:String?
var none:String?
optional = "tree"

println(optional)
println(none)
if let tree = optional {
    println(tree)
}
if let value = none {
    println("has value \(value)")
}

//closures
let numbers = [1,3,4,5]
var calculatedNumbers:[Int] = []
for number in numbers {
    calculatedNumbers.append(number * 2)
}
println(calculatedNumbers)

let calculated3 = map(numbers) { $0 * 3 }
println(calculated3)

let names = ["Al", "Alice", "Alwin", "Arnold", "Ann"]

let longest:[String] -> String = {
    list in
    return list.reduce("") { count($0) > count($1) ? $0 : $1 }
}

println("\(longest(names))")

func bind<A,B>(a:A?, f:A -> B) -> B? {
    if let x = a {
        return f(x)
    }
    return .None
}

let atleast5chars:String -> Bool = {
    item in
    return count(item) >= 5
}
let atleast5chars2:String -> Bool = { count($0) >= 10 }

let result = bind(bind(names, longest),atleast5chars2)

println("\(result)")


func averageOfFunction(a:Float, b:Float, f:(Float -> Float)) -> Float {
    return (f(a) + f(b)) / 2
}

func applyKTimes(f:(Float -> Float), #x:Float, k:Int) -> Float {
    var answer:Float = x
    for i in 1...k {
        answer = f(answer)
    }
    return answer
}

let square = applyKTimes({ $0 * $0 }, x:2, 1)
println(square)

var avg = averageOfFunction(3, 4, { $0 * $0 })
println(avg)
avg = averageOfFunction(3, 4, { $0*$0*$0})
println(avg)

let evens = Array(1...10).filter({ $0 % 2 == 0})
println(evens)

extension Array {
func myFilter<T>(predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in self {
        let element = i as! T
        if predicate(element) {
            result.append(element)
        }
    }
    return result
}
}
let odds = Array(1...10).myFilter({ $0 % 2 == 1})
println(odds)

var evenSum = Array(1...10)
    .filter({ $0 % 2 == 0})
    .reduce(0, combine: { (total,item) in total + item })
println(evenSum)

var evenString = Array(1...10)
    .filter( { $0 % 2 == 0})
    .reduce("numbers: ", combine: { (str,item) in str + "\(item)" })

println(evenString)

let contacted:Int! = ["3","1","4","1"]
.reduce("", combine: {(result, item) in result + "\(item)" }).toInt()
println(contacted)

let mult = 0
let contacted2:Int! =
["3", "1", "4", "1"]
    .reduce(0, combine: {(result, item) in
        (result * 10) + item.toInt()!
    })

println(contacted2) //3141

let words = ["Cat", "Chicken", "fish", "Dog",
    "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func firstCharacter(word:String) -> Character {
    return Character(
        word.substringToIndex(
            word.startIndex.successor()
        ).uppercaseString
    )
}

func distinct(words:[Character]) -> [Character] {
    var result = [Character]()
    for item in words {
        if (!contains(result, item)) {
            result.append(item)
        }
    }
    return result
}

func buildIndex(words:[String]) -> [Entry] {
    let characters = words.map({ firstCharacter($0)}).sorted({ $0 < $1 })
    let distinctChars = distinct(characters)
    return distinctChars.map {
        (letter) -> Entry in
        var matches = words.filter({
            firstCharacter($0) == letter
        })
        return (letter,matches)
    }
}

println(buildIndex(words))


//custom operator fun
infix operator |> { associativity left}
public func |> <T,U>(array:[T],
    operation:T -> U) -> [U] {
        return array.map(operation)
}
let output =
words
    |> { $0.uppercaseString }
    |> { firstCharacter($0) }

println("******")
println(output)
println("******")