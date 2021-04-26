//
//  TextFieldDelegateViewController.swift
//  SOPT-seminar-3
//
//  Created by 김혜수 on 2021/04/24.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class TextFieldDelegateViewController: UIViewController {

    @IBOutlet weak var sampleTextField: UITextField!
    @IBOutlet weak var sampleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleTextField.delegate = self
        
    }
    

    

}

//enter누르면,, 전달~
extension TextFieldDelegateViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        sampleLabel.text = sampleTextField.text
        return true
    }
    
}
