//: [Previous](@previous)

import Foundation

//MARK: - Can you explain the concept of protocol-oriented programming in Swift? How do structs and classes fit into this?
/*
Protocol-oriented programming (POP) is a paradigm in Swift that emphasizes the use of protocols to define interfaces and behavior, rather than relying solely on classes and inheritance.

In POP, protocols define a set of methods, properties, and requirements that a type must conform to. Structs and classes can then adopt these protocols to implement the required behavior.

Here's a real project example:

Suppose you're building a social media app with various types of posts (e.g., text, image, video). You want to define a common interface for all post types to ensure they have certain properties and methods.
*/
//TODO: - Example 1
protocol Post {
    var id: Int { get }
    var content: String { get }
    func display()
}

struct TextPost: Post {
    let id: Int
    let content: String
    func display() {
        print("Text post: \(content)")
    }
}

class ImagePost: Post {
    let id: Int
    let content: String
    let imageUrl: URL
    func display() {
        print("Image post: \(content) - \(imageUrl)")
    }
}

class VideoPost: Post {
    let id: Int
    let content: String
    let videoUrl: URL
    func display() {
        print("Video post: \(content) - \(videoUrl)")
    }
}
/*
In this example:

- The `Post` protocol defines the common interface for all post types.
- The `TextPost` struct, `ImagePost` class, and `VideoPost` class adopt the `Post` protocol to implement the required properties and methods.
- Each type provides its own implementation of the `display()` method, specific to its needs.

By using protocols, you've achieved:

- Polymorphism: You can treat all post types as `Post` instances, without knowing their concrete type.
- Extensibility: New post types can be added by adopting the `Post` protocol, without modifying existing code.
- Flexibility: Structs and classes can be used interchangeably to implement the protocol.

This is just a simple example, but it demonstrates the power of protocol-oriented programming in Swift. By emphasizing protocols and interfaces, you can write more modular, reusable, and maintainable code.
*/
//TODO: - Example 2
/*
Here's an advanced example of protocol-oriented programming in Swift:

Suppose you're building a complex e-commerce app with various types of products (e.g., physical, digital, subscription-based). You want to define a common interface for all product types to ensure they have certain properties and methods, while also allowing for specific behavior and extensions
*/

// Define a base protocol for all products
protocol Product {
    var id: Int { get }
    var name: String { get }
    var price: Double { get }
    func calculateTax() -> Double
}

// Extend the Product protocol with specific requirements for physical products
protocol PhysicalProduct: Product {
    var weight: Double { get }
    var dimensions: (width: Double, height: Double, length: Double) { get }
    func calculateShippingCost() -> Double
}

// Extend the Product protocol with specific requirements for digital products
protocol DigitalProduct: Product {
    var fileSize: Double { get }
    var fileType: String { get }
    func download() -> Data
}

// Implement a physical product struct
struct Book: PhysicalProduct {
    let id: Int
    let name: String
    let price: Double
    let weight: Double
    let dimensions: (width: Double, height: Double, length: Double)
    func calculateTax() -> Double {
        return price * 0.08
    }
    func calculateShippingCost() -> Double {
        return weight * 0.5
    }
}

// Implement a digital product class
class Software: DigitalProduct {
    let id: Int
    let name: String
    let price: Double
    let fileSize: Double
    let fileType: String
    func calculateTax() -> Double {
        return price * 0.2
    }
    func download() -> Data {
        // Simulate downloading data
        return Data()
    }
}
// Create an array of products and iterate over them
let products: [Product] = [Book(id: 1, name: "Book", price: 20.0, weight: 1.0, dimensions: (10, 10, 10)), Software(id: 2, name: "Software", price: 50.0, fileSize: 100.0, fileType: "zip")]
for product in products {
    print("Product: \(product.name), Price: \(product.price), Tax: \(product.calculateTax())")
}

/*
 In this advanced example:

 - We define a base `Product` protocol with common requirements for all products.
 - We extend the `Product` protocol with specific requirements for physical and digital products using protocol inheritance.
 - We implement a physical product struct (`Book`) and a digital product class (`Software`) that adopt the respective protocols.
 - We create an array of products and iterate over them, treating all products as `Product` instances.

 This example demonstrates:

 - Protocol inheritance and extension
 - Polymorphism and type abstraction
 - Encapsulation and implementation hiding
 - Extensibility and flexibility

 By using protocol-oriented programming, we've achieved a more modular, reusable, and maintainable codebase that can accommodate various product types and behaviors.
 */
