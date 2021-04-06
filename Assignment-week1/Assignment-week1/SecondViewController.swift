//
//  SecondViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordOkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    

    @IBAction func joinMemberButtonClicked(_ sender: Any) {
        
        guard let ThirdVC = self.storyboard?.instantiateViewController(identifier: "ThirdViewController")
            as? ThirdViewController else { return}
        
        if emailTextField.text != "", passwordTextField.text != "", passwordOkTextField.text != "" {
            
            ThirdVC.name = emailTextField.text
            
            ThirdVC.modalPresentationStyle = .fullScreen
            self.present(ThirdVC,animated: true, completion: nil)
            
        }
        
        
    }
    

}
