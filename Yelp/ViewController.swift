//
//  ViewController.swift
//  Yelp
//
//  Created by Shali Nguyen on 9/21/14.
//  Copyright (c) 2014 Shali Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    var results: [NSDictionary] = []
    
    let primaryColor = UIColor(red:0.95, green:0, blue:0, alpha:1.0)
    var client: YelpClient!
    var searchBar: UISearchBar!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Navigation controller color styles
        navigationController?.navigationBar.barTintColor = primaryColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.estimatedRowHeight = 110.00
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        navigationItem.titleView = self.searchBar
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
            
        loadData(term: "Restaurant")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = resultsTableView.dequeueReusableCellWithIdentifier("ResultCell") as ResultCell
        
        var result = results[indexPath.row]
        
        // var thumbnailDictionary = result["businesses"] as NSDictionary
        var thumbnailUrl = result["image_url"] as String
        var ratingsUrl = result["rating_img_url"] as String
        
        var locationDictionary = result["location"] as NSDictionary
        let address = locationDictionary["address"] as NSArray
        let city = locationDictionary["city"] as String
        
        let category = result["categories"] as NSArray
        let categoryResult: AnyObject! = category[0][0]
        
        // categoryResult.componentsJoinedByString(", ")
        
        let reviewCount = result["review_count"] as Int
        
        println(categoryResult)
        
        cell.nameLabel.text = result["name"] as? String
        cell.categoryLabel.text = categoryResult as? String
        cell.addressLabel.text = "\(address[0]), \(city)"
        cell.ratingsLabel.text = "\(reviewCount) reviews"
        cell.thumbnailView.setImageWithURL(NSURL(string: thumbnailUrl))
        cell.ratingsView.setImageWithURL(NSURL(string: ratingsUrl))
        
        return cell
    }
    
    func loadData(term: String = "") {
        
        client.searchWithTerm(term, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            self.results = (response as NSDictionary)["businesses"]! as [NSDictionary]
            self.resultsTableView.reloadData()
            println(self.results)
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            loadData(term: "Restaurant")
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        loadData(term: searchBar.text)
    }
    
    func filterViewControllerSearchButtonClicked(filterViewController: FilterViewController) {
        loadData(term: searchBar.text)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if segue.identifier == "detailView" {
            let selectedResult = self.results[self.resultsTableView.indexPathForSelectedRow()!.row]
            let detailView = segue.destinationViewController as DetailViewController
            
            detailView.result = selectedResult
        }
        
    }

    
    
}

