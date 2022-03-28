//
//  SettingInfo.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/28.
//

import Foundation

enum OrderType: Int {
    case reservationRate
    case curation
    case date
}

func orderTypeDescription(_ orderType :OrderType) -> String {
    switch orderType {
    case .reservationRate:
        return "예매율순"
    case .curation:
        return "추천순"
    case .date:
        return "개봉일순"
    }
}

class SettingInfo {
    static let shared: SettingInfo = SettingInfo()
    
    private init() {
            print("SettingInfo inited")
    }
    
    var orderType: OrderType = .reservationRate
    var userName: String?
}
