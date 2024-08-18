//: [Previous](@previous)

import Foundation

//MARK: - 1. What is the difference between a struct and a class in Swift?
/*
 Structs are value types, while classes are reference types.
 Structs have default designeted initilizer while class have no default designeted initilizer.
 Class support inheritance while struct haven't.
 Class use heap memory while struct use static memory.
 */
//TODO: Example
struct Person {
    var name: String
}
var person1 = Person(name: "Prince")
var person2 = person1

print("Person1 : \(person1.name), Person2 : \(person2.name)")

person1.name = "Priyanka"

print("Person1 : \(person1.name), Person2 : \(person2.name)")

class Employee {
    var name: String
    init(name: String) {
        self.name = name
    }
}
let employee1 = Employee(name: "Prince")// address: 1234
var employee2 = employee1// address: 1235 -> 1234

print("Employee1 : \(employee1.name), Employee2 : \(employee2.name)")

employee1.name = "Priyanka"// so employee2 holding address of employee1, so whenever employee value change, it is going to reflect in employee2

print("Employee1 : \(employee1.name), Employee2 : \(employee2.name)")

//MARK: - 2. Can you explain the concept of value types and reference types in Swift? How do structs fit into this?
/*
 Value types are copied when assigned, while reference types share the same instance.
 */
//TODO: - Example
struct ValueStruct {
    var x: Int
}
let value = ValueStruct(x: 1)
var copy = value
copy.x = 2
print(value.x) // still 1

class ReferenceClass {
    var num: Int?
}
let reference = ReferenceClass()
reference.num = 1
var copyReference = reference
copyReference.num = 2
print(reference.num) // now 2

//MARK: - 3. Can you explain the concept of inheritance in Swift classes?
/*
 Inheritance allows a class to inherit properties and methods from super class.
 */
class Animal {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Dog: Animal {
    var breed: String
    init(name: String, breed: String) {
        self.breed = breed
        super.init(name: name)
    }
}

//MARK: - When would you use a struct instead of a class in Swift?

/*
 You would use a struct instead of a class in Swift when:
 1. You need a value type, not a reference type.
 2. You need to ensure thread safety.
 3. You need to optimize performance.
 4. You need to represent a simple data model.
 
 Suppose you're building a financial app that manages user investments. You have a `Portfolio` class that holds a collection of `Investment` objects:
 */
 class Portfolio {
     var investments: [Investment]
     init(investments: [Investment]) {
         self.investments = investments
     }
     func calculateTotalValue() -> Double {
         return investments.reduce(0) { $0 + $1.value }
     }
 }

 struct Investment {
     var asset: String
     var value: Double
     var currency: String
 }
/*
 In this example, `Investment` is a struct because it represents a simple data model with value-type semantics. Each `Investment` instance has its own copy of the data, and changes to one instance don't affect others.

 The `Portfolio` class, on the other hand, manages a collection of `Investment` objects and provides methods to calculate the total value of the portfolio. It's a class because it has reference-type semantics, and multiple `Portfolio` instances can share the same `Investment` objects.

 By using a struct for `Investment`, you ensure that:

 - Each `Investment` instance has its own copy of the data, ensuring thread safety.
 - The data model is simple and easy to understand, with clear semantics.
 - Memory usage is optimized, as structs are stored in memory contiguously.

 By using a class for `Portfolio`, you ensure that:

 - Multiple `Portfolio` instances can share the same `Investment` objects, reducing memory usage.
 - The `Portfolio` class can manage the collection of `Investment` objects and provide methods to calculate the total value.

 This design choice allows you to take advantage of the strengths of both structs and classes, making your code more efficient, safe, and maintainable.
 */
