//
//  HomeMyTableViewCell.swift
//  KakaoTalk-Clone
//
//  Created by 김혜수 on 2021/05/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class HomeMyTableViewCell: UITableViewCell {
    
    static let identifier : String = "HomeFriendTableViewCell"

    
    @IBOutlet weak var myProfileImage: UIButton!
    @IBOutlet weak var myNameLabel: UILabel!
    
    @IBOutlet weak var myMessageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(imageName: String, name: String, state: String) {
        
        if let image = UIImage(named: imageName){
            myProfileImage.setImage(image, for: UIControl.State.normal)
            
        }
        myNameLabel.text = name
        myMessageLabel.text = state
    }

}
