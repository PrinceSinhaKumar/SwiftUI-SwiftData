//: [Previous](@previous)

import Foundation

//MARK: - Two sum problem

//TODO: - BrutForce solution using two loops
let array = [7,5,6,3,5,2,1,7,8,9]
let sum = 10
func brutForceTwoSum(array: [Int], sum: Int) -> String{
    var result: String = ""
    for i in 0..<array.count {
        for j in 0..<array.count where j != i {
            if array[i] + array[j] == sum {
                result.append("(\(array[i]), \(array[j])) ")
            }
        }
    }
    return result
}

//print("Two sum of \(sum) are: \(brutForceTwoSum(array: array, sum: sum))")
//Time complexity:O(n^2)

//TODO: - Using binary search

func twoSumBinarySearch(array: [Int], sum: Int) -> String {
    var result: String = ""
    for i in 0..<array.count {
        let compliment = sum - array[i]
        var tempArray = array
        tempArray.remove(at: i)
        if binarySearch(array: array, targetItem: compliment, low: 0, high: array.count - 1) {
            result.append("(\(array[i]), \(compliment)) ")
        }
    }
    return result
}

//print("Two sum of \(sum) are: \(twoSumBinarySearch(array: array.sorted(), sum: sum))")


func binarySearch(array: [Int], targetItem: Int, low: Int, high: Int) -> Bool {
    if low > high {
        return false
    }
    let mid = (low + high)/2
    if array[mid] == targetItem {
        return true
    } else if array[mid] < targetItem {
        return binarySearch(array: array, targetItem: targetItem, low: mid+1, high: high)
    } else {
        return binarySearch(array: array, targetItem: targetItem, low: low, high: mid - 1)
    }
}

//TODO: - Two sum using two pointers

func twoSumTwoPointer(array: [Int], sum: Int) -> String{
    var result = ""
    var lowerIndex = 0
    var higherIndex = array.count - 1
    
    while lowerIndex < higherIndex {
        let addSum = array[lowerIndex] + array[higherIndex]
        if addSum == sum {
            result.append("(\(array[lowerIndex]), \(array[higherIndex])) ")
            lowerIndex += 1
            higherIndex -= 1
        } else if addSum < sum {
            lowerIndex += 1
        } else if addSum > sum {
            higherIndex -= 1
        }
    }
    return result
}

print("Two sum of \(sum) are: \(twoSumTwoPointer(array: array.sorted(), sum: 10))")
