//
//  JoinDataModel.swift
//  KakaoTalk-Clone
//
//  Created by 김혜수 on 2021/05/14.
//  Copyright © 2021 kimhyesu. All rights reserved.
//

import Foundation

// MARK: - JoinDataModel
struct JoinDataModel: Codable {
    let success: Bool
    let message: String
    let data: Join?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
    
    init(from decoder : Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(Join.self, forKey: .data)) ?? nil
    }
}

// MARK: - DataClass
struct Join: Codable {
    let nickname: String
}
