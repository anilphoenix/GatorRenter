//
//  LeftViewController.swift
//  GatorRenter
//
//  Created by fdai4856 on 14/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case login = 1
    case signup = 2
    case myApartments = 3
    case account = 4
    case logout = 5
    case nonMenu = 6
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
//    UserDefaults.standard.setValue(token, forKey: "user_auth_token")
//    print("\(UserDefaults.standard.value(forKey: "user_auth_token")!)")
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    let loggedInMenus = ["Home", "My Apartments", "Account", "Logout"]//, "NonMenu"]
    let loggedOutMenus = ["Home", "Login", "Signup"]
    var menus:[String] = []
    var observerAdded = false
    var mainViewController: UIViewController!
    var loginViewController: UIViewController!
    var signupViewController: UIViewController!
    var logoutViewController: UIViewController!
    var myApartmentsViewController: UIViewController!
    var accountViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    var userLoggedIn = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nc = NotificationCenter.default

        if !observerAdded {
            nc.addObserver(forName:Notification.Name(rawValue:"LoginNotification"),
                           object:nil, queue:nil) {
                            notification in
                            if (notification.userInfo as! [String : Bool])["loggedIn"] == true {
                                self.tableView.reloadData()
                                self.userLoggedIn = true
                                self.changeViewController(.main)
                            }
            }
            observerAdded = true
        }
        
        if UserDefaults.standard.dictionary(forKey: "UserInfo") != nil {
            userLoggedIn = true
        }
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.loginViewController = UINavigationController(rootViewController: loginViewController)
        
        let signupViewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.signupViewController = UINavigationController(rootViewController: signupViewController)

//        let logoutViewController = storyboard.instantiateViewController(withIdentifier: "LogoutViewController") as! LogoutViewController
//        self.logoutViewController = UINavigationController(rootViewController: logoutViewController)
        
//        let myApartmentsViewController = storyboard.instantiateViewController(withIdentifier: "MyApartmentsViewController") as! MyApartmentsViewController
//        self.myApartmentsViewController = UINavigationController(rootViewController: myApartmentsViewController)
        
//        let accountViewController = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
//        self.accountViewController = UINavigationController(rootViewController: accountViewController)
    
        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        
//        var _menu: LeftMenu = menu
//        
//        if userLoggedIn && menu.rawValue > 0 {
//            _menu = LeftMenu(rawValue: menu.rawValue + 2)!
//        }
//        
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .login:
            self.slideMenuController()?.changeMainViewController(self.loginViewController, close: true)
        case .signup:
            self.slideMenuController()?.changeMainViewController(self.signupViewController, close: true)
        case .logout:
            UserDefaults.standard.removeObject(forKey: "UserInfo")
            tableView.reloadData()
            userLoggedIn = false
            closeLeft()
        case .myApartments:
            self.slideMenuController()?.changeMainViewController(self.myApartmentsViewController, close: true)
        case .account:
            self.slideMenuController()?.changeMainViewController(self.accountViewController, close: true)
        case .nonMenu:
            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
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
        
        var _menu: LeftMenu? = LeftMenu(rawValue: indexPath.row)!
        
        if userLoggedIn && (_menu?.rawValue)! > 0 {
            _menu = LeftMenu(rawValue: (_menu?.rawValue)! + 2)!
        }
        
        if let menu = _menu {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = UserDefaults.standard.dictionary(forKey: "UserInfo") {
            menus = loggedInMenus
        }
        else {
            menus = loggedOutMenus
        }

        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .login, .signup, .logout, .myApartments, .account, .nonMenu:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
