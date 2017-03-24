//
//  AccountViewController.swift
//  GatorRenter
//
//  Created by Saad Abdullah Gondal on 3/23/17.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
}
extension AccountViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .login, .signup, .logout, .myApartments, .account, .nonMenu:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        var _menu: LeftMenu? = LeftMenu(rawValue: indexPath.row)!
        
        //        if userLoggedIn && (_menu?.rawValue)! > 0 {
        //            _menu = LeftMenu(rawValue: (_menu?.rawValue)! + 2)!
        //        }
        //
        //        if let menu = _menu {
        //            self.changeViewController(menu)
        //        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        if self.tableView == scrollView {
        //
        //        }
    }
}

extension AccountViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if let _ = UserDefaults.standard.dictionary(forKey: "UserInfo") {
        //            menus = loggedInMenus
        //        }
        //        else {
        //            menus = loggedOutMenus
        //        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        if let menu = LeftMenu(rawValue: indexPath.row) {
        //            switch menu {
        //            case .main, .login, .signup, .logout, .myApartments, .account, .nonMenu:
        //                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        //                cell.setData(menus[indexPath.row])
        //                return cell
        //            }
        //        }
        return UITableViewCell()
    }
}
