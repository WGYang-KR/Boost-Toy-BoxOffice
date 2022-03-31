//
//  SettingInfo.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/28.
//  테이블뷰와 콜렉션뷰의 정렬방식을 통일하기 위해 필요

import Foundation


class SettingInfo {
    static let shared: SettingInfo = SettingInfo()
    
    private init() {
            print("SettingInfo inited")
    }
    
    var orderType: OrderType = .reservationRate
    var userName: String?
}
