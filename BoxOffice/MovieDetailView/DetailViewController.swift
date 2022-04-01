//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/24.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var movieID: String!
    var movieDetail: MovieDetail?
    var comments: [Comment] = []
    let detailCellIdentifier = "detailCell"
    let commentCellIdentifier = "commentCell"
    @IBOutlet weak var tableView: UITableView!
    
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
                    self.tableView.reloadSections(IndexSet(0...0), with: .none)
                }
                print("requestMovieDetail completion() 끝.")
            }
        }
        print("viewDidLoad에서 requestMovieDetail 호출 끝")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        case 1: return 150
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return self.comments.count
        default: return 0
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            print("첫째 섹션 셀 업데이트.")
            guard let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as?  DetailTableViewCell else { fatalError("The dequeued cell is not an instance of DetailCell.") }
            cell.titleLabel.text = movieDetail?.title
            //cell.gradeImageView
            cell.detailLabel.text = movieDetail?.date
            //cell.genreDurationLabel.text = movieDetail?
            //cell.reservationRateLabel = movieDetail?.reservation_rate
            //cell.userRatingLabel
            //cell.starRatingView
            //cell.audienceLabel
            //cell.synopsisTextField
            //cell.directorLabel
            //cell.actorLabel.text = movieDetail?.
            
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
