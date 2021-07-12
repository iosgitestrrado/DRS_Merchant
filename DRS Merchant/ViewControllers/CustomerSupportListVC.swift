//
//  CustomerSupportListVC.swift
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

class CustomerSupportListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    @IBOutlet var searchCustomer: UISearchBar!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet weak var tableCustSupport: UITableView!
    var msgStat: Bool = true
    var strSearch: String! = ""
    var strOffset: String! = ""
    var  successMsg:String = ""
    var  failureMsg:String = ""
    private let refreshControl = UIRefreshControl()

    var chatListModel: ChatListModel?
    var chatDeleteModel: ChatDeleteModel?
    var chatListArray = [ChatList]()
    var strTitle: String! = String()
    func updateSearchResults(for searchController: UISearchController)
    {
        print("searching")
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.strSearch = ""
                self.searchCustomer.resignFirstResponder()
                self.strOffset = ""
                self.chatListArray.removeAll()
                self.getCustomerSupportList()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Search bar",searchBar.text!)
        strSearch = searchBar.text!
        //searchCustomer.resignFirstResponder()
        strOffset = ""
        self.getCustomerSupportList()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchCustomer.text = ""
        print("Search ")
        strSearch = ""
        searchCustomer.resignFirstResponder()
        self.getCustomerSupportList()
        
    }
    @objc func deletepressed(sender: UIButton!) {
        print("tableNotification ",sender.tag)
        
        print(" self.chatListModel[sender.tag] ",String(self.chatListArray[sender.tag].chatId!))
        self.deleteChatMsg(chatID: String(self.chatListArray[sender.tag].chatId!))
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        //fetchWeatherData()
        if searchCustomer.text == ""
        {
        print("Fetch Weather Data")
        refreshControl.endRefreshing()
        self.getCustomerSupportList()
        //print("Fetch Weather Data ----- ",self.sectionDetail[sectionDetail.count-1].date!)
        //self.getWalletHistory(date: self.sectionDetail[sectionDetail.count-1].date!,searchData: "")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableCustSupport {
            let cellBal = tableCustSupport.dequeueReusableCell(withIdentifier: "CustomerSupportCell", for: indexPath) as! CustomerSupportCell
            cellBal.layer.cornerRadius = 15
            cellBal.clipsToBounds = true
            cellBal.selectionStyle = .none
            cellBal.lblHeader.text! = chatListArray[indexPath.section].name!
            if chatListArray[indexPath.section].msgType?.description == "image" {
                cellBal.lblMsg.text! = "Image"
            } else {
                cellBal.lblMsg.text! = chatListArray[indexPath.section].chatMsg!
            }
            // cellBal.lblMsg.text! = chatListArray[indexPath.section].chatMsg!
            cellBal.lblDate.text! = chatListArray[indexPath.section].date!
            cellBal.btnDelete.tag = indexPath.section
            
            cellBal.btnDelete.addTarget(self, action: #selector(deletepressed(sender:)), for: .touchUpInside)
            
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableNotification ",indexPath.row)
        print("tableNotification section ",indexPath.section)
        
        
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "MsgDetailListVC") as! MsgDetailListVC
        next.chatIDData = String(self.chatListArray[indexPath.section].chatId!)
        self.navigationController?.pushViewController(next, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  chatListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    
    @objc func btnNewMsgAction() {
        // Function body goes here
        print("addTapped")
        let next = self.storyboard?.instantiateViewController(withIdentifier: "NewMsgVC") as! NewMsgVC
        self.navigationController?.pushViewController(next, animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    func changeLanguage() {
        
        
        let sharedDefault = SharedDefault()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Customer_Support_Delete_Fail.text {
                    failureMsg = text
                }
                if let text = xml.resource.Customer_Support_Delete_Success.text {
                    successMsg = text
                }
                if let text = xml.resource.Setting_Cust_Support.text {
                    strTitle = text
                    self.title = strTitle
                    print("strTitle",text)
                }
                
                
                if let text = xml.resource.Customer_Support_Im_looking_for.text {
                    print("btnNext",text)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchCustomer.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                    let text = xml.resource.Title_Cancel.text
                    (searchCustomer.value(forKey: "cancelButton") as! UIButton).setTitle(text, for: .normal)
                    
                    
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
                if let text = xml.resource.Customer_Support_Delete_Success.text {
                    successMsg = text
                }
                if let text = xml.resource.Setting_Cust_Support.text {
                    strTitle = text
                    self.title = strTitle
                    
                    print("text",text)
                }
                if let text = xml.resource.Customer_Support_Im_looking_for.text {
                    print("btnNext",text)
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor(red: 245.0/255.0, green: 165.0/255.0, blue: 169.0/255.0, alpha: 1.0)])
                    
                    let textFieldInsideSearchBar = searchCustomer.value(forKey: "searchField") as? UITextField
                    let fonts = UIFont .boldSystemFont(ofSize: 16.0)
                    textFieldInsideSearchBar?.font = fonts
                    textFieldInsideSearchBar?.backgroundColor = UIColor.clear
                    textFieldInsideSearchBar?.borderStyle = .none
                    textFieldInsideSearchBar?.textColor = UIColor.white
                    
                    let clearButton = textFieldInsideSearchBar!.value(forKey: "clearButton") as! UIButton
                    clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
                    clearButton.tintColor = UIColor.white
                    
                }
                if let text = xml.resource.Customer_Support_Delete_Fail.text {
                    failureMsg = text
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear SettingsVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
        
        searchCustomer.barTintColor = UIColor.clear
        searchCustomer.backgroundColor = UIColor.red
        searchCustomer.isTranslucent = true
        searchCustomer.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        
        
        if let textField = searchCustomer.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = UIColor.white
        }
        
        
        searchCustomer.delegate = self
        searchCustomer.showsCancelButton = true
        self.strSearch = ""
        self.strOffset = ""
        self.chatListArray .removeAll()
        // Do any additional setup after loading the view.
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "Add"), for: .normal)
        button.addTarget(self, action:#selector(btnNewMsgAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableCustSupport.refreshControl = refreshControl
        } else {
            tableCustSupport.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
        refreshControl.tintColor = UIColor.clear
        
        tableCustSupport.delegate = self
        tableCustSupport.dataSource = self
        self.getCustomerSupportList()
        self.changeLanguage()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
    }
    
    
    func deleteChatMsg(chatID:String) {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        //120585943
        //"access_token":sharedData.getAccessToken() as String
        postDict = ["access_token":sharedData.getAccessToken() as String,
                    "chat_id":chatID
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseChatURL+Constants.DeleteURL
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
                    self.chatDeleteModel = ChatDeleteModel(response)
                    print("self.chatListModel ",self.chatListModel!)
                    //print("self.chatListModel ",self.chatListModel?.httpcode!)
                    
                    //self.chatListArray = self.chatListModel?.chatListModelData?.chatList! as! [ChatList]
                    let statusCode = Int((self.chatDeleteModel?.httpcode)!)
                    if statusCode == 200{
                        self.showToast(message: self.successMsg)
                    }
//                    print("chatListArray ----- ",self.chatListArray.count)
//
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.msgStat = false
                        self.chatListArray.removeAll()
                        self.strSearch = ""
                        self.strOffset = ""
                        self.getCustomerSupportList()
                        
                    }
                    
                    if statusCode == 400{
                        self.showAlert(title: sharedData.getAppName(), message: self.failureMsg)
                    }
                    
                    /*
                     if statusCode == 400{
                     
                     self.view.activityStopAnimating()
                     self.showAlert(title: share, message: failureMsg)
                     }
                     */
                    
                    self.view.activityStopAnimating()
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    
    func getCustomerSupportList() {
        searchCustomer.resignFirstResponder()
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        //120585943
        //"access_token":sharedData.getAccessToken() as String
        postDict = ["access_token":sharedData.getAccessToken() as String,
                    "offset":strOffset,
                    "search_key":strSearch
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseChatURL+Constants.SupportMessageListURL
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
                    self.chatListModel = ChatListModel(response)
                    print("self.chatListModel ",self.chatListModel!.chatListModelData?.offset)
                    if (self.chatListModel?.chatListModelData?.chatList!.count)!>0 {
                        let offSet = (self.chatListModel!.chatListModelData?.offset)!
                        
                        self.strOffset = String(offSet)
                        self.chatListArray = self.chatListModel?.chatListModelData?.chatList! as! [ChatList]
                        
                        print("chatListArray ----- ",self.chatListArray.count)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                            
                            
                            self.tableCustSupport.reloadData()
                            
                        }
                    } else{
                        self.view.activityStopAnimating()
                        if self.msgStat == true {
                            //self.showToast(message: "No records found")
                            if sharedData.getLanguage() == 1 {
                                self.showToast(message: Constants.noRecordsFoundB)
                            } else if sharedData.getLanguage() == 0 {
                                self.showToast(message: Constants.noRecordsFoundE)
                            }
                        } else {
                            self.msgStat = true
                        }
                        
                        return
                    }
                    //print("self.chatListModel ",self.chatListModel?.httpcode!)
                    
                    
                    /*
                     
                     if statusCode == 400{
                     
                     self.view.activityStopAnimating()
                     self.showAlert(title: Constants.APP_NAME, message: (self.chatListModel?.message)!)
                     }
                     */
                    
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

        if scrollView == tableCustSupport {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                
                print("bottomRefresh ----------------------------------> ")
                if searchCustomer.text == ""
                {
                print("Fetch Weather Data")
                refreshControl.endRefreshing()
                self.getCustomerSupportList()
                print("ofsetValue ----------------------------------> ")
                }

            }
        }
    }
}
