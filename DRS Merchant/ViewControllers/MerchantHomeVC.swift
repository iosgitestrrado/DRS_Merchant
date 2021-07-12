//
//  MerchantVC.swift
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

class MerchantHomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var dashBoardResponse: DashboardResponse?
    @IBOutlet var collectionMenu: UICollectionView!
    @IBOutlet weak var txtAccBal: UITextField!
    @IBOutlet weak var lblAccount: UILabel!
    let reuseIdentifierPromo = "MenuCollectionCell"
    @IBOutlet weak var imgMerchant: UIImageView!
    var accBalance = String()
    var accGreet = String()
    var accPersonName = String()
    var loginResponse: LoginResponse?
    let longTitleLabel = UILabel()
    var greeting:String = String()
    var strTitle: String! = String()
    // var items = ["Pay Code"]
    // var itemsImage = ["Paycode"]
    
    var items = [String]()
    var itemsImage = ["Paycode", "Transaction","Withdrawal"]
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionMenu {
            let menuCell = collectionMenu.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPromo, for: indexPath as IndexPath) as! MenuCollectionCell
            menuCell.viewMenuBG.layer.cornerRadius = 20
            menuCell.lblMenuName.text = items[indexPath.row]
            menuCell.imgMenu.image = UIImage(named: itemsImage[indexPath.row])
            //menuCell.lblCellPromotion.text = "Don't miss out the special offer"
            //menuCell.imgviewCollection.roundCorners(corners: [.topLeft,.topRight], radius: 20)
            cell = menuCell
            
        }
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if collectionView == collectionMenu {
            if indexPath.row == 0
            {
                 let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalVC") as! WithdrawalVC
                 self.navigationController?.pushViewController(next, animated: true)
                
               
                
              
                
                
                
//                let next = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                //let next = self.storyboard?.instantiateViewController(withIdentifier: "MsgDetailListVC") as! MsgDetailListVC
               // self.navigationController?.pushViewController(next, animated: true)
                
                
                
                
            }
            else if(indexPath.row == 1)
            {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "PayCodeVC") as! PayCodeVC
                next.strName = (self.dashBoardResponse?.dashData?.dashboardData?.businessName)!
                self.navigationController?.pushViewController(next, animated: true)
                
                
            }
            else if(indexPath.row == 2)
            {
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TransactionHistoryVC") as! TransactionHistoryVC
               self.navigationController?.pushViewController(next, animated: true)
                
            }
        }
    }
    
    func changeLanguage() {
        items.removeAll()
        
           let sharedDefault = SharedDefault()
           if sharedDefault.getLanguage() == 1 {
               print("changeLanguage")
              
               let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                
                  
                if let text = xml.resource.Home_page_Acc_Bal.text {
                    print("btnNext",text)
                    lblAccount.text = "-" + text + "-"
                    
                }
                if let text = xml.resource.Home_page_Withdrawal.text {
                    print("btnNext",text)
                    items.append(text)
                    
                }
                if let text = xml.resource.Home_page_Pay_Code.text {
                    print("btnNext",text)
                     items.append(text)
                    
                }
                if let text = xml.resource.Transaction_History.text {
                    print("btnNext",text)
                     items.append(text)
                    
                }
                  
                   if let text = xml.resource.Home_page.text {
                       //btnNext.setTitle(text, for: .normal)
                        print("btnNext",text)
                    greeting = text
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
                
                  
                if let text = xml.resource.Home_page_Acc_Bal.text {
                    print("btnNext",text)
                    lblAccount.text = "-" + text + "-" 
                    
                }
                if let text = xml.resource.Home_page_Withdrawal.text {
                    print("btnNext",text)
                    items.append(text)
                    
                }
                if let text = xml.resource.Home_page_Pay_Code.text {
                    print("btnNext",text)
                     items.append(text)
                    
                }
                if let text = xml.resource.Transaction_History.text {
                    print("btnNext",text)
                     items.append(text)
                    
                }
                  
                   if let text = xml.resource.Home_page.text {
                       //btnNext.setTitle(text, for: .normal)
                        print("btnNext",text)
                    greeting = text
                   }
                   
                   
               }
               catch(_){print("error")}
               
               
           }
           collectionMenu.reloadData()
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear MerchantHomeVC ")
        
       
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true);
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "Settings"), for: .normal)
        button.addTarget(self, action:#selector(self.btnSettingsAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
        
        
        txtAccBal.layer.cornerRadius = txtAccBal.frame.size.height/2
        
        self.changeLanguage()
        self.getDashboardDetails()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
         
         
        
    }
    
    @objc func btnSettingsAction() {
        // Function body goes here
        print("addTapped")
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        
         
         next.businessName = (self.dashBoardResponse?.dashData?.dashboardData?.businessName)!
         next.businessLogo = (self.dashBoardResponse?.dashData?.dashboardData?.companyLogo)!
         next.businessAccBal = (self.dashBoardResponse?.dashData?.dashboardData?.accountBalance)!
         next.businessAccNum = (self.dashBoardResponse?.dashData?.dashboardData?.accountNumber)!
         
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    
    func getDashboardDetails() {
        let sharedDefault = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedDefault.getAccessToken()
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.DashboardURL
        
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
                    self.dashBoardResponse = DashboardResponse(response)
                    print("self.dashBoardResponse ",self.dashBoardResponse!)
                    print("self.dashBoardResponse ",self.dashBoardResponse?.httpcode!)
                    // print("self.loginResponse ",self.loginResponse?.loginData?.userData!.personIncharge!)
                    
                    let statusCode = Int((self.dashBoardResponse?.httpcode)!)
                    if statusCode == 200{
                        self.longTitleLabel.textColor = UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0)
                        //longTitleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width-30, height: 50)
                        self.longTitleLabel.text = " "
                        self.longTitleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                        //[longTitleLabel, setFont:[UIFont boldSystemFontOfSize:16]];
                        //longTitleLabel.sizeToFit()
                        let leftItem = UIBarButtonItem(customView: self.longTitleLabel)
                        self.navigationItem.leftBarButtonItem = leftItem
                        
                        if sharedDefault.getLanguage() == 0 {
                            var greet:String = ""
                            
                            if (self.dashBoardResponse?.dashData?.dashboardData?.greeting)! == "Good Afternoon" {
                                greet = "Good Afternoon"
                            } else if(self.dashBoardResponse?.dashData?.dashboardData?.greeting)! == "Good Morning" {
                                greet = "Good Morning"
                            }
                            else if(self.dashBoardResponse?.dashData?.dashboardData?.greeting)! == "Good Evening" {
                                greet = "Good Evening"
                            }
                            
                            self.longTitleLabel.text  = greet + " " + (self.dashBoardResponse?.dashData?.dashboardData?.personIncharge)!
                        }
                        else if sharedDefault.getLanguage() == 1 {
                            var greet:String = ""
                            if (self.dashBoardResponse?.dashData?.dashboardData?.greeting)! == "Good Afternoon" {
                                greet = "မင်္ဂလာနေ့လည်ခင်း"
                            } else if(self.dashBoardResponse?.dashData?.dashboardData?.greeting)! == "Good Morning" {
                                greet = "မင်္ဂလာနံနက်ခင်းပါ"
                            }
                            else if(self.dashBoardResponse?.dashData?.dashboardData?.greeting)! == "Good Evening" {
                                greet = "မင်္ဂလာညနေခင်းပါ"
                            }
                           self.longTitleLabel.text  = greet + " " + (self.dashBoardResponse?.dashData?.dashboardData?.personIncharge)!
                        }
                        
                        
                        
                        UserDefaults.standard.setValue((self.dashBoardResponse?.dashData?.dashboardData?.accountNumber)!, forKey: "account_Number")
                        UserDefaults.standard.setValue((self.dashBoardResponse?.dashData?.dashboardData?.accountBalance)!, forKey: "account_balance")

                        
                        self.txtAccBal.text = self.dashBoardResponse?.dashData?.dashboardData?.accountBalance
                        let downloadURL = NSURL(string: (self.dashBoardResponse?.dashData?.dashboardData?.companyLogo)!)!
                        if downloadURL.absoluteString!.count>0 {
                            
                            self.imgMerchant.load(url: downloadURL as URL)
                        } else {
                            self.imgMerchant.backgroundColor = UIColor.black
                            self.imgMerchant.image = UIImage(named: "HomeBG")
                        }
                        // sharedDefault .setLoginStatus(loginStatus: true)
                        //sharedDefault.setAccessToken(token: (self.loginResponse?.loginData?.userData?.accessToken!)!)
                        
                        // let next = self.storyboard?.instantiateViewController(withIdentifier: "MerchantHomeVC") as! MerchantHomeVC
                        //self.navigationController?.pushViewController(next, animated: true)
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.dashBoardResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.dashBoardResponse?.message)!)
                        }
                        
                        
                        //self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.loginResponse?.message)!)
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
