//
//  StarsTableViewController.swift
//  Stars
//
//  Created by scott harris on 1/28/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class StarsTableViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let starController = StarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    
    @IBAction func printStars(_ sender: Any) {
        
    }
    
    @IBAction func createStar(_ sender: Any) {
        // Create a new star, reload the table view to show it\
        guard let name = nameTextField.text,
            let distanceString = distanceTextField.text,
            let distance = Double(distanceString) else { return }
        
        starController.createStar(with: name, distance: distance)
        
        nameTextField.text = ""
        distanceTextField.text = ""
        
        tableView.reloadData()
        
        
    }
}


// :MARK TableView Data Source Extension
extension StarsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starController.stars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath)
        
        let star = starController.stars[indexPath.row]
        
        cell.textLabel?.text = star.name
        cell.detailTextLabel?.text = "\(star.distance) light years away"
        
        return cell
        
    }
    
    
}
