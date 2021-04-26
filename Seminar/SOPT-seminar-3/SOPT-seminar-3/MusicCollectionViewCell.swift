//
//  MusicCollectionViewCell.swift
//  SOPT-seminar-3
//
//  Created by 김혜수 on 2021/04/24.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    static let identifier : String = "MusicCollectionViewCell"
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setData(imageName : String,
                 title : String,
                 subtitle : String)
    {
        if let image = UIImage(named: imageName)
        {
            albumImageView.image = image
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

