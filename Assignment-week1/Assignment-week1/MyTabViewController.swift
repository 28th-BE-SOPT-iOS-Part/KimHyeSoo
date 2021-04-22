//
//  MyTabViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/22.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class MyTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
