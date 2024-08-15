//
//  ViewController.swift
//  DesignPattners
//
//  Created by  Prince Shrivastav on 15/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        showStatusOfPattern()
    }
    
    func showStatusOfPattern() {
        Singleton.shared.showSingletonType() // Simple
        for value in Unicode.Scalar("B").value...Unicode.Scalar("Z").value {
            if let val = Unicode.Scalar(value) {
                SingletonWithOutThreadSafeUsingThreadSafeProperty.shared.changeAndShowValueOfName(value: val.description)
            }
        }
        for value in Unicode.Scalar("A").value...Unicode.Scalar("Z").value {
            if let val = Unicode.Scalar(value) {
                SingletonWithOutThreadSafeUsingNotThreadSafeProperty.shared.changeAndShowValueOfName(key: value.description, value: val.description)
            }
        }
    }
    
}

