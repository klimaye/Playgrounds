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

let result = bind(bind(names, longest),atleast5chars)

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
println(averageOfFunction(3, 4, { $0*$0*$0}))

