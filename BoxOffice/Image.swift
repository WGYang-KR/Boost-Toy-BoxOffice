//
//  Image.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/24.
//

import Foundation
import UIKit

func generateEmptyUIImage(with size: CGSize) -> UIImage? {
    
    UIGraphicsBeginImageContext(size)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
        print("빈 이미지 생성 실패")
        return nil
    }
    UIGraphicsEndImageContext()
    return image
}
