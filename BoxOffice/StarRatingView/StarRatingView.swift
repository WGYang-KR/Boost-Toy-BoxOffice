//
//  StarRatingView.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/01.
//

import UIKit

class StarRatingView: UIView {

    weak var containerView: UIView?
    
    @IBOutlet var stars: [UIImageView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitializer()
        resetStarRating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInitializer()
        resetStarRating()
     
    }
    
    private func commonInitializer() {
        containerView = Bundle.main.loadNibNamed("StarRatingView", owner: self, options: nil)?.first as? UIView
        
        guard let containerView = containerView else {
            return
        }
        
        containerView.frame = self.bounds
        self.addSubview(containerView)
    }
    
    
    func resetStarRating() {
        for i in 0..<5 {
            stars[i].image = UIImage(named: "ic_star_large")
        }
    }
    
    func setupStarRating(rating: Double) {
        
        let fullStarNum = Int(rating / 2)
        let remainder = rating.truncatingRemainder(dividingBy: 2)
        var halfStarNum = 0
        
        if remainder >= 0 && remainder < 1 {
            halfStarNum = 0
        } else if remainder >= 1 && remainder < 2 {
            halfStarNum = 1
        }
        
        for i in 0..<5 {
            stars[i].image = UIImage(named:"ic_star_large")
        }
        
        //꽉찬 별 채움
        for i in 0..<fullStarNum {
            stars[i].image = UIImage(named:"ic_star_large_full")
        }
        
        //반쪽별 채움
        if halfStarNum == 1 {
            stars[fullStarNum].image = UIImage(named:"ic_star_large_half")
        } 
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
