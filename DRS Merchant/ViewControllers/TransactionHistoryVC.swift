//
//  TransactionHistory.swift
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

class TransactionHistoryVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    var transactionHistoryModels: TransactionHistoryModels?
    private let refreshControl = UIRefreshControl()
    var strType:String = ""
    var strTitle:String = String()
     var statusType = [String]()
    var sectionDetail = [TransactionHistory]()
    @IBOutlet var searchTransHistory: UISearchBar!
    
    @IBOutlet weak var btnAllPayment: UIButton!
    
    @IBOutlet weak var btnCash: UIButton!
    
    @IBOutlet weak var btnWallet: UIButton!
    var items = ["5,000 MMK", "10,000 MMK", "20,000 MMK","50,000 MMK", "100,000 MMK", "200,000 MMK"]
    var sectionitems = ["March 2020", "February 2020"]
    let sharedData = SharedDefault()
    
    @IBOutlet weak var collectionTransHistory: UICollectionView!
    
    let reuseIdentifier = "TransHistoryCCell"
    let reuseIdentifierheader = "SectionHeaderTransHistory"
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionDetail.count
        //return self.sectionitems.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionDetail[section].transactionHistoryValue!.count
        //return self.items.count
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        let  firstheader: SectionHeaderTransHistory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierheader, for: indexPath) as! SectionHeaderTransHistory
        
        //firstheader.strHeader = self.sectionitems[indexPath.section]
        firstheader.strHeader = self.sectionDetail[indexPath.section].date
        reusableview = firstheader
        return reusableview
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if collectionView == collectionTransHistory {
            let topupCell = collectionTransHistory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! TransHistoryCCell
            topupCell.viewBG.layer.cornerRadius = 20
            topupCell.viewBG.clipsToBounds = true
            print(self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row])
            
            if let range3 = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!.range(of: "Successful", options: .caseInsensitive){
                print(" 123 success")
                topupCell.lblStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!
                if sharedData.getLanguage() == 1 {
                    topupCell.lblStatus.text = "အောင်မြင်သည်"
                } else if sharedData.getLanguage() == 0 {
                    topupCell.lblStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!.range(of: "Pending", options: .caseInsensitive){
                print(" 123 Pending")
                topupCell.lblStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!
                if sharedData.getLanguage() == 1 {
                    topupCell.lblStatus.text = "ဆိုင်းငံ့ထား"
                } else if sharedData.getLanguage() == 0 {
                    topupCell.lblStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!
                }
            }
            if let range3 = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!.range(of: "Unsuccessful", options: .caseInsensitive){
                print(" 123 Unsuccessful")
                topupCell.lblStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
                //topupCell.lblStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!
                if sharedData.getLanguage() == 1 {
                    topupCell.lblStatus.text = "မအောင်မြင်"
                } else if sharedData.getLanguage() == 0 {
                    topupCell.lblStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].status)!
                }
            }
            
            topupCell.lblTransType.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].paymentType)!
            
            
            if topupCell.lblTransType.text == "Cash" || topupCell.lblTransType.text == "CASH"
            {
                if sharedData.getLanguage() == 1
                {
                    topupCell.lblTransType.text = "ငွေသား"
                }
                else if sharedData.getLanguage() == 0
                {
                    topupCell.lblTransType.text = "Cash"
                }
                
            }
            
            if topupCell.lblTransType.text == "Wallet" || topupCell.lblTransType.text == "WALLET"
            {
                if sharedData.getLanguage() == 1
                {
                    topupCell.lblTransType.text = "ပိုက်ဆံအိတ်"
                }
                else if sharedData.getLanguage() == 0
                {
                    topupCell.lblTransType.text = "Wallet"
                }
                
            }
            
            if sharedData.getLanguage() == 1
            {
                 topupCell.lblTransText.text = "ကွမ်းခြံကုန်း"
            }
            else if sharedData.getLanguage() == 0
            {
                 topupCell.lblTransText.text = "TransactionID"
            }
            topupCell.lblAmt.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].amount)!
            topupCell.lblTransStatus.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].transactionId)!
            
           
            topupCell.lblDateTime.text = (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].paidOn)!
            
            
            if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
                topupCell.widthViewBG.constant = 340
            }
            else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                topupCell.widthViewBG.constant = 370
                
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
                topupCell.widthViewBG.constant = 370
            }
            else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
                topupCell.widthViewBG.constant = 370
                
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                
                topupCell.widthViewBG.constant = 370
            }
            else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                
                topupCell.widthViewBG.constant = 370
            }
            else {
                topupCell.widthViewBG.constant = 370
                
            }
            
            cell = topupCell
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let next = self.storyboard?.instantiateViewController(withIdentifier: "TransDetailVC") as! TransDetailVC
        next.strTransId =  (self.sectionDetail[indexPath.section].transactionHistoryValue![indexPath.row].id)!
        self.navigationController?.pushViewController(next, animated: true)
    }
    func changeLanguage() {
           let sharedDefault = SharedDefault()
           if sharedDefault.getLanguage() == 1 {
               print("changeLanguage")
              
               let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                
                  
                if let text = xml.resource.Transaction_History.text {
                    print("btnNext",text)
                    strTitle = text
                    
                }
                
                if let text = xml.resource.Transaction_Hitory_Im_looking_for.text {
                    print("btnNext",text)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchTransHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchTransHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                    
                    
                    
                }
               
                  
                   if let text = xml.resource.Transaction_History_All_Payment.text {
                        btnAllPayment.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Wallet.text {
                     btnWallet.setTitle(text, for: .normal)
                     print("btnNext",text)
                 
                }
                   if let text = xml.resource.Transaction_History_Cash.text {
                        btnCash.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Successful.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                }
                if let text = xml.resource.Transaction_History_Pending.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                 //statusType
                }
                if let text = xml.resource.Transaction_History_Unsuccessful.text {
                     
                     print("btnNext",text)
                     statusType.append(text)
                 //statusType
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
                
                  
                if let text = xml.resource.Transaction_History.text {
                    print("btnNext",text)
                    strTitle = text
                    
                }
                
                if let text = xml.resource.Transaction_Hitory_Im_looking_for.text {
                    print("btnNext",text)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchTransHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchTransHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                }
               
                  
                   if let text = xml.resource.Transaction_History_All_Payment.text {
                        btnAllPayment.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Wallet.text {
                     btnWallet.setTitle(text, for: .normal)
                     print("btnNext",text)
                 
                }
                   if let text = xml.resource.Transaction_History_Cash.text {
                        btnCash.setTitle(text, for: .normal)
                        print("btnNext",text)
                    
                   }
                if let text = xml.resource.Transaction_History_Successful.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                }
                if let text = xml.resource.Transaction_History_Pending.text {
                     
                     print("btnNext",text)
                    statusType.append(text)
                 //statusType
                }
                if let text = xml.resource.Transaction_History_Unsuccessful.text {
                     
                     print("btnNext",text)
                     statusType.append(text)
                 //statusType
                }
                   
               }
               catch(_){print("error")}
               
               
           }
           
       }
    

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ForgotPwdVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        btnAllPayment.layer.cornerRadius = 10
        btnCash.layer.cornerRadius = 10
        btnWallet.layer.cornerRadius = 10
        
        collectionTransHistory.delegate = self
        collectionTransHistory.dataSource = self
        
        
        
        searchTransHistory.barTintColor = UIColor.clear
        searchTransHistory.backgroundColor = UIColor.red
        searchTransHistory.isTranslucent = true
        searchTransHistory.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
        
        
        
        if let textField = searchTransHistory.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        
        
       
        
        searchTransHistory.delegate = self
        searchTransHistory.showsCancelButton = true
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionTransHistory.refreshControl = refreshControl
        } else {
            collectionTransHistory.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        
       self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
        
        self.changeLanguage()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
           // Fetch Weather Data
           //fetchWeatherData()
        if searchTransHistory.text == ""
        {
           print("Fetch Weather Data")
           refreshControl.endRefreshing()
        searchTransHistory.text = ""
           self.getTransactionDetails(searchKey: "", filter: strType, lastDate: self.sectionDetail[sectionDetail.count-1].date!)
           //(date: ,searchData: "")
        }
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.searchTransHistory.text = ""
                  print("searchBarCancelButtonClicked")
                self.searchTransHistory.resignFirstResponder()
                self.sectionDetail.removeAll()
                self.getTransactionDetails(searchKey: "", filter: "", lastDate: "")
            }
        }
    }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
              print("Search bar",searchBar.text!)
              searchTransHistory.resignFirstResponder()
              self.getTransactionDetails(searchKey: searchBar.text!, filter: strType, lastDate: "")
              
          }
          func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
          {searchTransHistory.text = ""
              print("searchBarCancelButtonClicked")
              searchTransHistory.resignFirstResponder()
            self.sectionDetail.removeAll()
            self.getTransactionDetails(searchKey: "", filter: "", lastDate: "")
          }
    
       @IBAction func btnAllPaymentAction(_ sender: UIButton) {
         self.sectionDetail.removeAll()
            strType = ""
           btnCash.backgroundColor = UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
           btnWallet.backgroundColor =  UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
            btnAllPayment.backgroundColor = Constants.textColor
           self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
       }
       @IBAction func btnWalletAction(_ sender: UIButton) {
         self.sectionDetail.removeAll()
           strType = "wallet"
           btnCash.backgroundColor = UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
           btnAllPayment.backgroundColor =  UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
           btnWallet.backgroundColor = Constants.textColor
           self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
       }
       
       @IBAction func btnCashAction(_ sender: UIButton) {
        self.sectionDetail.removeAll()
           strType = "cash"
           
           btnWallet.backgroundColor = UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
           btnAllPayment.backgroundColor =  UIColor(red: 109.0/255.0, green: 196.0/255.0, blue: 147.0/255.0, alpha: 1.0)
           btnCash.backgroundColor = Constants.textColor
           
           self.getTransactionDetails(searchKey: "", filter: strType, lastDate: "")
       }
     
       func getTransactionDetails(searchKey:String,filter:String,lastDate:String) {
           let sharedData = SharedDefault()
           self.view.activityStartAnimating()
           var postDict = Dictionary<String,String>()//11469118
           postDict = ["access_token":sharedData.getAccessToken(),
                       //"access_token":"11469118",
                       
                       "search_key":searchKey,
                       "filter":filter,
                       "last_date":lastDate
               
           ]
           
           print("PostData: ",postDict)
           let loginURL = Constants.baseURL+Constants.TranssationHistoryURL
           print("loginURL",loginURL)
           
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
                
                       self.transactionHistoryModels = TransactionHistoryModels(response)
                       print("self.transactionHistoryModel ",self.transactionHistoryModels!)
                    
                       
                       
                    let statusCode = Int((self.transactionHistoryModels?.httpcode)!)
                    if statusCode == 200{
                        
                        if (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory!.count)!>0 && self.searchTransHistory.text!.count <= 0{
                            
                            if self.sectionDetail.count>0 {
                                self.sectionDetail .append(contentsOf: (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory)!)
                            }
                            else {
                                self.sectionDetail.removeAll()
                                self.sectionDetail = (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory)!
                            }
                            /* DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                             if (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory)!.count>0{
                             self.sectionDetail.removeAll()
                             self.sectionDetail = (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory)!
                             print("sectionDetail ",self.sectionDetail)
                             self.collectionTransHistory.reloadData()
                             //let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                             // self.navigationController?.pushViewController(next, animated: true)
                             
                             }
                             
                             }*/
                            
                        } else if (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory)!.count > 0 && self.searchTransHistory.text!.count > 0  {
                            self.sectionDetail = (self.transactionHistoryModels!.transactionHistoryModelData?.transactionHistory)!
                            self.view.activityStopAnimating()
                        }
                            
                            
                        else {
                            
                            if sharedData.getLanguage() == 1 {
                                self.showToast(message: Constants.noRecordsFoundB)
                            } else if sharedData.getLanguage() == 0 {
                                self.showToast(message: Constants.noRecordsFoundE)
                            }
                            
                        }
                        
                        
                        self.collectionTransHistory.reloadData()
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.transactionHistoryModels?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.transactionHistoryModels?.message)!)
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
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        //Bottom Refresh

        if scrollView == collectionTransHistory {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ")
                
                if searchTransHistory.text == ""
                {
                    
                
                print("Fetch Weather Data")
                refreshControl.endRefreshing()
                searchTransHistory.text = ""

                self.getTransactionDetails(searchKey: "", filter: strType, lastDate: self.sectionDetail[sectionDetail.count-1].date!)
                
                print("ofsetValue ----------------------------------> ")
                }

            }
        }
    }
}
