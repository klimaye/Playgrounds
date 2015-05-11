//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

println("x is great!")

let cardsInDesk = 52
var players = 5

var name:String?
var job:String!
var city:String

name = "K"
job = "iOS"
city = "shv"


println("name is \(name!)")
println("name is \(job)")

//classes & objects

//classes and functions are reference types
println("------------------")

class Person {
    var firstName:String
    var lastName:String
    
    init(firstName:String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func say(phrase:String) {
        println("\(firstName) \(lastName) says \(phrase)")
    }
    
    class func say(phrase:String) {
        println("all people say \(phrase)")
    }
}

let p1 = Person(firstName: "K", lastName: "L")
p1.say("Let's write swift")
Person.say("Hey y'all")

//functions
println("------------------")

func say(#phrase:String) {
    println("\(phrase)")
}
func say(#phrase:String, times:Int) {
    for i in 0...times {
        say(phrase: phrase)
    }
}
func speak(#phrase:String, #times:Int) {
    for i in 0...times {
        say(phrase: "Hello \(phrase)")
    }
    
}

say(phrase: "Bye",10)
speak(phrase: "Hello", times:10)


//closures
println("------------------")

let names = ["Al", "Ann", "Alex", "Alice", "Audrey"]

let filtered = names.filter() { $0.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 3 }
println(filtered)

func isShortName(name: String) -> Bool {
    return name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 4
}

println(names.filter(isShortName))

func nameWithMaxLength(max: Int) -> (String) -> Bool {
    return { (name:String) -> Bool in
        return name.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < max
    }
}

println(names.filter(nameWithMaxLength(5)))

//methods
//for methods, when calling them, first argument label is not required to match objc style. But next arguments have to specified with labels.

//structures (cannot inherit, only one reference per instance, i.e assignment creates a copy)

//easy to model simple data
//data will be copied instead of referenced


println("------------------")

struct Dude {
    var firstName:String
    var lastName:String
    
    func say(phrase:String) {
        println("\(firstName) \(lastName) says \(phrase)")
    }
    
//    class func say(phrase:String) {
//        println("all people say \(phrase)")
//    }
}

let pp1 = Person(firstName: "P", lastName: "Q")
let pp2 = p1

var d1 = Dude(firstName: "D", lastName: "E")
var d2 = d1 //creates a copy of d1
d1.firstName = "dude"
d1.lastName = "yes"

println("\(d1.firstName) \(d1.lastName)")
println("\(d2.firstName) \(d2.lastName)")

//all swift internal types are implemented as Structs and not classes


//enumerations
//enums can have methods, properties and cannot be interchanged
//allows use of . syntax .EaseInOut
println("------------------")
enum CardType {
    case None
    case Visa
    case Amex
    case MasterCard
    case Discover
    
    private func regularExpression() -> NSRegularExpression {
        switch self {
        case .Visa:
            return NSRegularExpression(pattern: "", options: nil, error: nil)!
        case .Amex:
                return NSRegularExpression(pattern: "", options: nil, error: nil)!
        case .MasterCard:
                return NSRegularExpression(pattern: "", options: nil, error: nil)!
        case .Discover:
                return NSRegularExpression(pattern: "", options: nil, error: nil)!
        case .None:
            return NSRegularExpression(pattern: "", options: nil, error: nil)!
        }
    }
    
    func isValidFor(cardNumber: String) -> Bool {
        return false
    }
    
    static let allValues = [Visa, MasterCard, Amex, Discover]
    static func from(cardNumber: String) -> CardType {
        for type in self.allValues {
            if type.isValidFor(cardNumber) {
                return type
            }
        }
        return .None
    }
}

CardType.Visa.isValidFor("0")
println("------------------")

//meta types
@objc protocol Tuneable {
    var pitch: Double { get }
    func tuneSharp()
    func tuneFlat()
    //optional method.
    //@objc is only allowed on classes
    optional func transpose(hertz: Double)
}

class Guitar: Tuneable {
    @objc var pitch: Double = 440
    @objc func tuneSharp() {
         println("increasing tension")
        self.pitch += 5
    }
    
    @objc func tuneFlat() {
        println("decreasing tension")
        self.pitch -= 5
    }
    
    @objc func transpose(hertz: Double) {
        pitch += hertz
        println("pitch is \(pitch)")
    }
}

@objc class Saxaphone: Tuneable {
    @objc var pitch: Double = 440
    @objc func tuneSharp() {
        println("increasing tension")
        self.pitch += 5
    }
    
    @objc func tuneFlat() {
        println("decreasing tension")
        self.pitch -= 5
    }
}

let guitar = Guitar()
let sax = Saxaphone()
let instruments : [Tuneable] = [guitar, sax]

for i in instruments {
    i.transpose?(20)
}

println("------------------")
//extensions ~= categories in objc
//add computed properties and not stored properties
//used to package code
extension String {
    func reverse() -> String {
        let chars = Array(self).reverse()
        var reversed = ""
        for char in chars {
            reversed.append(char)
        }
        return reversed
    }
}

let name1 = "Kshitij"
name1.reverse()

//object oriented swift
println("------------------")
class Man {
    let firstName:String
    let lastName:String
    
    init(firstName:String, lastName:String) {
        self.firstName = firstName;
        self.lastName = lastName
    }
    
    //convenience initialzer has to call designated initializer in the same class
    convenience init() {
        self.init(firstName:"John", lastName:"Doe")
    }
    //designated initializers delegate up while convenience initializers delegate across.
    
