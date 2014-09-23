//
//  DetailViewController.swift
//  Yelp
//
//  Created by Shali Nguyen on 9/22/14.
//  Copyright (c) 2014 Shali Nguyen. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailRatingsLabel: UILabel!
    @IBOutlet weak var detailRatingsView: UIImageView!
    @IBOutlet weak var detailCategoriesLabel: UILabel!
    @IBOutlet weak var detailOpenLabel: UILabel!
    @IBOutlet weak var detailHoursLabel: UILabel!
    
    @IBOutlet weak var detailMapView: MKMapView!
    var locationManager = CLLocationManager()
    
    var result: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailTitle = result["name"] as String
        let reviewCount = result["review_count"] as Int
        var thumbnailUrl = result["image_url"] as String
        var ratingsUrl = result["rating_img_url"] as String
        var locationDictionary = result["location"] as NSDictionary
        let address = locationDictionary["address"] as NSArray
        let city = locationDictionary["city"] as String
        let category = result["categories"] as NSArray
        let categoryResult: AnyObject! = category[0][0]
        
        
        detailTitleLabel.text = detailTitle
        // detailCategoriesLabel.text = categoryResult
        detailRatingsLabel.text = "\(reviewCount) reviews"
        detailRatingsView.setImageWithURL(NSURL(string: ratingsUrl))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
