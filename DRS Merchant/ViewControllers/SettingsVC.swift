//
//  SettingsVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class SettingsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var viewLanguageBG: UIView!
    @IBOutlet weak var viewLang: UIView!
    @IBOutlet weak var tableLanguage: UITableView!
    var strTitle:String = String()
    @IBOutlet weak var btnCancel: UIButton!
    var businessName:String = String()
    var businessLogo:String = String()
    var businessAccNum:String = String()
    var businessAccBal:String = String()
    @IBOutlet weak var lblSignOutFirst: UILabel!
    var loginResponse: LoginResponse?
    @IBOutlet weak var viewSignOut: UIView!
    
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblSignOutSecond: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var viewBgSignOut: UIView!
    
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var tableMenu: UITableView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewScollContent: UIView!
    @IBOutlet weak var tableAcNo: UITableView!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var scrollSettings: UIScrollView!
    var items = [String]()
    var itemValue = [String]()
    
    var languageItem = [String]()//Burmese
    var languageCode = [0,1]
    
    //var settingsitems = ["Account Setting"]
    //var settingsitems = ["Account Setting", "Sales Report","Notifications","Language","Customer Support"]
    var settingsitems = [String]()
    @IBAction func btnCancelAction(_ sender: UIButton) {
        btnCancel.isHidden = true
        viewLanguageBG.isHidden = true
        viewLang.isHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount = Int()
        if tableView == tableAcNo
        {
//            tableCount = items.count
            tableCount = 1

        }
        else if tableView == tableMenu {
            tableCount = settingsitems.count
        }
        else if tableView == tableLanguage {
            tableCount = languageCode.count
        }
        
        return tableCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableAcNo {
            let cellBal = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
            
            cellBal.lblValue.textColor = Constants.textColor
            
            cellBal.selectionStyle = .none
            cellBal.lblContent.text = items[indexPath.row]

            cellBal.lblValue.text = itemValue[indexPath.row] as! String
            
//            cellBal.lblValue.text = (UserDefaults.standard.value(forKey: "account_Number") as! String)

            cell = cellBal
        }
        else if tableView == tableMenu {
            let cellBal = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
            
            cellBal.lblValue.textColor = Constants.textColor
            
            cellBal.selectionStyle = .none
            cellBal.lblContent.text = settingsitems[indexPath.row]
            
            cell = cellBal
        }
        else if tableView == tableLanguage {
            let cellBal = tableLanguage.dequeueReusableCell(withIdentifier: "CountrySettings", for: indexPath) as! CountrySettings
            cellBal.backgroundColor = UIColor.white
            cellBal.selectionStyle = .none
            cellBal.lblCountry.text = languageItem[indexPath.row]
            //cellBal.lblLanguage.text = languageItem[indexPath.row]
            
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableMenu {
            if indexPath.row == 0 {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingVC") as! AccountSettingVC
                self.navigationController?.pushViewController(next, animated: true)
                
            }
            else if indexPath.row == 1{
                let next = self.storyboard?.instantiateViewController(withIdentifier: "SalesReportVC") as! SalesReportVC
                
                self.navigationController?.pushViewController(next, animated: true)
            }
            else if indexPath.row == 2
            {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                
                self.navigationController?.pushViewController(next, animated: true)
                
               
            }
            else if indexPath.row == 3
            {
                
                btnCancel.isHidden = false
               viewLanguageBG.isHidden = false
               viewLang.isHidden = false
                
            }
            else if indexPath.row == 4
            {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "CustomerSupportListVC") as! CustomerSupportListVC
                self.navigationController?.pushViewController(next, animated: true)
            }
            
            
        }
        else if tableView == tableLanguage {
            btnCancel.isHidden = true
            viewLanguageBG.isHidden = true
            viewLang.isHidden = true
            let sharedDefault = SharedDefault()
            sharedDefault.setLanguage(language: languageCode[indexPath.row])
            self.changeLanguage()
            print("sharedDefault  ",sharedDefault.getLanguage())
            tableAcNo.reloadData()
            tableLanguage.reloadData()
            tableMenu.reloadData()
            
        }
    }
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        items.removeAll()
        settingsitems.removeAll()
        languageItem.removeAll()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.App_Name.text {
                    sharedDefault.setAppName(loginStatus: text)
                }
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting.text {
                    strTitle = text
                    self.title = text
                }
