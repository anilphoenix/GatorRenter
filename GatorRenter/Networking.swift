//
//  Networking.swift
//  GatorRenter
//
//  Created by fdai4856 on 16/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

public enum RequestType {
    case GETAPARTMENTSBYFILTERS
}

public class Networking {
    
    static private let baseUrl = "http://ec2-35-158-6-225.eu-central-1.compute.amazonaws.com:8080/GatorRenter"
	let defaults = UserDefaults.standard
    
    static private var searchQuery = ""
    static private var imageURLsCollection: [URL] = []
    static private var imagesCollection: [UIImage] = []
    static private var responded: Bool = false
    static private var responded1: Bool = false
    
    
    
    static func Login(email: String, password: String, success: @escaping (_ response: [String: Any]?) -> Void) {

        responded1 = false

        let apiURL = "/user/login"

        var dataResponse: [String: Any] = Dictionary<String, Any>()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        let headers: HTTPHeaders = [
            "email": email,
            "password": password
        ]

        let url: String = baseUrl + apiURL
        
        manager.request(url, method: .get, parameters: nil, headers: headers).responseData { response in
            let xml = SWXMLHash.parse(response.data!)
            dataResponse = self.enumerate(indexer: xml, level: 0)
            
            if let notNil = dataResponse["GatorRenterResponse"] {
                dataResponse = notNil as! [String : Any]
            }
            else {
                responded1 = true
                success(nil)
            }
            
            let statusDict = dataResponse["status"]
            dataResponse["status"] = nil
            
            UserDefaults.standard.set(dataResponse, forKey: "UserInfo")
            print(UserDefaults.standard.value(forKey: "UserInfo") ?? "No UserInto in UserDefaults")
            
            if !responded1 {
                success(statusDict as! [String : Any]?)
            }
        }
    }
    
    static func GetApartmentsByFilters(parameters: [String: String], success: @escaping (_ response: [Apartment]?) -> Void){
        
//        Integer signedInUserId
//        String accessToken
//        Boolean privateRoom
//        Boolean privateBath
//        Boolean kitchenInApartment
//        Boolean hasSecurityDeposit
//        Boolean creditScoreCheck
//        Integer userId
//        Integer apartmentId
//        Double monthlyRentMin
//        Double monthlyRentMax
//        String email
//        Integer pageNumber
//        Integer pageSize
        
        responded = false
        
        var apiURL = "/apartment/filterApartments"
        
        if (parameters.count > 0) {
            apiURL += "?"
            searchQuery = ""
            for (key, value) in parameters {
                if (!value.isEmpty) {
                    if (key == "SearchTextField") {
                        searchQuery = value
                    }
                    else {
                    	apiURL += "" + key + "=" + value + "&"
                    }
                }
            }
        }
        
        var dataResponse: [String: Any] = Dictionary<String, Any>()
        var apartmentsList: [Apartment] = []
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/xml",
            "signedInUserId": "18",
            "accessToken": "66e1ec1e-8ea0-4caa-b486-8a610dc78ff9"
        ]
        
//        let requestBodyXML = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><apartmentDetails><id>225</id><addressLine1>ChangedStrAnilTesting2</addressLine1><city>Fulda</city><state>Hesse</state><country>Germany</country><zip>36037</zip><title>This is my new house</title><description>this is house for rent for 250 euros</description><sqFeet>20</sqFeet><nrBedrooms>2</nrBedrooms><nrRoommates>2</nrRoommates><nrBathrooms>1</nrBathrooms><floor>5</floor><privateBath>false</privateBath><privateRoom>true</privateRoom><kitchenInApartment>true</kitchenInApartment><hasSecurityDeposit>true</hasSecurityDeposit><creditScoreCheck>false</creditScoreCheck><monthlyRent>250</monthlyRent><securityDeposit>250</securityDeposit><availableSince>2017-01-25</availableSince><leaseEndDate>2018-01-25</leaseEndDate><flagged>0</flagged><longitude>45555000</longitude><latitude>645564564</latitude></apartmentDetails>"
//        
//        let customEncoding = CustomEncoding(xml: requestBodyXML)
//        
//        manager.request("http://ec2-35-157-127-63.eu-central-1.compute.amazonaws.com:8080/GatorRenter/apartment/updateApartment",
//                        method: .put,
//                        parameters: nil,
//                        encoding: customEncoding,
//                        headers: headers)
//            .responseData { response in
//                let xml = SWXMLHash.parse(response.data!)
//                
//                self.enumerate(indexer: xml, level: 0)
//        }
        
        let url: String = baseUrl + apiURL
        
