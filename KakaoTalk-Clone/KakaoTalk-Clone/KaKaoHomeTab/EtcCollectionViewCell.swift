//
//  EtcCollectionViewCell.swift
//  KakaoTalk-Clone
//
//  Created by 김혜수 on 2021/05/06.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class EtcCollectionViewCell: UICollectionViewCell {
    
    static let identifier : String = "EtcCollectionViewCell"
    
    @IBOutlet weak var etcIcon: UIButton!
    @IBOutlet weak var etcLabel: UILabel!
    
    func setData(imageName : String, labelName: String) {
        
        if let image = UIImage(named: imageName){
            etcIcon.setImage(image, for: UIControl.State.normal)
            
        }
        etcLabel.text = labelName
    }
    
}
