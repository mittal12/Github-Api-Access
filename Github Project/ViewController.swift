//
//  ViewController.swift
//  Github Project
//
//  Created by Ashish Mittal  on 28/04/17.
//  Copyright © 2017 Ashish Mittal . All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource , ManagerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var operationQueue: OperationQueue!
    var allRest: [User] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let manager: Manager = Manager()
        manager.delegate = self
        operationQueue = OperationQueue()
        operationQueue.addOperation(manager)
        self.title = "Home"
        self.tableView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allRest.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: TableCustomCell = tableView.dequeueReusableCell(withIdentifier: "TableCustomCell") as? TableCustomCell else{
            return UITableViewCell()
        }

        
        
        cell.PersonImage.imageURL = URL(string: (self.allRest[indexPath.row]).avatar_url!)
        
        cell.firstName.text = (self.allRest[indexPath.row]).name
        cell.secondName.text = (self.allRest[indexPath.row]).score
        cell.thirdName.text = (self.allRest[indexPath.row]).message
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    
    
    func commitsFetched(allRes: [User]) {
        operationQueue.cancelAllOperations()
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.allRest = allRes
            self.tableView.reloadData()
            self.tableView.isHidden = false
        })
        
    }


}

