//
//  FilterViewController.swift
//  Yelp
//
//  Created by Shali Nguyen on 9/21/14.
//  Copyright (c) 2014 Shali Nguyen. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func filterViewControllerSearchButtonClicked(filterViewController: FilterViewController)
}

enum FilterType {
    case Toggle
    case Select
}

struct filterSection {
    var title: String
    var type: FilterType
    var settings: Array<String>
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    var delegate: FilterViewControllerDelegate!
    var isExpanded: [Int: Bool] = [Int: Bool]()
    
    let filterSettings = [
        filterSection(title: "Most Popular", type: FilterType.Toggle, settings: ["Open Now", "Hot & New", "Offering a Deal", "Delivery"]),
        filterSection(title: "Distance", type: FilterType.Select, settings: ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"]),
        filterSection(title: "Sort by", type: FilterType.Select, settings: ["Best Match", "Distance", "Highest Rated"])
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cellForFilterTypeAtIndexPath(filterType: FilterType, indexPath: NSIndexPath) -> FilterCell {
        let cell = filterTableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
        switch (filterType) {
            case FilterType.Toggle:
                break
            case FilterType.Select:
                break
        }
        return cell
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let filterSection = filterSettings[indexPath.section]
        let cell = cellForFilterTypeAtIndexPath(filterSection.type, indexPath: indexPath)
        cell.filterLabel.text = filterSection.settings[indexPath.row]
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5.0
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        
        var label = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 20))
        label.font = UIFont.systemFontOfSize(15)
        label.text = filterSettings[section].title
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("selected")
        
        if (isExpanded[indexPath.section]) != nil {
            isExpanded[indexPath.section] = !isExpanded[indexPath.section]!
        } else {
            isExpanded[indexPath.section] = false
        }
        
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterSettings.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isExpanded[section]) != nil {
            if (isExpanded[section]!) {
                return filterSettings[section].settings.count
            } else {
                return 1
            }
        } else {
            return filterSettings[section].settings.count
        }
    }
    
    
    @IBAction func searchBtn(sender: AnyObject) {
        delegate.filterViewControllerSearchButtonClicked(self)
        navigationController?.popViewControllerAnimated(true)
    }
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