        manager.request(url, method: .get, parameters: nil, headers: headers).responseData { response in
            let xml = SWXMLHash.parse(response.data!)
            dataResponse = self.enumerate(indexer: xml, level: 0)
            var apartment = Apartment()
            
            if let notNil = dataResponse["GatorRenterResponse"] {
                dataResponse = notNil as! [String : Any]
            }
            else {
                responded = true
                success(nil)
            }
//            dataResponse = dataResponse["GatorRenterResponse"] as! [String : Any]

            for (key, value) in dataResponse {
                if (key != "status") {
                    let tempApt = value as! [String : String]

                    if (key.range(of: "apartmentDetails")) != nil || key.range(of: "apartmentsList") != nil {
                        apartment.internalName = key
                        apartment.id = tempApt["id"]!
                        apartment.active = tempApt["active"]!
                        apartment.createdAt = tempApt["createdAt"]!
                        apartment.updatedAt = tempApt["updatedAt"]!
                        apartment.state = tempApt["state"]!
                        apartment.addressLine1 = tempApt["addressLine1"]!
                        apartment.city = tempApt["city"]!
                        apartment.country = tempApt["country"]!
                        apartment.zip = tempApt["zip"]!
                        apartment.title = tempApt["title"]!
                        apartment.description = tempApt["description"]!
                        apartment.sqFeet = tempApt["sqFeet"]!
                        apartment.nrBedrooms = tempApt["nrBedrooms"]!
                        apartment.nrRoommates = tempApt["nrRoommates"]!
                        apartment.nrBathrooms = tempApt["nrBathrooms"]!
                        apartment.floor = tempApt["floor"]!
                        apartment.privateRoom = tempApt["privateRoom"]!
                        apartment.privateBath = tempApt["privateBath"]!
                        apartment.kitchenInApartment = tempApt["kitchenInApartment"]!
                        apartment.hasSecurityDeposit = tempApt["hasSecurityDeposit"]!
                        apartment.creditScoreCheck = tempApt["creditScoreCheck"]!
                        apartment.monthlyRent = tempApt["monthlyRent"]!
                        apartment.securityDeposit = tempApt["securityDeposit"]!
                        apartment.availableSince = tempApt["availableSince"]!
                        apartment.leaseEndDate = tempApt["leaseEndDate"]!
                        apartment.longitude = tempApt["longitude"]!
                        apartment.flagged = tempApt["flagged"]!
                        apartment.latitude = tempApt["latitude"]!
                        
                        apartment.searchableField = tempApt["addressLine1"]! + "_" +
                        							tempApt["city"]! + "_" +
                        							tempApt["country"]! + "_" +
                        							tempApt["zip"]! + "_" +
                        							tempApt["title"]! + "_" +
                        							tempApt["description"]! + "_" +
                        							tempApt["sqFeet"]!
                    }
                    
                    if searchQuery.isEmpty
                        || apartment.searchableField.lowercased().range(of:searchQuery) != nil {
                    	apartmentsList.append(apartment)
                    }
                }
            }
            
            apartmentsList.sort{ $0.internalName < $1.internalName }
            if !responded {
            	success(apartmentsList)
            }
        }
    }
    
    func xmlToDictionaries(xml: XMLIndexer) -> Dictionary<String, Dictionary<String, Dictionary<String, String>>> {
        
        
        return Dictionary()
    }
    
    public static func getRandomImages(success: @escaping (_ response: [UIImage]) -> Void) {
        let url = "https://pixabay.com/api/?key=4847699-165c5dd0c9629b5c251ca193a&q=apartment&image_type=photo&page=1&per_page=20&order=popular"
        let session = URLSession(configuration: .default)
        var counter = 0
        
        Alamofire.request(url, method: .get, parameters: nil, headers: nil).responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                
                let imageArray = JSON["hits"] as! NSArray
                
                for image in imageArray {
                    //let imagenameurl = URL(string: (image as! NSDictionary)["userImageURL"] as! String)
                    if let temp = URL(string: (image as! NSDictionary)["userImageURL"] as! String) {
                    	imageURLsCollection.append(temp)
                    }
                }
                
                for fetchUrl in imageURLsCollection {
                    let downloadPicTask = session.dataTask(with: fetchUrl) { (data, response, error) in
                        if let e = error {
                            print("Error downloading picture: \(e)")
                        } else {
                            if let res = response as? HTTPURLResponse {
                                print("Downloaded picture with response code \(res.statusCode)")
                                if let imageData = data {
                                    imagesCollection.append(UIImage(data: imageData)!)
                                } else {
                                    print("Couldn't get image: Image is nil")
                                }
                            } else {
                                print("Couldn't get response code for some reason")
                            }
                        }
                        if(counter >= imageURLsCollection.count-1){
                            success(imagesCollection)
                        }
                        
                        counter += 1
                    }
                    
                    downloadPicTask.resume()
                }
            }
        }
    }
    
    private static func enumerate(indexer: XMLIndexer, level: Int) -> [String: Any]{
        
        var response: [String: Any] = Dictionary<String, String>()
        var counter = 0

        for child in indexer.children {
            var name = child.element!.name
            let text = child.element!.text
            
            if child.children.count > 0 {
                
                if (name == "apartmentDetails" || name == "apartmentsList") {
                    name += String(counter)
                    counter += 1
                }
                
                response[name] = enumerate(indexer: child, level: level + 1)
            }
            else {
                response[name] = text
            }
        }
        
        return response
    }
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
