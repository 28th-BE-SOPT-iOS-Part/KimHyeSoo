//
//  HomeFriendTableViewCell.swift
//  KakaoTalk-Clone
//
//  Created by 김혜수 on 2021/05/05.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class HomeFriendTableViewCell: UITableViewCell {
    
    static let identifier : String = "HomeFriendTableViewCell"
    
    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
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
            profileImage.setImage(image, for: UIControl.State.normal)
            
        }
        nameLabel.text = name
        messageLabel.text = state
    }

}
