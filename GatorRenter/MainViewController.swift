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

        self.collectionView.backgroundView = dataWaitIndicator
        dataWaitIndicator.startAnimating()
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        
        Networking.GetApartmentsByFilters(parameters: [:], success: { (response) -> Void in
                if (response != nil) {
                    self.serviceData = response!
                    self.apartmentsLoaded = true
                }
                else {
                    self.apartmentsLoaded = false
            	}
        	})
        
        Networking.getRandomImages(success: { (responseImages) -> Void in
            self.imagesCollection = responseImages

            while (self.apartmentsLoaded == nil) {
                sleep(1)
            }
            if !self.apartmentsLoaded! {
                self.alert(message: "The web-service is currently unavailable\nPlease try again later", title: "Service Unavailable")
                self.dataWaitIndicator.stopAnimating()
                self.collectionView.isHidden = true
                self.reloadButton.isHidden = false
                print("execution complete")
            }
            else {
                self.dataWaitIndicator.stopAnimating()
                self.collectionView.reloadData()
            }

        })
        
//        Networking.getImagesFromURLs(array: imageURLsCollection, success: { (responseImages) -> Void in
//            self.imagesCollection = responseImages
//            self.dataWaitIndicator.stopAnimating()
//            self.collectionView.reloadData()
//        })
        
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
    }
}


extension MainViewController : UICollectionViewDelegate {

    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("You selected cell #\(indexPath.item)!")
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
        
//        let randomNum = Int(arc4random_uniform(UInt32(imagesCollection.count)))
        cell.Image.image = imagesCollection[indexPath.item]
        
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
				
