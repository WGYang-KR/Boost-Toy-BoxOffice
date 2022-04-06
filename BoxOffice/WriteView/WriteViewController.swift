//
//  WriteViewController.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/06.
//

import UIKit

class WriteViewController: UIViewController {

    var movieDetail: MovieDetail!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    
        
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        movieNameLabel.text = movieDetail.title
        
        print("네비게이션바 커스터마이징 시작")
        navigationItem.title = "한줄평 작성"
        let completeBarButton: UIBarButtonItem = UIBarButtonItem(title: "완료", style: UIBarButtonItem.Style.done, target: self, action: #selector(touchUpCompleteBarButton(_:)))
        
        navigationItem.rightBarButtonItems = [completeBarButton]
        
       
    }

    @objc func touchUpCompleteBarButton(_ sender: UIBarButtonItem) {
            
        print("완료 버튼 클릭됨")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
