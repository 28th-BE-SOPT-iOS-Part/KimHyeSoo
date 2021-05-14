//
//  FirstViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loginAction()
    {
        LoginService.shared.login(email: self.emailTextField.text!, password: self.passwordTextField.text!) { result in
            switch result
            {
            case .success(let message):
                let storyboard = UIStoryboard(name: "KakaoHome", bundle: nil)
                guard let mainVC = storyboard.instantiateViewController(identifier: "MainTabBarController") as? MainTabBarController
                        else {return}
                if let message = message as? String{
                    
                    self.makeAlert(title: "알림",
                                   message: message, okAction: { _ in self.navigationController?.pushViewController(mainVC, animated: true) } )

                }
                
            case .requestErr(let message):
            
                if let message = message as? String{
                    
                    self.makeAlert(title: "알림",
                              message: message)
                }
                           
                
            default :
                print("ERROR")
            }
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        self.makeRequestAlert(title: "알림",
        message: "로그인을 하시겠습니까?",
        okAction: { _ in
          self.loginAction()
        })
        
//        let storyboard = UIStoryboard(name: "KakaoHome", bundle: nil)
//        guard let mainVC = storyboard.instantiateViewController(identifier: "MainTabBarController") as? MainTabBarController
//                else {return}
        
        
//        LoginDataService.shared.getLoginInfo{ (response) in
//            switch(response)
//            {
//            case .success(let loginData):
//                if let data = loginData as? Login {
//                    // 알림띄우기?
//                    if data. {
//
//                    }
////                    self.nameLabel.text = data.name
////                    self.messageLabel.text = data.profileMessage
//                }
//            case .requestErr(let message) :
//                print("requestERR",message)
//            case .pathErr :
//                print("pathERR")
//            case .serverErr:
//                print("serverERR")
//            case .networkFail:
//                print("networkFail")
//            }
//        }
        
//        let storyboard = UIStoryboard(name: "KakaoHome", bundle: nil)
//
//        guard let mainVC = storyboard.instantiateViewController(identifier: "MainTabBarController") as? MainTabBarController
//        else {return}
//
//        if emailTextField.text != "", passwordTextField.text != "" {
//             self.navigationController?.pushViewController(mainVC, animated: true)
//        }
//        else {
//            let alert = UIAlertController(title: "오류!", message: "아이디와 비밀번호를 모두 입력해주세요", preferredStyle: UIAlertController.Style.alert)
//            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//
//            }
//            alert.addAction(okAction)
//            present(alert, animated: false, completion: nil)
//        }
        
//        guard let ThirdVC = self.storyboard?.instantiateViewController(identifier: "ThirdViewController")
//        as? ThirdViewController else {return}
//
//        if emailTextField.text != "", passwordTextField.text != "" {
//            ThirdVC.name = emailTextField.text
//            ThirdVC.modalPresentationStyle = .fullScreen
//            self.present(ThirdVC, animated: true, completion: nil)
//        }
        
        
        
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
