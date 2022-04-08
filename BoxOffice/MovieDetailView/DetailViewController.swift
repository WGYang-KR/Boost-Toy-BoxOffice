//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/24.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var movieID: String!
    var movieDetail: MovieDetail? = nil
    var comments: [Comment] = []
    let detailCellIdentifier = "detailCell"
    let commentCellIdentifier = "commentCell"
    @IBOutlet weak var tableView: UITableView!
    
    //영화 썸네일 가로 사이즈
    let thumbSize: CGFloat = UIScreen.main.bounds.width/3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //자체적으로 asnc로 진행되는 지 확인.
        print("viewDidLoad에서 requestMovieDetail 호출 시작")
        requestMovieDetail(movieID) { detail in
            if let detail = detail {
                print("requestMovieDetail completion() 시작.")
                self.movieDetail = detail
                DispatchQueue.main.async {
                    print("#reloadSection 0 Start")
                    print("comments.count: \(self.comments.count)")
                    self.tableView.reloadSections(IndexSet(0...0), with: .none)
                    print("#reloadSection 0 End")
                    print("comments.count: \(self.comments.count)")
                }
                print("requestMovieDetail completion() 끝.")
            }
        }
        print("viewDidLoad에서 requestMovieDetail 호출 끝")
        
      refreshComments()
    }
    
    func refreshComments() {
        requestComments(self.movieID) {
            comments in
            DispatchQueue.main.async {
                self.comments = comments //section 0 변경중 변경되면 error 발생-> dispatchQueue에서 진행
                print("reloadSection 1 Start")
                print("comments.count: \(comments.count)")
                self.tableView.reloadSections(IndexSet(1...1), with: .none)
                print("reloadSection 1 End")
                print("comments.count: \(comments.count)")
            }
            print("Comments loading completed")
        }
    }
    
    //MARK: 한줄평 헤더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40)
                            )
            headerView.backgroundColor = UIColor.white
            
            let title = UILabel()
            title.frame = CGRect(x: self.view.bounds.width * 0.02, y: 0, width: 100, height: 40)
            title.font = UIFont.systemFont(ofSize: 19.0)
            title.textColor = .black
            title.text = "한줄평"
            
            let image = UIImage(named: "btn_compose")
            let imgView = UIImageView(image: image)
            imgView.frame = CGRect(x: self.view.bounds.width * 0.9, y: 0, width: 25, height: 25)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpInsideWirteComment(_:)))
            imgView.isUserInteractionEnabled = true
            imgView.addGestureRecognizer(tapRecognizer)
            
            headerView.addSubview(title)
            headerView.addSubview(imgView)
            
            
            return headerView
        }
        
        return nil
    }
    
    @objc func touchUpInsideWirteComment(_ sender: UIImageView)
    {
          
        //MARK: Push WriteViewController
        let nextVC = WriteViewController()
        nextVC.movieDetail = self.movieDetail
        nextVC.callBack = {
            self.refreshComments()
        }
        navigationItem.backButtonTitle = "뒤로"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        case 1: return UITableView.automaticDimension
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            print("numberOfRowsInSection 0")
            return 1
        case 1:
            print("numberOfRowsInSection 1")
            print("comments.count: \(comments.count)")
            return self.comments.count

        default:
            print("numberOfRowsInSection default")
            return 0
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as?  DetailTableViewCell else { fatalError("The dequeued cell is not an instance of DetailCell.") }

            cell.titleLabel.text = movieDetail?.title
            //cell.gradeImageView
            cell.detailLabel.text = movieDetail?.date
            cell.genreDurationLabel.text = movieDetail?.genreDurationDescription
            cell.reservationRateLabel.text = movieDetail?.reservationRateDescription
            cell.userRatingLabel.text = movieDetail?.userRatingDescription
            //cell.starRatingView
            cell.audienceLabel.text = movieDetail?.audienceDescription
            cell.synopsisLabel.text = movieDetail?.synopsis
            cell.directorLabel.text = movieDetail?.director
            cell.actorLabel.text = movieDetail?.actor
            if let starRate = movieDetail?.user_rating {
                cell.starRatingView.setupStarRating(rating: starRate)
                
            }
            DispatchQueue.global().async {
            
                guard let movieDetailImageURL = self.movieDetail?.image else {
                    return
                }
                guard let imageURL: URL = URL(string: movieDetailImageURL) else { return }
                guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                //일정한 크기로 조정
                
                DispatchQueue.main.async {
                    if let index = self.tableView.indexPath(for: cell) {
                        if index.row == indexPath.row {
                            cell.thumbImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            return cell
            
        case 1:
            guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as? CommentTableViewCell else {
                fatalError("The dequeued cell is not an instance of CommentTableViewCell.")
            }

            cell.userNameLabel.text = comments[indexPath.row].writer
            cell.contentsLabel.text = comments[indexPath.row].contents
            cell.dateTimeLabel.text = comments[indexPath.row].dateTimeDescription
            cell.starRatingView.setupStarRating(rating: comments[indexPath.row].rating )
        
            return cell

        default:
            fatalError("The IndexPath is not 0 or 1.")
        }
      
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
