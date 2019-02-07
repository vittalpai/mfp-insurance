//
//  AnalyzerViewController.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 07/02/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import UIKit

class AnalyzerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "prototype"
    
    @IBOutlet weak var totalcostlabel: UILabel!
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    static var damagelist: [Damage] = [Damage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalcostlabel.text = ""
        tableView.rowHeight = 84
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func submitReport(_ sender: Any) {
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DamageViewCell
        
        // set the text from the data model
        cell.type.text = "Windshield Broken"
        cell.cost.text = "$ 35,000"
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
}
