//
//  NetworkResult.swift
//  KakaoTalk-Clone
//
//  Created by 김혜수 on 2021/05/12.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
