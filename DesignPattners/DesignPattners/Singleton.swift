//
//  Singleton.swift
//  DesignPattners
//
//  Created by  Prince Shrivastav on 15/08/24.
//
/*
 What is Singleton? - Give a global access throught-out current life cycle
 How can we create Singleton? - by make class final, instance static and init private
 Is Singleton thread safe? - by default not
 How to make Singleton thread safe? - using synchronization machanisum like dispatch-queue
 Is Singleton bad? - Not in every case, but try avoid to use
 Which scenario we can consider for Singleton? - if singleton has only single resposibility
 */

import Foundation

final class Singleton {
    static let shared = Singleton()
    private init() {}
    
    func showSingletonType() {
        print("Normal singleton class")
    }
}
//MARK: - Make singleton thread safe using thread safe property like string, int, double etc, in this we are using String
final class SingletonWithOutThreadSafeUsingThreadSafeProperty {
    static let shared = SingletonWithOutThreadSafeUsingThreadSafeProperty()
    private init() {}
    var name: String = "A"
    
    func changeAndShowValueOfName(value: String) {
        let queue = DispatchQueue(label: "example.singleton.com")
        print("Before Value : \(name)")
        queue.sync {
            name = value
            print("After Value : \(name)")
        }
    }
}
//MARK: - Make singleton thread safe using not thread safe property like dictionary, array, set etc

final class SingletonWithOutThreadSafeUsingNotThreadSafeProperty {
    static let shared = SingletonWithOutThreadSafeUsingNotThreadSafeProperty()
    private init() {}
    var alphabetDictionary: [String: String] = [:]
    let queue = DispatchQueue(label: "example.singleton.com",attributes: .concurrent)

    func changeAndShowValueOfName(key: String ,value: String) {
        queue.async(flags: .barrier){
            self.alphabetDictionary[key] = value
            print(self.alphabetDictionary)
        }
    }
}
