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
    static var backgroundColor:String?
    
    @IBOutlet weak var totalcostlabel: UILabel!
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    static var damagelist: [Damage] = [Damage]()
    
    override func viewDidLoad() {
       
        if (AnalyzerViewController.backgroundColor != nil && AnalyzerViewController.backgroundColor != "nil" ) {
            self.view.backgroundColor = UIColor(hexString: AnalyzerViewController.backgroundColor!)
        }
              
        var cost:Int = 0
        for damage in AnalyzerViewController.damagelist {
             cost = cost + damage.cost
        }
        if (cost > 0) {
            totalcostlabel.text = "Total Cost : $" + String(cost)
        } else {
             totalcostlabel.text = ""
        }
       
        tableView.rowHeight = 84
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        var cost:Int = 0
        for damage in AnalyzerViewController.damagelist {
            cost = cost + damage.cost
        }
        if (cost > 0) {
            totalcostlabel.text = "Total Cost : $" + String(cost)
        } else {
            totalcostlabel.text = ""
        }
        super.viewWillAppear(animated)
    }
    
    @IBAction func submitReport(_ sender: Any) {
        let alert = UIAlertController(title: "Success", message: "Succesfully uploaded the report", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in
            // Reset Items
            self.totalcostlabel.text = ""
            AnalyzerViewController.damagelist.removeAll()
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnalyzerViewController.damagelist.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DamageViewCell
        // set the text from the data model
        cell.type.text =  AnalyzerViewController.damagelist[indexPath.row].type
        cell.cost.text = "$ " + String(AnalyzerViewController.damagelist[indexPath.row].cost)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
}


extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars = ["F","F"] + chars
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}
