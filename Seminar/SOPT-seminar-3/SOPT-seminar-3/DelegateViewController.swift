//
//  DelegateViewController.swift
//  SOPT-seminar-3
//
//  Created by 김혜수 on 2021/04/24.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

protocol SampleProtocol {
    
  //  func dataSend(data : String)
}


class DelegateViewController: UIViewController {

    @IBOutlet weak var dataTextField: UITextField!
    
    var delegate : SampleProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func dataSendButtonClicked(_ sender: Any) {
        if let text = dataTextField.text {
            NotificationCenter.default.post(name: NSNotification.Name("sample"), object: text)
 //           delegate?.dataSend(data: text)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
