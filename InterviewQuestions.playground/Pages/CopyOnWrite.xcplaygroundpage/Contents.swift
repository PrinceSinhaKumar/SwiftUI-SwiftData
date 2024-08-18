//: [Previous](@previous)

import Foundation
import UIKit
/*
 Copy-on-write is a optimization technique used in Swift to improve performance when working with value types (such as structs) that contain mutable state.

 When you assign a value type to a new variable or constant, Swift creates a copy of the original value. However, if the value type contains mutable state (such as an array or dictionary), Swift uses a technique called "copy-on-write" to optimize the copying process.

 Here's how it works:

 1. When you assign a value type to a new variable or constant, Swift checks if the original value has any mutable state.
 2. If the original value has no mutable state, Swift creates a simple copy of the value.
 3. If the original value has mutable state, Swift creates a new copy of the value, but it also keeps a reference to the original value's mutable state.
 4. When you modify the mutable state of the new copy, Swift creates a new copy of the mutable state, and updates the new copy to reference the new mutable state.

 This approach avoids unnecessary copying of mutable state, which can improve performance.

 Here's an example:
 ```
 */

//MARK: - Note copy on write works for collection object, like array , dict etc, In the below example, it works for friends list array

struct Person {
    var name: String
    var friends: [String]
}

var person1 = Person(name: "John", friends: ["Alice", "Bob"])
var person2 = person1 // Swift uses copy-on-write here


print(UnsafePointer(&person1)) // prints the address of person1
print(UnsafePointer(&person2)) // prints the address of person2

print(UnsafePointer(&person1.friends)) // prints the address of person1's friends array
print(UnsafePointer(&person2.friends)) // prints the address of person2's friends array

person2.friends.append("Charlie") // Swift creates a new copy of the friends array here

/*
 In this example, when we assign `person1` to `person2`, Swift uses copy-on-write to create a new copy of the `Person` struct, but it keeps a reference to the original `friends` array. When we modify the `friends` array in `person2`, Swift creates a new copy of the array and updates `person2` to reference the new array.

 Note that copy-on-write only applies to value types that contain mutable state. If the value type only contains immutable state, Swift will always create a simple copy.

These are the memory addresses of `person1` and `person2`, respectively.

Also, keep in mind that the addresses may change each time you run the program, since the memory layout can vary.

Now, let's print the addresses of the `friends` arrays:
 
 ```
 You'll see that initially, both `person1` and `person2` share the same `friends` array address, since Swift uses copy-on-write. However, when you modify `person2.friends`, Swift creates a new copy of the array, and you'll see a different address for `person2.friends`.

```
 */
print(UnsafePointer(&person1.friends)) // prints the address of person1's friends array
print(UnsafePointer(&person2.friends)) // prints the address of person2's friends array
