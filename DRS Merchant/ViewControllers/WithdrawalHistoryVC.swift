//
//  WithdrawalHistoryVC.swift
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

class WithdrawalHistoryVC:
    UIViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    var withdrawalHistoryModel: WithdrawalHistoryModel?
    var sectionDetail = [ReferralWithdrawalHistory]()
    let sharedData = SharedDefault()
    var strLabel:String = ""
    var strTitle: String! = String()
    let reuseIdentifier = "WithdrawalHistoryCCell"
    let reuseIdentifierheader = "SectionHeaderWithdrawHistory"
    private let refreshControl = UIRefreshControl()
    @IBOutlet var collectionWithdrawHistory: UICollectionView!
    @IBOutlet var searchWithdrawHistory: UISearchBar!
    @IBOutlet var viewSearch: UIView!
    var items = ["5,000 MMK", "10,000 MMK", "20,000 MMK","50,000 MMK", "100,000 MMK", "200,000 MMK"]
    var sectionitems = ["March 2020", "February 2020"]
    
    func changeLanguage() {
           
           let sharedDefault = SharedDefault()
           
           if sharedDefault.getLanguage() == 1 {
               print("changeLanguage")
               
               let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
               var text = try String(contentsOfFile: path!)
                 //print("text",text)
                 let xml = try! XML.parse(text)
                 
                if let text = xml.resource.Withdrawal_History_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                
                 if let text = xml.resource.Transaction_Details_Transaction_ID.text {
                    strLabel = text
                     print("strLabel------",strLabel)
                 }
                if let text = xml.resource.Withdrawal_Hitory_Im_looking_for.text {
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchWithdrawHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                           clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                           clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchWithdrawHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                }
               
                   
                   
               }
               catch(_){print("error")}
           } else if sharedDefault.getLanguage() == 0 {
              
               let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                  // print("text",text)
                   let xml = try! XML.parse(text)
                   
                if let text = xml.resource.Withdrawal_History_Title.text {
                                   strTitle = text
                                   self.title = strTitle
                               }
                   if let text = xml.resource.Transaction_Details_Transaction_ID.text {
                      strLabel = text
                       print("strLabel------",strLabel)
                   }
                if let text = xml.resource.Withdrawal_Hitory_Im_looking_for.text {
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchWithdrawHistory.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                           clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                           clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchWithdrawHistory.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                }
                
               }
               catch(_){print("error")}
               
               
           }
           
       }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return self.sectionDetail.count
           // return self.sectionitems.count
           
       }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //return items.count
           return self.sectionDetail[section].referralWithdrawalHistoryValue!.count
       }
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           
           var reusableview = UICollectionReusableView()
           let  firstheader: SectionHeaderWithdrawHistory = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierheader, for: indexPath) as! SectionHeaderWithdrawHistory
           firstheader.strHeader = self.sectionDetail[indexPath.section].date
           //firstheader.strHeader = self.sectionitems[indexPath.section]
           reusableview = firstheader
           return reusableview
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           var cell = UICollectionViewCell()
           if collectionView == collectionWithdrawHistory {
               let topupCell = collectionWithdrawHistory.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WithdrawalHistoryCCell
               topupCell.viewBG.layer.cornerRadius = 20
               topupCell.viewBG.clipsToBounds = true
            
            //topupCell.lblTrans.text = strLabel
               
               if let range3 = (self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status)!.range(of: "Successful", options: .caseInsensitive){
                   print(" 123 success")
                  topupCell.lblTransStatus.textColor = UIColor(red: 53.0/255.0, green: 182.0/255.0, blue: 115.0/255.0, alpha: 1.0)
                //   topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 1
                {
                    topupCell.lblTransStatus.text = "အောင်မြင်သည်"
                }
                else if sharedData.getLanguage() == 0
                {
                    topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status!
                }
               }
               if let range3 = (self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status)!.range(of: "Pending", options: .caseInsensitive){
                   print(" 123 Pending")
                topupCell.lblTransStatus.textColor = UIColor(red: 246.0/255.0, green: 148.0/255.0, blue: 29.0/255.0, alpha: 1.0)
                 //              topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 1 {
                    topupCell.lblTransStatus.text = "ဆိုင်းငံ့ထား"
                } else if sharedData.getLanguage() == 0 {
                    topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status!
                }
               }
               if let range3 = (self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status)!.range(of: "Unsuccessful", options: .caseInsensitive){
                   print(" 123 Unsuccessful")
                
                topupCell.lblTransStatus.textColor = UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)

                   //topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status!
                if sharedData.getLanguage() == 1
                {
                    topupCell.lblTransStatus.text = "မအောင်မြင်"
                } else if sharedData.getLanguage() == 0
                {
                    topupCell.lblTransStatus.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].status!
                }
               }
 
               
               
               topupCell.lblAmt.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].amount!
               topupCell.lblTransIDDat.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].transactionId!
               topupCell.lblDateTime.text = self.sectionDetail[indexPath.section].referralWithdrawalHistoryValue![indexPath.row].paidOn!
 
 
               if UIDevice.current.screenType.rawValue == "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8" {
                   topupCell.viewBGWidth.constant = 340
               }
               else if UIDevice.current.screenType.rawValue == "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus" {
                   topupCell.viewBGWidth.constant = 370
                   
               }
               else if UIDevice.current.screenType.rawValue == "iPhone XS Max or iPhone Pro Max" {
                   topupCell.viewBGWidth.constant = 370
               }
               else if UIDevice.current.screenType.rawValue == "iPhone X or iPhone XS" {
                   topupCell.viewBGWidth.constant = 370
                   
               }
               else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                   
                   topupCell.viewBGWidth.constant = 370
               }
               else if UIDevice.current.screenType.rawValue == "iPhone XR or iPhone 11" {
                   
                   topupCell.viewBGWidth.constant = 370
               }
               else {
                   topupCell.viewBGWidth.constant = 370
                   
               }
               
            if sharedData.getLanguage() == 1 {
                topupCell.lblTransIDText.text = "ကွမ်းခြံကုန်း"
            } else if sharedData.getLanguage() == 0 {
                topupCell.lblTransIDText.text = "TransactionID"
            }
               cell = topupCell
               
           }
           return cell
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // handle tap events
           print("You selected cell #\(indexPath.item)!")
           
       }
       
    
    override func viewWillAppear(_ animated: Bool) {
             print("viewWillAppear ForgotPwdVC ")
             self.navigationController?.navigationBar.isHidden = false
             self.title = strTitle
             self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
             self.addBackButton()
        //self.changeLanguage()
         }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionWithdrawHistory.delegate = self
        collectionWithdrawHistory.dataSource = self
        
        self.getWithdrawalHistory(date: "", searchData: "")
        
        searchWithdrawHistory.barTintColor = UIColor.clear
        searchWithdrawHistory.backgroundColor = UIColor.red
        searchWithdrawHistory.isTranslucent = true
        searchWithdrawHistory.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
        
        
        
        if let textField = searchWithdrawHistory.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        
       
        
        searchWithdrawHistory.delegate = self
        searchWithdrawHistory.showsCancelButton = true
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            collectionWithdrawHistory.refreshControl = refreshControl
        } else {
            collectionWithdrawHistory.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        self.changeLanguage()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
           // Fetch Weather Data
           //fetchWeatherData()
        if searchWithdrawHistory.text == ""
        {
           print("Fetch Weather Data")
          searchWithdrawHistory.text = ""
           refreshControl.endRefreshing()
           self.getWithdrawalHistory(date: self.sectionDetail[sectionDetail.count-1].date!, searchData: "")
        }
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText.isEmpty {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.sectionDetail.removeAll()
                self.searchWithdrawHistory.resignFirstResponder()
                self.getWithdrawalHistory(date: "", searchData: "")
               }
           }
       }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
           print("Search bar",searchBar.text!)
           searchWithdrawHistory.resignFirstResponder()
        
           self.getWithdrawalHistory(date: "", searchData: searchBar.text!)
           
       }
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
       {
        searchWithdrawHistory.text = ""
           print("Search bar")
        self.sectionDetail.removeAll()
           searchWithdrawHistory.resignFirstResponder()
        self.getWithdrawalHistory(date: "", searchData: "")
       }
    
    func getWithdrawalHistory(date: String,searchData: String) {
           self.view.activityStartAnimating()
           var postDict = Dictionary<String,String>()
           postDict = ["access_token":sharedData.getAccessToken(),
                       "search_key":searchData,
                       "last_date":date
               
           ]
           
           // print("PostData: ",postDict)
           let loginURL = Constants.baseURL+Constants.WithDrawalPageHistoryURL
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
                       self.withdrawalHistoryModel = WithdrawalHistoryModel(response)
                       print("self.withdrawalHistoryModel ",self.withdrawalHistoryModel!)
                       print("self.withdrawalHistoryModel ",self.withdrawalHistoryModel?.httpcode!)
                       // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                       //let sharedDefault = SharedDefault()
                       let statusCode = Int((self.withdrawalHistoryModel?.httpcode)!)
                    print("statusCode ",statusCode!)
                       if statusCode == 200{
                          print("statusCode 11 ",(self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!!)
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            if (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!.count>0 && self.searchWithdrawHistory.text!.count<=0 {
                                
                                if self.sectionDetail.count>0 {
                                     self.sectionDetail .append(contentsOf: (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!)
                                }
                                    else {
                                        self.sectionDetail = (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!
                                    }
                                   //self.sectionDetail.removeAll()
                                   //self.sectionDetail = (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!
                               // print("sectionDetail ",self.sectionDetail.count)
                                   
                                   self.collectionWithdrawHistory.reloadData()
                               }
                            else if (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!.count>0 && self.searchWithdrawHistory.text!.count>0 {
                                self.sectionDetail = (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!
                                 self.view.activityStopAnimating()
                                self.collectionWithdrawHistory.reloadData()
                            }
                            else {
                                 self.view.activityStopAnimating()
                                if self.sharedData.getLanguage() == 1 {
                                    self.showToast(message: Constants.noRecordsFoundB)
                                } else if self.sharedData.getLanguage() == 0 {
                                    self.showToast(message: Constants.noRecordsFoundE)
                                }
                                return
                            }
                              
                           }
                       }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.withdrawalHistoryModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.withdrawalHistoryModel?.message)!)
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

        if scrollView == collectionWithdrawHistory {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ")
                
                if searchWithdrawHistory.text == ""
                {
                print("Fetch Weather Data")
                searchWithdrawHistory.text = ""
                refreshControl.endRefreshing()
                self.getWithdrawalHistory(date: self.sectionDetail[sectionDetail.count-1].date!, searchData: "")
                }
                print("ofsetValue ----------------------------------> ")


            }
        }
    }
}
