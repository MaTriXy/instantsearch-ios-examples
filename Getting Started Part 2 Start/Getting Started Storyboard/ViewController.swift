//
//  ViewController.swift
//  Getting Started Storyboard
//
//  Created by Guy Daher on 01/06/2017.
//  Copyright © 2017 Guy Daher. All rights reserved.
//

import UIKit
import InstantSearch

class ViewController: HitsTableViewController {

    @IBOutlet weak var tableView: HitsTableWidget!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hitsTableView = tableView
        
        InstantSearch.shared.registerAllWidgets(in: self.view)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hitCell", for: indexPath)
        
        cell.textLabel?.text = hit["name"] as? String
        cell.detailTextLabel?.text = String(hit["salePrice"] as! Double)
        
        return cell
    }

  func viewForNoResults(in tableView: UITableView) -> UIView {
    let v = UIView()
    v.backgroundColor = .red
    return v
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

