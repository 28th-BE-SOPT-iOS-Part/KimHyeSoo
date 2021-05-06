//
//  EtcTabViewController.swift
//  KakaoTalk-Clone
//
//  Created by 김혜수 on 2021/05/06.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class EtcTabViewController: UIViewController {

    @IBOutlet weak var etcCollectionView: UICollectionView!

    private var etcIconList : [EtcLabelData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEtcIconList()
        etcCollectionView.delegate = self
        etcCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func setEtcIconList () {
        etcIconList.append(contentsOf: [
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "메일"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "캘린더"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "서랍"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "카카오콘"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "메이커스"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "선물하기"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "이모티콘"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "프렌즈"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "쇼핑하기"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "스타일"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "주문하기"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "멜론티켓"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "게임"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "멜론"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "헤어샵"),
            EtcLabelData(iconImageName: "messageTabIcon",
                         iconLabelName: "전체서비스")
    
        ])
    }
    

    

}

/* Cell 구성 -> delegate, dataSource*/
extension EtcTabViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return etcIconList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let etcCell = collectionView.dequeueReusableCell(withReuseIdentifier: EtcCollectionViewCell.identifier, for: indexPath) as? EtcCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        etcCell.setData(imageName: etcIconList[indexPath.row].iconImageName, labelName: etcIconList[indexPath.row].iconLabelName)
        
        return etcCell
    }
    
    
}

extension EtcTabViewController : UICollectionViewDelegate {
    
}


/* cell들의 간격/크기 -> flowLayout */
extension EtcTabViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        let cellWidth = width * (70/375)
        let cellHeight = cellWidth
        
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
       // let width = UIScreen.main.bounds.width
        
        return 19
    }
}
