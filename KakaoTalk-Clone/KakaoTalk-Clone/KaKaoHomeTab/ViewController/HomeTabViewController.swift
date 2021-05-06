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
    
    var nameNow : String = ""
    // var nowImageName : String = ""
    
    
    var friendList : [FriendListData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendListTableView.tableHeaderView = myTabHeaderView
        setFriendList()
        
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        friendListTableView.separatorStyle = .none
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFriendDetail"{
        //if segue.destination is MyTabViewController {
            let vc = segue.destination as? MyTabViewController
            //vc?.nameText = "왜안돼" // 여기에 cell 에 들어가는 name을 가져와 보자...
            //vc?.nameText = nameNow
            let cell = sender as! UITableViewCell
            let indexPath = friendListTableView.indexPath(for: cell)
            vc?.nameText = friendList[(indexPath?.row)!].name
            vc?.imageNameText = friendList[(indexPath?.row)!].imageName
            
        }
    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "편집", style: .default) { (action) in
            
        }
        let manageAction = UIAlertAction(title: "친구 관리", style: .default) { (action) in
            
        }
        let settingAllAction = UIAlertAction(title: "전체 설정", style: .default) { (action) in
            
        }
        alertController.addAction(editAction)
        alertController.addAction(manageAction)
        alertController.addAction(settingAllAction)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alertController, animated: false, completion: nil)
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
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let block = UIContextualAction(style: .normal, title: "차단") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            success(true)
        }
        block.backgroundColor = .systemRed
        
        
        let hide = UIContextualAction(style: .normal, title: "숨김") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Share 클릭 됨")
            success(true)
        }
        hide.backgroundColor = .systemGray
        
        //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions:[block, hide])
    }
    
    // cell 클릭한 효과 나타나자마자 사라지는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        nameNow = friendList[indexPath.row].name
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


