//
//  FirstTabViewController.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/24.
//

import UIKit

class FirstTabViewController: UIViewController, UITableViewDataSource {
    
    var movies: [Movie] = []
    let cellIdentifier = "firstTabTableCell"
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: FirstTabTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FirstTabTableViewCell else { fatalError()}
        
        cell.titleLabel.text = movies[indexPath.row].title
        cell.rateLabel.text = movies[indexPath.row].tableRateString
        cell.dateLabel.text = movies[indexPath.row].tableDateString
        if let emptyImage = generateEmptyUIImage(with: CGSize(width: 100, height: 140)) {
            cell.thumbImageView?.image = emptyImage
        }
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: self.movies[indexPath.row].thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                if let index:IndexPath = self.tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {

                        cell.thumbImageView?.image = UIImage(data: imageData)
                    }
                }
            }
                    
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    @objc func didRecieveMoviesNotification(_ noti: Notification)
    {
        guard let movies: [Movie] =  noti.userInfo?["movies"] as? [Movie] else {return}
        
        self.movies = movies
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        self.tableView.contentInset = UIEdgeInsets.zero
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecieveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)
        
        let currentOrderType = SettingInfo.shared.orderType
        requestMovies(orderType: currentOrderType.rawValue)
        self.navigationItem.title = orderTypeDescription(currentOrderType)
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
