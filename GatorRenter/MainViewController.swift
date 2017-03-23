//
//  ViewController.swift
//  GatorRenter
//
//  Created by fdai4856 on 21/12/2016.
//  Copyright © 2016 fdai4856. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dataWaitIndicator: UIActivityIndicatorView! = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    @IBOutlet weak var reloadButton: UIButton!
    
    let reuseIdentifier = "collectionViewCell"

    var pageNumber = 0
    var serviceData = [Apartment]()
    var imageURLsCollection: [URL] = []
    var imagesCollection: [UIImage] = []
    var apartmentsLoaded:Bool? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let nc = NotificationCenter.default
        nc.addObserver(forName:Notification.Name(rawValue:"UpdateNotification"),
                       object:nil, queue:nil) {
                        notification in
                        self.serviceData = [Apartment]()
                        self.collectionView.reloadData()
                        self.loadAllData(params: notification.userInfo as! [String : String])
        }

        loadAllData(params: [:])
    }
    
    func loadAllData (params: [String: String]) {
        self.collectionView.backgroundView = dataWaitIndicator
        dataWaitIndicator.startAnimating()
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        
        Networking.GetApartmentsByFilters(parameters: params , success: { (response) -> Void in
            if (response != nil) {
                self.serviceData = response!
                self.dataWaitIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
            else {
                self.alert(message: "The web-service is currently unavailable\nPlease try again later", title: "Service Unavailable")
                self.dataWaitIndicator.stopAnimating()
                self.collectionView.isHidden = true
                self.reloadButton.isHidden = false
            }
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func reloadButtonTouchUpInside(_ sender: Any) {
        self.reloadButton.isHidden = true
        self.dataWaitIndicator.isHidden = false
        self.dataWaitIndicator.startAnimating()
        loadAllData(params: [:])
    }
}


extension MainViewController : UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let apartment = self.serviceData[indexPath.item]
        
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentsViewController") as! SubContentsViewController

        subContentsVC.apartment = apartment
        self.navigationController?.pushViewController(subContentsVC, animated: true)

        print("Selected cell #\(indexPath.item)!")
    }
}

extension MainViewController : UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.serviceData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        cell.TitleLabel.text = self.serviceData[indexPath.item].title
        cell.DateLabel.text = self.serviceData[indexPath.item].createdAt
        let roommates = Int(self.serviceData[indexPath.item].nrRoommates)
        let privateRoom = (self.serviceData[indexPath.item].privateRoom as String).toBool()
        let privateBath = (self.serviceData[indexPath.item].privateBath as String).toBool()

        cell.DescriptionLabel.text =  "\(roommates!) roomate" + (roommates! > 1 ? "s, ": ", ")
            						  + (privateRoom! ? "private" : "shared") + " room, "
        							  + (privateBath! ? "private" : "shared") + " bath"
        
        cell.Image.isHidden = true
        cell.imageWaitActivityIndicator.isHidden = false
        cell.imageWaitActivityIndicator.startAnimating()
        
        let url = URL(string: "http://lorempixel.com/640/300/city/")!
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
                        cell.Image.image = image
                        cell.Image.isHidden = false
                        cell.imageWaitActivityIndicator.isHidden = true
                        cell.imageWaitActivityIndicator.stopAnimating()
                    })
                }
            }
        }
        task.resume()
        
        cell.apartment = self.serviceData[indexPath.item]
        
        return cell
    }
}

extension MainViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
				
