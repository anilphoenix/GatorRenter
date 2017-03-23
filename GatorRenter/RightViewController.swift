//
//  RightViewController.swift
//  GatorRenter
//
//  Created by fdai4856 on 14/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

class RightViewController : UIViewController {
    
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var PrivateRoomSwitch: UISwitch!
    @IBOutlet weak var PrivateBathroomSwitch: UISwitch!
    @IBOutlet weak var KitchenSwitch: UISwitch!
    @IBOutlet weak var SecurityDepositSwitch: UISwitch!
    @IBOutlet weak var CreditScoreSwitch: UISwitch!
    
    @IBOutlet weak var minPriceTextbox: UITextField!
    @IBOutlet weak var maxPriceTextbox: UITextField!
    
    @IBOutlet weak var UpdateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateButtonTouchUpInside(_ sender: Any) {
        
        SearchTextField.resignFirstResponder()
        
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"UpdateNotification"),
                object: nil,
                userInfo: ["SearchTextField": SearchTextField.text ?? "",
                           "privateRoom": PrivateRoomSwitch.isOn ? "true" : "",
                           "privateBath": PrivateBathroomSwitch.isOn ? "true" : "",
                           "kitchenInApartment": KitchenSwitch.isOn ? "true" : "",
                           "hasSecurityDeposit": SecurityDepositSwitch.isOn ? "true" : "",
                           "creditScoreCheck": CreditScoreSwitch.isOn ? "true" : "",
                           "monthlyRentMin": minPriceTextbox.text ?? "",
                           "monthlyRentMax": maxPriceTextbox.text ?? "",
                           ])
        closeRight()
    }
}
