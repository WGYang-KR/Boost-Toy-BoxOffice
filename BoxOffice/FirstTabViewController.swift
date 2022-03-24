//
//  FirstTabViewController.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/03/24.
//

import UIKit

class FirstTabViewController: UIViewController, UITableViewDataSource {
    
    var orderType:Int = 0
    var movies: [Movie] = []
    let cellIdentifier = "firstTabTableCell"
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: FirstTabTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FirstTabTableViewCell else { fatalError()}
        
        cell.titleLabel.text = movies[indexPath.row].title
        cell.rateLabel.text = movies[indexPath.row].tableRateString
        cell.dateLabel.text = movies[indexPath.row].tableDateString
        if let emptyImage = generateEmptyUIImage(with: CGSize(width: 99, height: 141)) {
            cell.thumbImageView?.image = emptyImage
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecieveMoviesNotification(_:)), name: DidReceiveMoviesNotification, object: nil)
        
        requestMovies(orderType: 0)
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