    //all no optional properties need initialization
    //sub class is only responsible for initializing properties it introduces.
}

let s1 = Man(firstName: "K", lastName: "L")
let s2 = Man()

class Student: Man {
    let age:Int
    init(firstName: String, lastName: String, age:Int) {
        self.age = age
        super.init(firstName: firstName, lastName: lastName)
    }
}

class Employee : Man {
    var yearsOfService:Int = 0
    convenience init(firstName: String, lastName: String, years:Int) {
        self.init(firstName: firstName, lastName: lastName)
        self.yearsOfService = years
    }
}
//*** to inherit initializers, subclass can only add properties with default values yearsOfService = 0
let student = Student(firstName: "H", lastName: "B", age: 12)
//employee inherits designated initializers becase it did not add any designated initializers of its own
let emp2 = Employee(firstName: "M", lastName: "M")
//employee inherits convenience initializers because it inherits/implements superclass' designated initializers
let emp1 = Employee()
let emp3 = Employee(firstName: "J", lastName: "S", years: 22)

//deinit --- what!!!!
//not required to implement
//supported only for classes
println("------------------")
class Observer : NSObject {
    override init() {
        super.init()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "processBigEvent:", name: "TheBigEvent", object: nil)
    }
    
    deinit {
        println("Inside deinit")
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }
    
    func processBigEvent(notification: NSNotification) {
        println("Whoa! big event has occured")
    }
 }

let notification = NSNotification(name: "TheBigEvent", object: nil)
let nc = NSNotificationCenter.defaultCenter()
nc.postNotification(notification)

var observers = [Observer()]
nc.postNotification(notification)

observers.removeAll(keepCapacity: true)
nc.postNotification(notification) //nothing printed as observer deallocated/deinited

println("------------------")
//lazy properties
class DatabaseConnect {
    init() {
        println("New database is up and running")
    }
    
    func execute(command:String) {
        println("executing \(command)")
    }
}

class DataStore {
    lazy var connection = DatabaseConnect()
}

let store = DataStore()
store.connection.execute("select * from users")

//complex properties

//computed properties have to declared as var as they can change
class Calendar {
    //use closure to assign value to property
    var frenchMonths: [String] = {
       return ["janvier","fevrier"]
    }()
    
    
    
}

//overriding
//only methods and computed properties can be overriden
//only classes support it
//stored properties cannot be overriden
//final keyword to disable overriding
println("------------------")
class Human {
    let firstName:String
    let lastName:String
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    deinit {
        println("human deinit called")
    }
    
    init(firstName:String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func say(message:String) {
        println("\(fullName) says \(message)")
    }
}

class Player : Human {
    override var fullName: String {
        get {
            return super.fullName.uppercaseString
        }
    }
    
    deinit {
        println("player deinit is called")
    }
    
    override func say(message: String) {
        println("Student \(fullName) shouts \(message)")
    }
}
//child classes can decorate parents
var h = Human(firstName: "harris", lastName: "sam")
var p = Player(firstName: "harris", lastName: "sam")
var h1:Human = Player(firstName: "star", lastName: "wars")

h.fullName
p.fullName
h1.fullName

h.say("Hi there")
p.say("Hi there")
h1.say("stop")

println("------------------")
//overriding deinit
var h2:Human! = Human(firstName: "going", lastName: "away")
var p3:Player! = Player(firstName: "moving", lastName: "out")
h2 = nil
p3 = nil

//polymorphism
//class polymorphism - inheritance or protocol conformance
//struct polymorphism - protocol conformance

//is protocol conformance / class inheritance
//as? conditional downcast
//as! forces downcase (can create runtime exception)

//TODO: see if 'is' operator is fixed
println("------------------")
protocol Area {
    var name:String { get }
    func area() -> Float
}

class Square : Area {
    var name:String {
        get {
            return "Square"
        }
    }
    var side: Float
    func area() -> Float {
        return side * side
    }
    init(side:Float) {
        self.side = side
    }
}

class Circle : Area {
    var name:String {
        get {
            return "Circle"
        }
    }
    var radius:Float
    func area() -> Float {
        return 3.14 * radius * radius
    }
    init(radius:Float) {
        self.radius = radius
    }
}

struct Country : Area {
    var name:String {
        get {
            return self.countryName
        }
    }
    var countryName:String
    var countryArea:Float
    func area() -> Float {
        return countryArea
    }
    init(name:String, countryArea:Float) {
        self.countryArea = countryArea
        self.countryName = name
    }
}

let a1 = Square(side: 5)
let a2 = Square(side: 10)
let c1 = Circle(radius: 5)
let c2 = Circle(radius: 10)
let nation = Country(name: "struct Belize", countryArea: 50000)

//let stuff = [nation, a1,a2,"hello",c1,c2, 10, false] //did not work
let stuff = [a1,a2,"hello",c1,c2, 10, false]
for thing in stuff {
    if thing is Area {
        let shape = thing as! Area
        println("\(shape.name) area is \(shape.area())")
    }
    else {
        println("\(thing) as no area")
    }
}

let array:[Any] = [nation, a1] // works
for thing in array {
    if thing is Area {
        let areable = thing as! Area
        println("\(areable.name)")
    }
}

//memory management
println("------------------")
//weak has to be defined as optional
//unowned is not defined as optional. can cause runtime exception

//func and closures are reference types

println("------------------")
//generics
//e.g. struct Array<T>
//e.g. struct Dictionary<Key: Hashable, value>
//very much like c#

extension Array {
    func my_map<U>(transform: (T) -> U) -> [U] {
        var transformed = Array<U>()
        for item in self {
            transformed.append(transform(item))
        }
        return transformed
    }
}

let namesArray = ["Steven", "Rob", "Lex"]
println(namesArray.my_map() { (name:String) in
    name.uppercaseString
})
let numbers = [5,2,3]
println(numbers.my_map() { (number:Int) in
    number * number
})
