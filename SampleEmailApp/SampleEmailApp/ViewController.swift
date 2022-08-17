//
//  ViewController.swift
//  SampleEmailApp
//
//  Created by Mallesh Kurva on 16/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func validateEmail(_ sender: Any) {
        EmailViewModel.shared.validateEmailAddress(vc: self)
    }
    
}

