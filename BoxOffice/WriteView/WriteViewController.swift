//
//  WriteViewController.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/06.
//

import UIKit

class WriteViewController: UIViewController {

    var movieDetail: MovieDetail!
    var sliderStarRating: StarRatingUISlider!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        //StarRating과 크기 같게
        sliderStarRating.frame = self.starRatingView.frame
        //sliderStarRating.bounds = self.starRatingView.bounds
        print("vieDidLayout slider: \(sliderStarRating.frame)\nstarRatingView:\(self.starRatingView.frame)")
    }
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
        
        
        //평점 초기값 설정.
       
        self.rateLabel.text = String(format:"%.1f",self.movieDetail.user_rating)
        reloadStarRatingView()
        
        //슬라이더 별점 위에 추가
        sliderStarRating = StarRatingUISlider()
        
        //숨기기
        sliderStarRating.minimumTrackTintColor = .clear
        sliderStarRating.maximumTrackTintColor = .clear
        sliderStarRating.thumbTintColor = .clear
        //최대, 최소, 초기값
        sliderStarRating.maximumValue = 10
        sliderStarRating.minimumValue = 0
        sliderStarRating.value = Float(self.movieDetail.user_rating)
        //action연결
        sliderStarRating.addTarget(self, action: #selector(sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
    
        //별 이미지 뷰 위로 추가
        self.view.insertSubview(sliderStarRating, aboveSubview: self.starRatingView )
        print("viewDidLoad::\nslider: \(sliderStarRating.frame)\nstarRatingView:\(self.starRatingView.frame)")
        
        
        
       
    }

    @IBAction func sliderValueChanged(_ sender: StarRatingUISlider) {
        print("slider value changed")
        self.rateLabel.text = String(format:"%.1f",sender.value)
        reloadStarRatingView()
    }
    
    func reloadStarRatingView() {
        if let newRate = Double(self.rateLabel.text ?? "") {
            self.starRatingView.setupStarRating(rating: newRate)
        }
    }

    @objc func touchUpCompleteBarButton(_ sender: UIBarButtonItem) {
        print("완료 버튼 클릭됨")
        
        //보낼 데이터
        let commentToPost: CommentToPost = CommentToPost(rating: Double(rateLabel.text ?? "0") ?? 0, writer: userNameTextField.text ?? "_", movieID: movieDetail.id, contents: commentTextField.text ?? "_")
        
        //세션통해 전송
        postComment(commentToPost) { isSuccess in
            
            if isSuccess {
                print("전송완료")
            } else {
                print("전송실패")
            }
            
            DispatchQueue.main.async {
                self.alertUploadStatus(isSuccess)
            }
        }
    }

    func alertUploadStatus(_ status: Bool) {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        let okSuccessAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            print("네비게이션 pop")
            self.navigationController?.popViewController(animated: true)
        }
        let okFailAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            print("화면 유지")
        }
        if status {
            alertController.title = "전송 성공"
            alertController.message = "한줄평 등록 성공"
            alertController.addAction(okSuccessAlertAction)
        } else {
            alertController.title = "전송 실패"
            alertController.message = "한줄평 등록 실패"
            alertController.addAction(okFailAlertAction)
        }
        self.present(alertController, animated: true)
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
