//
//  HomeTabViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/22.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {


    @IBOutlet weak var myTabHeaderView: UIView!
    @IBOutlet weak var friendListTableView: UITableView!
    
    
    
    var friendList : [FriendListData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendListTableView.tableHeaderView = myTabHeaderView
        setFriendList()
        
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        friendListTableView.separatorStyle = .none
        
    }
    
   
    // 추후 ViewController에서
    // private var friendList:[FriendDataModel] = []
    // 로 선언한 다음에 사용하세요!!!

    func setFriendList()
        {
            friendList.append(contentsOf: [
                FriendListData(imageName: "profileImage1",
                               name: "안솝트",
                               state: "배고파요"),
                
                FriendListData(imageName: "profileImage2",
                                name: "최솝트",
                                state: "피곤해요"),
                
                FriendListData(imageName: "profileImage3",
                                name: "정솝트",
                                state: "시험언제끝나죠?"),
                
                FriendListData(imageName: "profileImage4",
                                name: "이솝트",
                                state: "ㅠㅠㅠㅠ"),
                
                FriendListData (imageName: "profileImage5",
                                name: "유솝트",
                                state: "나는 상태메세지!"),
                
                FriendListData (imageName: "profileImage6",
                                name: "박솝트",
                                state: "원하는대로 바꿔보세요 ^_^"),
                
                FriendListData(imageName: "profileImage7",
                                name: "최솝트",
                                state: "넘 덥다.."),
                
                FriendListData (imageName: "profileImage8",
                                name: "원솝트",
                                state: "배고파요"),
                
                FriendListData (imageName: "profileImage9",
                                name: "투솝트",
                                state: "내꿈은 대나무부자"),
                
                FriendListData (imageName: "profileImage10",
                                name: "권솝트",
                                state: "걱정말라구!")
                
                
                
            ])
        }
    
    
    

}

extension HomeTabViewController  : UITableViewDelegate {
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath)->CGFloat {
        return 50
    }
}

extension HomeTabViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    
   
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let friendCell = tableView.dequeueReusableCell(withIdentifier: HomeFriendTableViewCell.identifier, for: indexPath) as? HomeFriendTableViewCell else { return UITableViewCell() }
        
       
        friendCell.setData(
            imageName: friendList[indexPath.row].imageName,
            name: friendList[indexPath.row].name,
            state:friendList[indexPath.row].state
        )
        
        return friendCell
        
    }
    
    
}


