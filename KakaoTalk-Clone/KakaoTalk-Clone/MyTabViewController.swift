//
//  MyTabViewController.swift
//  Assignment-week1
//
//  Created by 김혜수 on 2021/04/22.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import UIKit

class MyTabViewController: UIViewController {

    @IBOutlet var modalView: UIView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

        
    // 다시 올라가는걸,, 해결하지 목했어요 아직,, 조금만 내리면,, 다시 올라가질 않네요,,? ,,, ?,,,, 중간고사가 끝나자마자 다시 연구를 해보겠습니다,,
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        
        
        let transition = panGestureRecognizer.translation(in: modalView)
        if transition.y > 0 { // 위쪽으로 swipe 막기..
            let changedY = modalView.center.y + transition.y
            modalView.center = CGPoint(x: modalView.center.x, y:changedY)
        }
            
            panGestureRecognizer.setTranslation(CGPoint.zero, in: modalView)
            
           // let velocity = panGestureRecognizer.velocity(in: modalView) -> 어디로 이동하는지 알기위해서,,
//
//            if abs(velocity.x) > abs(velocity.y){
//                velocity.x<0 ? print("left"): print("right")
//            }
//            else if abs(velocity.y) > abs(velocity.x){
//                velocity.y<0 ? print("up"):  print("down", modalView.frame.origin.y, modalView.center.y)
//                }
    
            if modalView.frame.origin.y > 300 {
                self.dismiss(animated: true, completion: nil)
            }
            
    }
    
   
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

