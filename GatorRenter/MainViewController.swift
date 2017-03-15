//
//  ViewController.swift
//  GatorRenter
//
//  Created by fdai4856 on 21/12/2016.
//  Copyright © 2016 fdai4856. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pageNumber = 0
    
    var mainContens = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        //self.tableView.registerCellNib(DataTableViewCell.self)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/xml",
            "signedInUserId": "18",
            "accessToken": "66e1ec1e-8ea0-4caa-b486-8a610dc78ff9"
        ]
        
        let requestBodyXML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><apartmentDetails><id>225</id><addressLine1>ChangedStrAnilTesting2</addressLine1><city>Fulda</city><state>Hesse</state><country>Germany</country><zip>36037</zip><title>This is my new house</title><description>this is house for rent for 250 euros</description><sqFeet>20</sqFeet><nrBedrooms>2</nrBedrooms><nrRoommates>2</nrRoommates><nrBathrooms>1</nrBathrooms><floor>5</floor><privateBath>false</privateBath><privateRoom>true</privateRoom><kitchenInApartment>true</kitchenInApartment><hasSecurityDeposit>true</hasSecurityDeposit><creditScoreCheck>false</creditScoreCheck><monthlyRent>250</monthlyRent><securityDeposit>250</securityDeposit><availableSince>2017-01-25</availableSince><leaseEndDate>2018-01-25</leaseEndDate><flagged>0</flagged><longitude>45555000</longitude><latitude>645564564</latitude></apartmentDetails>"
        
        manager.request("http://ec2-35-157-127-63.eu-central-1.compute.amazonaws.com:8080/GatorRenter/apartment/updateApartment",
                          method: .get,
                          parameters: nil,
                          encoding: CustomEncoding(xml: requestBodyXML),
                          headers: headers)
            .responseData { response in
            let xml = SWXMLHash.parse(response.data!)
            
            print(xml)
        }
        
        Alamofire.request("http://ec2-35-157-127-63.eu-central-1.compute.amazonaws.com:8080/GatorRenter/apartment/filterApartments?pageNumber=1&pageSize=5", method: .get, parameters: nil, headers: headers).responseData { response in
            let xml = SWXMLHash.parse(response.data!)
            
            print(xml)
        }
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

    let reuseIdentifier = "collectionViewCell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.TitleLabel.text = self.items[indexPath.item]
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
//        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}


//extension MainViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return DataTableViewCell.height()
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
//        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentsViewController") as! SubContentsViewController
//        self.navigationController?.pushViewController(subContentsVC, animated: true)
//    }
//}
//
//extension MainViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.mainContens.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
//        let data = DataTableViewCellData(imageUrl: "dummy", text: mainContens[indexPath.row])
//        cell.setData(data)
//        return cell
//    }
//}

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
    
    struct CustomPostEncoding: ParameterEncoding {
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var request = try URLEncoding().encode(urlRequest, with: parameters)
            let httpBody = NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)!
            request.httpBody = httpBody.replacingOccurrences(of: "%5B%5D=", with: "=").data(using: .utf8)
            return request
        }
    }
    
    struct CustomEncoding: ParameterEncoding {
        let xml: String
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            
            urlRequest.httpBody = xml.data(using: String.Encoding.utf8)
            
            return urlRequest
        }
    }
}
				
