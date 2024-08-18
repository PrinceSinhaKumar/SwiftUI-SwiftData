//: [Previous](@previous)

import Foundation

/*
 Here are some common interview questions related to generics in Swift:

 Also, be ready to answer questions about:

 - Type constraints
 - Associated types
 - Generic protocols
 - Type erasure
 - Generic functions
 - Generic data structures

 It's essential to have a solid understanding of Swift generics and be able to apply them to real-world scenarios.
 */
//MARK: - 1. What are generics in Swift, and how do they differ from protocols?
/*
1 - Ans: Generics allow you to write reusable code that can work with multiple types. They differ from protocols in that protocols define a blueprint of methods and properties, while generics define a blueprint of types.
Example:*/
struct Container<T> {
    let value: T
}
let intContainer = Container(value: 5) // T is Int
let stringContainer = Container(value: "hello") // T is String

//MARK: - 2. How do you define a generic type in Swift?
/*
 You define a generic type using the `<T>` syntax, where `T` is the placeholder for the type.

 Example:
  */
 struct GenericStruct<T> {
     let value: T
 }

//MARK: - 1. What is the difference between `Any` and `AnyObject` in Swift?
/*
`Any` is a type that can represent any type, including value types and reference types. `AnyObject` is a type that can only represent reference types.
Example:
```
 */

let any: Any = 5 // OK
let anyObject: AnyObject = 5 as AnyObject // Error: 5 is not an object
//MARK: - 4. How do you constrain a generic type to a specific protocol or superclass?
/*
You use the `where` clause to constrain a generic type.

Example:
``` */

struct Container1<T> where T: Equatable {
    let value: T
}


//MARK: -. What is the purpose of the `where` clause in a generic type constraint?
/*
The `where` clause allows you to specify additional constraints on the generic type.
Example:
 */
struct Container2<T> where T: Equatable & Comparable {
    let value: T
}

//MARK: - How do you create a generic function in Swift?
/*
You define a generic function using the `<T>` syntax.
Example:
 */
func genericFunction<T>(value: T) {
    print(value)
}
//MARK: - Can you explain the concept of type erasure in Swift generics?
/*
Type erasure is a technique to hide the type information of a generic type.
Example: */

struct AnyEquatable {
    let value: any Equatable
    init<T>(_ value: T) where T: Equatable {
        self.value = value
    }
}
//MARK: - How do you use associated types in a protocol?
/*
Associated types define a placeholder for a type that is associated with a protocol.
Example: */
protocol Container4 {
    associatedtype Element
    var elements: [Element] { get }
}
//MARK: -  What is the difference between a generic protocol and a non-generic protocol?
/*
A generic protocol defines a blueprint of types, while a non-generic protocol defines a blueprint of methods and properties.
Example:*/
protocol NonGenericProtocol {
    func doSomething()
}

protocol GenericProtocol {
    associatedtype T
    func doSomething(with value: T)
}


//MARK: -  Can you give an example of a generic data structure in Swift, such as a stack or queue?
//Example:

struct Stack<T> {
    var elements: [T] = []
    mutating func push(_ value: T) {
        elements.append(value)
    }
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    func showData() {
        print(elements)
    }
}

struct Queue<T> {
    var railwayTicketPeople: [T] = []
    mutating func push(_ value: T) {
        railwayTicketPeople.append(value)
    }
    mutating func pop(_ value: T) {
        railwayTicketPeople.removeFirst()
    }
    func showData() {
        print(railwayTicketPeople)
    }
}

//MARK: - Multiply two numbers
func multiply<M: Numeric>(a: M, b: M) -> M {
   return a*b
}

print("multiply Result: \(multiply(a: 13, b: 56.78)) \n")

//MARK: - Generic method to remove duplicate value from Array collection
extension Array where Element: Equatable {
    func removeDuplicateElements() -> [Element] {
        var items: [Element] = []
        self.forEach { item in
            if !items.contains(item) {
                items.append(item)
            }
        }
        return items
    }
}

let array: [Int] = [1,2,1,2,2,2,3,4,5,6,7,8,8,8,6,6,4]
print("Array with duplicate items \(array) \nwithout duplicate item \(array.removeDuplicateElements())")
//MARK: - Custom map method using generics
extension Array where Element: Equatable {
    func princeMap<T>(tranform: (Element) -> T) -> [T] {
        var result: [T] = []
        self.forEach { item in
            result.append(tranform(item))
        }
        return result
    }
}

print(array.princeMap(tranform: { $0 * $0 }))

//MARK: - Custom filter method using generics
extension Array where Element: Equatable {
    func princeFilter(isIncluded: (Element) -> Bool) -> [Element]  {
        var result: [Element] = []
        self.forEach { item in
            if isIncluded(item) {
                result.append(item)
            }
        }
        return result
    }
}

print(array.princeFilter(isIncluded: {$0 % 2 == 0}))

//MARK: - Custom contains method using generics
extension Array where Element: Equatable {
    func princeContains(whereItem: (Element) -> Bool) -> Bool  {
        var bool = false
        self.forEach { item in
            if whereItem(item) {
                bool = true
            }
        }
        return bool
    }
}

print(array.princeContains(whereItem: { $0 == 8}))
//MARK: - Custom Reduce method using generics
extension Array where Element: Equatable {
    func princeReduce<T>(initialValue: T, nextPartialValue: (T, Element) -> T) -> T {
        var result = initialValue
        self.forEach { item in
            result = nextPartialValue(result, item)
        }
        return result
    }
}
print(array.princeReduce(initialValue: 0, nextPartialValue: { $0 + $1}))
