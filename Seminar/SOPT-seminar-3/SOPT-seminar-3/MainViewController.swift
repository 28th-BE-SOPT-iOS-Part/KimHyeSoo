//
//  MainViewController.swift
//  SOPT-seminar-3
//
//  Created by 김혜수 on 2021/04/24.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SampleProtocol {
    
    

    @IBOutlet weak var dataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func dataSend(data: String) {
        dataLabel.text = data
    }
    

   
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DelegateViewController") as? DelegateViewController else { return }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived), name: NSNotification.Name("sample"), object: nil)
        
       // nextVC.delegate = self
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func dataReceived(notification : NSNotification){
        if let text = notification.object as? String {
            dataLabel.text = text
        }
    }
    
}
