//
//  SecondViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordOkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    func joinAction(){
        JoinService.shared.join(email: self.emailTextField.text!, password: self.passwordTextField.text!) { result in
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
    

    @IBAction func joinMemberButtonClicked(_ sender: Any) {
        
        
        
        self.makeRequestAlert(title: "알림",
        message: "회원가입을 하시겠습니까?",
        okAction: { _ in
          self.joinAction()
        })
        
//        // alert 창 설정
//        let alert = UIAlertController(title: "오류!", message: "아이디, 비밀번호, 비밀번호 확인을 모두 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//
//        }
//        alert.addAction(okAction)
//
//        // alert2 설정
//        let alert2 = UIAlertController(title: "오류!", message: "비밀번호와 비밀번호 확인이 서로 다릅니다.", preferredStyle: UIAlertController.Style.alert)
//        alert2.addAction(okAction)
//
//        let storyboard = UIStoryboard(name: "KakaoHome", bundle: nil)
//        guard let mainVC = storyboard.instantiateViewController(identifier: "MainTabBarController") as? MainTabBarController
//        else {return}
//
//        if emailTextField.text != "", passwordTextField.text != "", passwordOkTextField.text != "" {
//            // 모두 비어있지 않으면
//            if passwordTextField.text != passwordOkTextField.text {
//                present(alert2, animated: false, completion: nil)
//            }
//            else {
//            self.navigationController?.pushViewController(mainVC, animated: true)
//
//            }
//        }
//        else {
//             present(alert, animated: false, completion: nil)
//        }
    }
}

