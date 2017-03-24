//
//  SubContentsViewController.swift
//  GatorRenter
//
//  Created by fdai4856 on 15/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

class SubContentsViewController : UIViewController {
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var NrRoommatesLabel: UILabel!
    @IBOutlet weak var SizeLabel: UILabel!
    @IBOutlet weak var RoomLabel: UILabel!
    @IBOutlet weak var BathLabel: UILabel!
    @IBOutlet weak var KitchenLabel: UILabel!
    @IBOutlet weak var CreditScoreLabel: UILabel!
    
    @IBOutlet weak var imageWaitActivityIndicator: UIActivityIndicatorView!
    
    public var apartment: Apartment = Apartment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageWaitActivityIndicator.startAnimating()

        self.TitleLabel.text = apartment.title
        self.DateLabel.text = apartment.createdAt
        self.PriceLabel.text = apartment.monthlyRent + "/month"
        self.DescriptionLabel.text = apartment.description
        self.NrRoommatesLabel.text = apartment.nrRoommates
        self.SizeLabel.text = apartment.sqFeet

        if apartment.privateRoom == "true" {
            self.RoomLabel.textColor = UIColor.black
            self.RoomLabel.text = "Private Room"
        }
        else {
            self.RoomLabel.text = "Shared Room"
        }

        if apartment.privateBath == "true" {
            self.BathLabel.textColor = UIColor.black
            self.BathLabel.text = "Private Bathroom"
        }
        else {
            self.BathLabel.text = "Shared Bathroom"
        }

        if apartment.kitchenInApartment == "true" {
            self.KitchenLabel.textColor = UIColor.black
            self.KitchenLabel.text = "Kitchen in apt."
        }
        else {
            self.KitchenLabel.text = "No Kitchen in apt."
        }

        if apartment.creditScoreCheck == "true" {
            self.CreditScoreLabel.text = "Credit score check"
        }
        else {
            self.CreditScoreLabel.textColor = UIColor.black
            self.CreditScoreLabel.text = "No Credit score check"
        }

        let url = URL(string: "http://lorempixel.com/728/320/city/")!
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode / 100 != 2 {
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.Image.image = image
                        self.Image.isHidden = false
                        self.imageWaitActivityIndicator.isHidden = true
                        self.imageWaitActivityIndicator.stopAnimating()
                    })
                }
            }
        }
        task.resume()
    }
}
