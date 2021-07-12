//
//  TransDetailVC.swift
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

class TransDetailVC: UIViewController {
    var trasactionDetailModel:TrasactionDetailModel?
    var strTitle: String! = String()
    var strTransId:String = String()
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalData: UILabel!
    @IBOutlet weak var lblPaymentTypeData: UILabel!
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var viewTrans: UIView!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblTaxData: UILabel!
    @IBOutlet weak var lblGovTax: UILabel!
    @IBOutlet weak var lblProfitShare: UILabel!
    @IBOutlet weak var lblProfitShareData: UILabel!
    @IBOutlet weak var lblTaxEx: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblDateTimeData: UILabel!
    @IBOutlet weak var lblTrans: UILabel!
    @IBOutlet weak var lblTransIDData: UILabel!
    
    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblUserIDData: UILabel!
    
    //
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                
                if let text = xml.resource.Transaction_Details_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Transaction_Details_Total.text {
                    print("btnNext",text)
                    lblTotal.text = text
                    
                }
                
                if let text = xml.resource.Transaction_Details_Payment_type.text {
                    print("btnNext",text)
                    lblPaymentType.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Total_Taxation.text {
                    print("btnNext",text)
                    lblTax.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Total_Taxation_Gov.text {
                    print("btnNext",text)
                    lblGovTax.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Proﬁt_sharing_to_DRS.text {
                    print("btnNext",text)
                    lblProfitShare.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Proﬁt_sharing_to_DRS_Tax.text {
                    print("btnNext",text)
                    lblTaxEx.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Proﬁt_sharing_to_DRS_Tax.text {
                    print("btnNext",text)
                    lblTaxEx.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Date_and_time.text {
                    print("btnNext",text)
                    lblDateTime.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Date_and_time.text {
                    print("btnNext",text)
                    lblDateTime.text = text
                    
                }
                
                
                
                if let text = xml.resource.Transaction_Details_Transaction_ID.text {
                    lblTrans.text = text
                    print("btnNext",text)
                    
                }
                
                
                if let text = xml.resource.Transaction_Details_User_ID.text {
                    lblUserID.text = text
                    print("btnNext",text)
                    
                }
                if let text = xml.resource.Transaction_History_Cash.text {
                    
                    print("btnNext",text)
                    
                }
                if let text = xml.resource.Transaction_History_Successful.text {
                    
                }
                if let text = xml.resource.Transaction_History_Pending.text {
                    
                }
                if let text = xml.resource.Transaction_History_Unsuccessful.text {
                    
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
                
                if let text = xml.resource.Transaction_Details_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                
                if let text = xml.resource.Transaction_Details_Total.text {
                    print("btnNext",text)
                    lblTotal.text = text
                    
                }
                
                if let text = xml.resource.Transaction_Details_Payment_type.text {
                    print("btnNext",text)
                    lblPaymentType.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Total_Taxation.text {
                    print("btnNext",text)
                    lblTax.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Total_Taxation_Gov.text {
                    print("btnNext",text)
                    lblGovTax.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Proﬁt_sharing_to_DRS.text {
                    print("btnNext",text)
                    lblProfitShare.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Proﬁt_sharing_to_DRS_Tax.text {
                    print("btnNext",text)
                    lblTaxEx.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Proﬁt_sharing_to_DRS_Tax.text {
                    print("btnNext",text)
                    lblTaxEx.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Date_and_time.text {
                    print("btnNext",text)
                    lblDateTime.text = text
                    
                }
                if let text = xml.resource.Transaction_Details_Date_and_time.text {
                    print("btnNext",text)
                    lblDateTime.text = text
                    
                }
                
                
                
                if let text = xml.resource.Transaction_Details_Transaction_ID.text {
                    lblTrans.text = text
                    print("btnNext",text)
                    
                }
                
                
                if let text = xml.resource.Transaction_Details_User_ID.text {
                    lblUserID.text = text
                    print("btnNext",text)
                    
                }
                if let text = xml.resource.Transaction_History_Cash.text {
                    
                    print("btnNext",text)
                    
                }
                if let text = xml.resource.Transaction_History_Successful.text {
                    
                }
                if let text = xml.resource.Transaction_History_Pending.text {
                    
                }
                if let text = xml.resource.Transaction_History_Unsuccessful.text {
                    
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
        
        
        viewTrans.layer.cornerRadius = 10
        
        self.getTransactionDetailPage()
        
        lblProfitShare.text = "Profit sharing to DRS:"
        self.changeLanguage()
    }
    
    func getTransactionDetailPage() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()//11469118
        postDict = ["access_token":sharedData.getAccessToken(),
                    //"access_token":"11469118",
            "id":strTransId
            
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.TranssationDetailViewURL
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
                    
                    self.trasactionDetailModel = TrasactionDetailModel(response)
                    print("self.trasactionDetailModel ",self.trasactionDetailModel!)
                    
                    
                    
                    let statusCode = Int((self.trasactionDetailModel?.httpcode)!)
                    if statusCode == 200{
                        
                        self.lblTotalData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.total)!
                        self.lblPaymentTypeData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.paymentType)!
                        self.lblTaxData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.totalTaxation)!
                        self.lblProfitShareData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.profitSharing)!
                        self.lblDateTimeData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.dataTime)!
                        self.lblTransIDData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.transactionId)!
                        self.lblUserIDData.text = (self.trasactionDetailModel!.trasactionDetailModelData?.transactionData?.userId)!
                        
                        
                        
                        
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.trasactionDetailModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.trasactionDetailModel?.message)!)
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