//                if let text = xml.resource.Setting_Acc_Number.text {
//                    items.append(text)
//                }
                
                if let text = xml.resource.Setting_Acc_Bal.text {
                    items.append(text)
                }
                if let text = xml.resource.Setting_Account_Setting.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_Sales_Report.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_Notify.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_Language.text {
                    settingsitems.append(text)
                    lblLanguage.text = text
                }
                if let text = xml.resource.Setting_Cust_Support.text {
                    settingsitems.append(text)
                }
               
                
                if let text = xml.resource.Setting_SIGN_OUT.text {
                    btnSignOut.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.New_Message_yes.text {
                    btnYes.setTitle(text, for: .normal)
                }
                if let text = xml.resource.New_Message_NO.text {
                    btnNo.setTitle(text, for: .normal)
                }
                if let text = xml.resource.New_Message_sign_out.text {
                    lblSignOutFirst.text = text
                }
                if let text = xml.resource.Title_Cancel.text
                {
                    btnCancel.setTitle(text, for: .normal)
                }
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            var strHead:String = ""
            
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.App_Name.text {
                    sharedDefault.setAppName(loginStatus: text)
                }
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                
                if let text = xml.resource.Setting.text {
                    strTitle = text
                    self.title = text
                }
//                if let text = xml.resource.Setting_Acc_Number.text {
//                    items.append(text)
//                }
                
                if let text = xml.resource.Setting_Acc_Bal.text {
                    items.append(text)
                }
                if let text = xml.resource.Setting_Account_Setting.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_Sales_Report.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_Notify.text {
                    settingsitems.append(text)
                }
                if let text = xml.resource.Setting_Language.text {
                    settingsitems.append(text)
                    lblLanguage.text = text
                }
                if let text = xml.resource.Setting_Cust_Support.text {
                    settingsitems.append(text)
                }
                
                
                
                
                
                
                
                
                if let text = xml.resource.Title_Cancel.text
                {
                    btnCancel.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.Setting_SIGN_OUT.text {
                    btnSignOut.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.New_Message_yes.text {
                    btnYes.setTitle(text, for: .normal)
                }
                if let text = xml.resource.New_Message_NO.text {
                    btnNo.setTitle(text, for: .normal)
                }
                if let text = xml.resource.New_Message_sign_out.text {
                    lblSignOutFirst.text = text
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear SettingsVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        
        viewSignOut.layer.cornerRadius = 10
        btnNo.layer.cornerRadius = btnNo.frame.size.height/2
        btnYes.layer.cornerRadius = btnNo.frame.size.height/2
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
        viewTop.layer.cornerRadius = 10
        viewTop.clipsToBounds = true
        viewBottom.layer.cornerRadius = 10
        viewBottom.clipsToBounds = true
        btnSignOut.layer.cornerRadius = btnSignOut.frame.size.height/2
        
        
        let downloadURL = NSURL(string: businessLogo)!
        if downloadURL.absoluteString!.count>0 {
            imgShop.load(url: downloadURL as URL)
        } else {
            self.imgShop.backgroundColor = UIColor.black
            self.imgShop.image = UIImage(named: "HomeBG")
        }
        
        lblShopName.text = businessName
        itemValue.removeAll()
        
        
//        itemValue.append(businessName)
//        itemValue.append(businessAccBal)
        
//        itemValue.append(UserDefaults.standard.value(forKey: "account_Number") as! String)
        itemValue.append(businessAccBal)
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewLang.layer.cornerRadius = 20.0
        viewLang.clipsToBounds = true
        btnCancel.layer.cornerRadius = btnCancel.frame.size.height/2
        
        tableLanguage.delegate = self
        tableLanguage.dataSource = self
        
        self.changeLanguage()
    }
    
    @IBAction func btnSignOutAction(_ sender: UIButton) {
        viewBgSignOut.isHidden = false
    }
    @IBAction func btnNowAction(_ sender: UIButton) {
        
        viewBgSignOut.isHidden = true
    }
    @IBAction func btnYesAction(_ sender: UIButton) {
        self.logout()
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    func logout() {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        let sharedData:SharedDefault = SharedDefault()
        postDict = ["access_token":sharedData.getAccessToken()
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.SignOutURL
        
        AF.request(loginURL, method: .post, parameters: postDict, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            print("Response:***:",data.description)
            
            switch (data.result) {
            case .failure(let error) :
                     self.view.activityStopAnimating()
                          let sharedDefault = SharedDefault()
                          if error._code == NSURLErrorTimedOut {
                           if sharedDefault.getLanguage() == 1 {
                                self.showToast(message: Constants.ReqTimedOutBur)
                           }else if sharedDefault.getLanguage() == 0 {
                               self.showToast(message: Constants.ReqTimedOutEng)
                           }
                            
                          }
                          else if error._code == 4 {
                           if sharedDefault.getLanguage() == 1 {
                                self.showToast(message: Constants.IntServerErrorBur)
                           }else if sharedDefault.getLanguage() == 0 {
                               self.showToast(message: Constants.IntServerErrorEng)
                           }
                              //self.showToast(message: "Internal server error! Please try again!")
                          }
                          else if error._code == -1003 {
                           if sharedDefault.getLanguage() == 1 {
                                self.showToast(message: Constants.ServerErrorBur)
                           }else if sharedDefault.getLanguage() == 0 {
                               self.showToast(message: Constants.ServerErrorEng)
                           }
                              //self.showToast(message: "Server error! Please contact support!")
                           }
            case .success :
                do {
                    
                    let response = JSON(data.data!)
                    self.loginResponse = LoginResponse(response)
                    print("self.loginResponse ",self.loginResponse!)
                    print("self.loginResponse ",self.loginResponse?.httpcode!)
                    print("self.loginResponse ",self.loginResponse?.loginData?.userData!)
                    let sharedDefault = SharedDefault()
                    let statusCode = Int((self.loginResponse?.httpcode)!)
                    if statusCode == 200{
                        sharedDefault .setLoginStatus(loginStatus: false)
                        sharedDefault.clearAccessToken()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                            let sharedData = SharedDefault()
                            sharedData .setLoginStatus(loginStatus: false)
                            sharedData.clearFcmToken()
                            //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                            //UserDefaults.standard.synchronize()
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            let navigationController = UINavigationController(rootViewController: yourVC)
                            
                            appDelegate.window?.rootViewController = navigationController
                            appDelegate.window?.makeKeyAndVisible()
                            
                            self.navigationController?.popToRootViewController(animated: true)
                            
                        }
                    }
                    if statusCode == 400{
                        sharedDefault .setLoginStatus(loginStatus: false)
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.loginResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                let sharedDefault = SharedDefault()
                                sharedDefault .setLoginStatus(loginStatus: false)
                                sharedDefault.clearAccessToken()
                                
                                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                let customViewControllersArray : NSArray = [newViewController]
                                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        } else {
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.loginResponse?.message)!)
                        }
                        
                        
                    }
                    
                    
                    self.view.activityStopAnimating()
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
