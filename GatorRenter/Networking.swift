//
//  Networking.swift
//  GatorRenter
//
//  Created by fdai4856 on 16/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import Foundation
import Alamofire

public enum RequestType {
    case GETAPARTMENTSBYFILTERS
}

public class Networking {
    
    static private let baseUrl = "http://ec2-35-157-127-63.eu-central-1.compute.amazonaws.com:8080/GatorRenter"
    
    static func GetApartmentsByFilters(parameters: [String: String], success: @escaping (_ response: [String: Any]) -> Void){
        
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
        
        var apiURL = "/apartment/filterApartments"
        
        if (parameters.count > 0) {
            apiURL += "?"
            for (key, value) in parameters {
                apiURL += "" + key + "=" + value + "&"
            }
        }
        
        var dataResponse: [String: Any] = Dictionary<String, Any>()
        
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
        
        Alamofire.request(url, method: .get, parameters: nil, headers: headers).responseData { response in
            let xml = SWXMLHash.parse(response.data!)
            dataResponse = self.enumerate(indexer: xml, level: 0)
            success(dataResponse)
        }
    }
    
    func xmlToDictionaries(xml: XMLIndexer) -> Dictionary<String, Dictionary<String, Dictionary<String, String>>> {
        
        
        return Dictionary()
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
