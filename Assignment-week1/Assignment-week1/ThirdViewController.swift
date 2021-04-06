//
//  ThirdViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var name : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNameLabel()
       
    }
    
    func setNameLabel(){
        if let n = self.name{
            nameLabel.text = "\(n)님"
        }
    }
    

    @IBAction func okButtonClicked(_ sender: Any) {
        // 돌아가기
       
       // self.dismiss(animated: true, completion: nil)
       
        
    }
    

}

