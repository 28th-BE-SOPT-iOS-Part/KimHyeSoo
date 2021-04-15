//
//  FirstViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        guard let ThirdVC = self.storyboard?.instantiateViewController(identifier: "ThirdViewController")
        as? ThirdViewController else {return}
        
        if emailTextField.text != "", passwordTextField.text != "" {
            ThirdVC.name = emailTextField.text
            ThirdVC.modalPresentationStyle = .fullScreen
            self.present(ThirdVC, animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBAction func joinButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController")
            as? SecondViewController else {return}
        
        self.navigationController?
        .pushViewController(nextVC, animated: true)
        
    }
    
//    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
//
//    }
    
    

}
