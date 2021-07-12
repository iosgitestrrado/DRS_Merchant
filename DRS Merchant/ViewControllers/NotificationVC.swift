//
//  NotificationVC.swift
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

class NotificationVC: UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating ,UISearchBarDelegate{
    var notifyListModelResponse: NotificationListModel?
       var sectionDetail = [NotificationsList]()
    var ofsetValue:Int = 0
    private let refreshControl = UIRefreshControl()
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var searchNotification: UISearchBar!
    var strTitle: String! = String()
    var items = ["Voucher points", "Balance in the wallet"]
    @IBOutlet weak var tableNotification: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController)
    {
        print("searching")
        /*
         let searchString = searchController.searchBar.text
         
         filtered = items.filter({ (item) -> Bool in
         let countryText: NSString = item as NSString
         
         return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
         })
         
         collectionView.reloadData()
         */
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar",searchBar.text!)
        searchNotification.resignFirstResponder()
        ofsetValue = 0
        self.getNotificationList()
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {searchNotification.text = ""
        print("Search bar tttttt")
        searchNotification.resignFirstResponder()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableNotification {
            let cellBal = tableNotification.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as! NotificationTableCell
            cellBal.layer.cornerRadius = 15
            cellBal.clipsToBounds = true
            cellBal.selectionStyle = .none
            cellBal.lblEventName.text = self.sectionDetail[indexPath.section].title
            cellBal.lblEventDate.text = self.sectionDetail[indexPath.section].notifyOn
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableNotification ",indexPath.row)
        print("tableNotification section ",indexPath.section)
        if self.sectionDetail[indexPath.section].notifyType == "news_event" {
            print("news_event")
            let next = self.storyboard?.instantiateViewController(withIdentifier: "NewsEventsVC") as! NewsEventsVC
            next.newsID = String(self.sectionDetail[indexPath.section].typeId!)
             self.navigationController?.pushViewController(next, animated: true)
            
        }
        else if self.sectionDetail[indexPath.section].notifyType == "wallet_withdraw" {
            print("wallet_withdraw")

            let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalHistoryVC") as! WithdrawalHistoryVC
           
            self.navigationController?.pushViewController(next, animated: true)
        }
        else if self.sectionDetail[indexPath.section].notifyType == "transaction" {
            print("transaction")
            
            let next = self.storyboard?.instantiateViewController(withIdentifier: "TransDetailVC") as! TransDetailVC
            next.strTransId = String(self.sectionDetail[indexPath.section].typeId!)
            self.navigationController?.pushViewController(next, animated: true)
        }
        
        else if self.sectionDetail[indexPath.section].notifyType == "support" {
            print("support")
            let next = self.storyboard?.instantiateViewController(withIdentifier: "MsgDetailListVC") as! MsgDetailListVC
            next.chatIDData = String(self.sectionDetail[indexPath.section].typeId!)
            self.navigationController?.pushViewController(next, animated: true)
        }
        else {
            print("others")
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionDetail.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 44
     }
     
     */
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear SettingsVC ")
        self.navigationController?.navigationBar.isHidden = false
        //self.title = "Notifications"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        searchNotification.barTintColor = UIColor.clear
        searchNotification.backgroundColor = UIColor.red
        searchNotification.isTranslucent = true
        
        searchNotification.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
        let sharedData = SharedDefault()
        
        
        if sharedData.getLanguage() == 1 {
            self.title = "အသိပေးချက်များ"
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "ငါအကြောင်းကြားစာရှာနေပါတယ်", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        }else if sharedData.getLanguage() == 0 {
            self.title = "Notifications"
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: " I'm looking for notification", attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
        }
        
        let textFieldInsideSearchBar = searchNotification.value(forKey: "searchField") as? UITextField
        let fonts = UIFont .boldSystemFont(ofSize: 16.0)
        textFieldInsideSearchBar?.font = fonts
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.borderStyle = .none
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        
        
        if let textField = searchNotification.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        
        
        let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white

        if sharedData.getLanguage() == 1
        {
            (searchNotification.value(forKey: "cancelButton") as! UIButton).setTitle("ဖျက်သိမ်းမည်", for: .normal)
        }
        else if sharedData.getLanguage() == 0
        {
            (searchNotification.value(forKey: "cancelButton") as! UIButton).setTitle("Cancel", for: .normal)
        }
        
        searchController.searchResultsUpdater = self
        searchNotification.delegate = self
        searchNotification.showsCancelButton = true
        
        tableNotification.delegate = self
        tableNotification.dataSource = self
        
        tableNotification.tableFooterView?.backgroundColor = UIColor.clear
        tableNotification.backgroundColor = UIColor.clear
        self.getNotificationList()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableNotification.refreshControl = refreshControl
        } else {
            tableNotification.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
    }
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        if searchNotification.text == ""
        {
        print("Fetch Weather Data")
        refreshControl.endRefreshing()
        searchNotification.text = ""
        ofsetValue = ofsetValue + 10
        self.getNotificationList()
        
        
    }
    }
    func getNotificationList() {
           self.view.activityStartAnimating()
        
        let sharedData = SharedDefault()
        var lang:String?
        if sharedData.getLanguage() == 0 {
            lang = "eng"
          
             
        } else if sharedData.getLanguage() == 1 {
             lang = "my"
        }
        
           let sharedDefault = SharedDefault()
           var postDict = Dictionary<String,String>()
           postDict = ["access_token":sharedDefault.getAccessToken(),
                       "search_key":searchNotification.text! as String,
                       "offset":String(ofsetValue),
                       "language":lang!
           ]
           
           print("PostData: ",postDict)
           let loginURL = Constants.baseURL+Constants.NotificationList
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
                   
               case .success :
                do {
                    
                    let response = JSON(data.data!)
                    self.notifyListModelResponse = NotificationListModel(response)
                    
                    let statusCode = Int((self.notifyListModelResponse?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.validateMobileModelResponse?.message)!)
                        if (self.notifyListModelResponse!.notificationsData?.notificationsList!.count)!>0 && self.searchNotification.text!.count<=0 {
                            if self.sectionDetail.count>0 {
                                self.sectionDetail .append(contentsOf: (self.notifyListModelResponse!.notificationsData?.notificationsList)!)
                            }
                            else {
                                self.sectionDetail = (self.notifyListModelResponse!.notificationsData?.notificationsList)!
                            }
                            self.tableNotification.reloadData()
                            self.view.activityStopAnimating()
                        }
                        else if (self.notifyListModelResponse!.notificationsData?.notificationsList!.count)! > 0 && (self.searchNotification.text!.count > 0)
                        {
                            
                            self.sectionDetail = (self.notifyListModelResponse!.notificationsData?.notificationsList)!
                            self.tableNotification.reloadData()
                            self.view.activityStopAnimating()
                        }
                        else {
                            self.view.activityStopAnimating()
                            
                            
                            if self.searchNotification.text!.count>0 {
                                self.searchNotification.text = ""
                                self.ofsetValue = 0
                            }
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message: Constants.noRecordsFoundB)
                            } else if sharedDefault.getLanguage() == 0 {
                                self.showToast(message: Constants.noRecordsFoundE)
                            }
                            return
                        }
                        
                        
                        
                        self.tableNotification.reloadData()
                        
                    }
                    if statusCode == 400{
                        if let range3 = (self.notifyListModelResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            //self.showToast(message:(self.validateMobileModelResponse?.message!)! )
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                let sharedDefault = SharedDefault()
                                sharedDefault .clearAccessToken()
                                sharedDefault .setLoginStatus(loginStatus: false)
                                
                                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                let customViewControllersArray : NSArray = [newViewController]
                                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        } else {
                            let sharedDefault = SharedDefault()
                            if sharedDefault.getLanguage() == 0 {
                                self.showAlert(title: Constants.APP_NAME, message: (self.notifyListModelResponse?.message)!)
                            } else if sharedDefault.getLanguage() == 1 {
                                self.showAlert(title: Constants.APP_NAME_BUR, message: (self.notifyListModelResponse?.message)!)
                            }
                            //self.showAlert(title: Constants.APP_NAME, message: (self.validateMobileModelResponse?.message)!)
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

        if scrollView == tableNotification {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ")
                if searchNotification.text == ""
                {
                print("Fetch Weather Data")
                refreshControl.endRefreshing()
                ofsetValue = ofsetValue + 10
                self.getNotificationList()
                searchNotification.text = ""
                print("ofsetValue ----------------------------------> ")

                }
            }
        }
    }
}
