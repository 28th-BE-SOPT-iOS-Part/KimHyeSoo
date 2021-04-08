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
        
        let alert = UIAlertController(title: "오류!", message: "비밀번호와 비밀번호 확인이 다릅니다. 다시 입력해주세요", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okAction)
        
        guard let ThirdVC = self.storyboard?.instantiateViewController(identifier: "ThirdViewController")
            as? ThirdViewController else { return}
        
        if emailTextField.text != "", passwordTextField.text != "", passwordOkTextField.text != "" {
            if passwordTextField.text != passwordOkTextField.text {
                present(alert, animated: false, completion: nil)
            }
            ThirdVC.name = emailTextField.text
            
            ThirdVC.modalPresentationStyle = .fullScreen
            self.present(ThirdVC,animated: true, completion: nil)
            
        }
        
        
    }
    

}
