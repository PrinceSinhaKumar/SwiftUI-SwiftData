import UIKit

//MARK: - Using recursion

let array = [1,6,3,4,5,7,9]

func binarySearchUsingRecursion(arr: [Int], targetItem: Int, low: Int, high: Int) -> Int {
    if arr.isEmpty || low > high {
        return -1
    }
    let mid = (low + high)/2
    if arr[mid] == targetItem {
        return mid
    } else if arr[mid] < targetItem {
        return binarySearchUsingRecursion(arr: arr, targetItem: targetItem, low: mid + 1, high: high)
    } else {
        return binarySearchUsingRecursion(arr: arr, targetItem: targetItem, low: low, high: mid - 1)
    }
}

print("Binary search, Item find at index: \(binarySearchUsingRecursion(arr: array.sorted(), targetItem: 5, low: 0, high: array.count - 1))")
/*
 This function takes in a sorted array, a target value, and a range (low and high indices) to search within. It recursively divides the search space in half until it finds the target value or determines it's not present.

 Here's how it works:

 1. If the low index is greater than the high index, the target is not present, so return nil.
 2. Calculate the midpoint of the current range.
 3. If the midpoint element matches the target, return the midpoint index.
 4. If the midpoint element is less than the target, recursively search the right half of the range (mid + 1 to high).
 5. If the midpoint element is greater than the target, recursively search the left half of the range (low to mid - 1).

 Note that this implementation assumes the input array is sorted in ascending order. If the array is not sorted, the function may not work correctly.
 
 The time complexity of the binary search algorithm using recursion is O(log n), where n is the number of elements in the array.

 Here's why:

 1. With each recursive call, the search space is halved.
 2. The maximum number of recursive calls is equal to the number of times the search space can be halved until it reaches a single element.
 3. This is equivalent to the logarithm of the size of the array, base 2.

 To be more precise, the time complexity can be expressed as O(log2(n)), but it's commonly simplified to O(log n).

 Note that this is much faster than a linear search, which has a time complexity of O(n), especially for large datasets.

 Here's a rough estimate of the number of operations required for different sizes of arrays:

 - Array size 16: 4 operations (2^4)
 - Array size 128: 7 operations (2^7)
 - Array size 1024: 10 operations (2^10)
 - Array size 1048576: 20 operations (2^20)

 As you can see, the number of operations grows very slowly with the size of the array, making binary search a very efficient algorithm for searching large datasets.
 
 */
//MARK: - Using While loop

func binarySearchUsingWhileLoop(arr: [Int], targetItem: Int) -> Int {
    if arr.isEmpty {
        return -1
    }
    var low = 0
    var high = arr.count - 1
    while low < high {
        let mid = (high + low)/2
        if arr[mid] == targetItem {
            return mid
        } else if arr[mid] < targetItem {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return -1
}

print("Binary search using while loop: \(binarySearchUsingWhileLoop(arr: array.sorted(), targetItem: 56))")

/*
 The time complexity of binary search using a while loop is also O(log n), where n is the number of elements in the array.

 The while loop implementation of binary search works similarly to the recursive implementation:

 1. Initialize two pointers, low and high, to the start and end of the array.
 2. While the low pointer is less than or equal to the high pointer:
     - Calculate the midpoint of the range.
     - Compare the midpoint element to the target.
     - If the midpoint element matches the target, return the midpoint index.
     - If the midpoint element is less than the target, update the low pointer to midpoint + 1.
     - If the midpoint element is greater than the target, update the high pointer to midpoint - 1.
 3. If the loop exits without finding the target, return a failure indicator (e.g., -1).

 The number of iterations of the while loop is equal to the number of times the search space can be halved until it reaches a single element, which is logarithmic in the size of the array.

 To be more precise, the time complexity can be expressed as O(log2(n)), but it's commonly simplified to O(log n).

 The while loop implementation has the same time complexity as the recursive implementation because they both divide the search space in half with each iteration/recursive call.

 Here's a rough estimate of the number of operations required for different sizes of arrays:

 - Array size 16: 4 operations (2^4)
 - Array size 128: 7 operations (2^7)
 - Array size 1024: 10 operations (2^10)
 - Array size 1048576: 20 operations (2^20)

 As you can see, the number of operations grows very slowly with the size of the array, making binary search a very efficient algorithm for searching large datasets.
 */
