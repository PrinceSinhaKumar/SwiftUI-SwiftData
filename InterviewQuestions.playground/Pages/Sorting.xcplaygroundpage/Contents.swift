//: [Previous](@previous)

import Foundation

//MARK: - Insertion sort
/*
 Insertion sort is a simple sorting algorithm that works by dividing the input into a sorted and an unsorted region. Each subsequent element from the unsorted region is inserted into the sorted region in its correct position.

 Here's a step-by-step explanation of the insertion sort algorithm:

 1. Start with the first element, which is considered sorted.
 2. Take the next element from the unsorted region and compare it with the elements in the sorted region.
 3. Shift the elements in the sorted region to the right until you find the correct position for the new element.
 4. Insert the new element into the correct position.
 5. Repeat steps 2-4 until the entire array is sorted.

 Here's an example of how insertion sort works:

 Initial array: [5, 2, 8, 3, 1, 6, 4]

 Iteration 1:
 Sorted region: [5]
 Unsorted region: [2, 8, 3, 1, 6, 4]
 Insert 2 into sorted region: [2, 5]

 Iteration 2:
 Sorted region: [2, 5]
 Unsorted region: [8, 3, 1, 6, 4]
 Insert 8 into sorted region: [2, 5, 8]

 Iteration 3:
 Sorted region: [2, 5, 8]
 Unsorted region: [3, 1, 6, 4]
 Insert 3 into sorted region: [2, 3, 5, 8]

 Iteration 4:
 Sorted region: [2, 3, 5, 8]
 Unsorted region: [1, 6, 4]
 Insert 1 into sorted region: [1, 2, 3, 5, 8]

 Iteration 5:
 Sorted region: [1, 2, 3, 5, 8]
 Unsorted region: [6, 4]
 Insert 6 into sorted region: [1, 2, 3, 5, 6, 8]

 Iteration 6:
 Sorted region: [1, 2, 3, 5, 6, 8]
 Unsorted region: [4]
 Insert 4 into sorted region: [1, 2, 3, 4, 5, 6, 8]
 ```

 The final sorted array is: [1, 2, 3, 4, 5, 6, 8]

 Here's the insertion sort algorithm implemented in Swift:
 Note that insertion sort has a time complexity of O(n^2), making it less efficient than other sorting algorithms like quicksort or mergesort for large datasets. However, it can be useful for small datasets or for educational purposes.
 */
let array = [5, 2, 8, 3, 1, 6, 4]
func insertionSort(_ array: [Int]) -> [Int] {
    var sortedArray = array
    for i in 1..<sortedArray.count {
        let key = sortedArray[i]
        var j = i - 1
        while j >= 0 && sortedArray[j] > key {
            sortedArray[j + 1] = sortedArray[j]
            j -= 1
        }
        sortedArray[j + 1] = key
    }
    return sortedArray
}

print(insertionSort(array))
let array2 = [5, 2, 8, 3, 1, 6, 4]

//MARK: - Merge Sort
/*
 Merge sort is a popular sorting algorithm that uses a divide-and-conquer approach to sort an array of elements. Here's a step-by-step explanation of the merge sort algorithm:

 1. Divide the array into two halves until each subarray has only one element.
 2. Merge the subarrays by comparing elements from each subarray and placing the smaller element first.
 3. Repeat step 2 until all subarrays are merged into a single sorted array.

 Here's an example of how merge sort works:

 ```
 Initial array: [5, 2, 8, 3, 1, 6, 4]

 Divide:
 [5, 2, 8, 3] and [1, 6, 4]

 Divide again:
 [5, 2] and [8, 3] and [1, 6] and [4]

 Merge:
 [2, 5] and [3, 8] and [1, 6] and [4]

 Merge again:
 [2, 3, 5, 8] and [1, 4, 6]

 Final merge:
 [1, 2, 3, 4, 5, 6, 8]
 ```

 The final sorted array is: [1, 2, 3, 4, 5, 6, 8]

 Here's the merge sort algorithm implemented in Swift:

 Merge sort has a time complexity of O(n log n), making it a efficient sorting algorithm for large datasets.
 */
func mergeSort(array: [Int]) -> [Int] {
    if array.count <= 1 {
        return array
    }
    let mid = array.count/2
    let left = mergeSort(array: Array(array[0..<mid]))
    let right = mergeSort(array: Array(array[mid..<array.count]))
    return merge(left: left, right: right)
}

func merge(left: [Int], right: [Int]) -> [Int] {
    var result: [Int] = []
    var leftIndex = 0
    var rightIndex = 0
    
    while(leftIndex < left.count && rightIndex < right.count){
        if left[leftIndex] <= right[rightIndex] {
            result.append(left[leftIndex])
            leftIndex += 1
        } else {
            result.append(right[rightIndex])
            rightIndex += 1
        }
    }
    
    result.append(contentsOf: left[leftIndex..<left.count])
    result.append(contentsOf: right[rightIndex..<right.count])
    return result
}

print("Merge sort \(mergeSort(array: array2))")
