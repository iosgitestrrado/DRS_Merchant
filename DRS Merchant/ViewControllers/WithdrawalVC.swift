//
//  WithdrawalVC.swift
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

class WithdrawalVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var lbllink: UILabel!
    @IBOutlet weak var lblTwoData: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblOne: UILabel!
    var withdrawPageLoadModel:WithdrawPageLoadModel?
    var withdrawalModel:WithdrawalModel?
    var strTitle:String = String()
    var validateAmount:String = ""
     var validateBank:String = ""
    
    @IBOutlet weak var lblAcc: UILabel!
    
    @IBOutlet var lblBankName: UILabel!
    @IBOutlet var lblMinAmount: UILabel!
    @IBOutlet var lblProcessingCharge: UILabel!
    var strMinWithdrawal: String = ""
    var strProcessingCharge: String = " % of the withdraw amount will be charged for each transaction as processing fee."
    
    // var withdrawalModel: WithdrawalModel?
    //  var withdrawPageLoadModel: WithdrawPageLoadModel?
    var withDrawType =  String()
    var messageE = [String]()
    var messageB = [String]()
    @IBOutlet var lblAmtData: UILabel!
    @IBOutlet var txtAmount: UITextField!
    var btnBankStatus:Bool = false
    var btnWalletStatus:Bool = false
    
    @IBOutlet var btnWallet: UIButton!
    @IBOutlet var btnBank: UIButton!
    
    @IBOutlet weak var lblTerm: UILabel!
    
    @IBOutlet weak var viewBank: UIView!
    @IBOutlet weak var viewAmount: UIView!
    
    @IBOutlet var viewRadioBank: UIView!
    @IBOutlet var btnWHistory: UIButton!
    @IBOutlet var btnConfirmWithdraw: UIButton!
    
    
    @IBAction func btnBankAction(_ sender: UIButton) {
        if btnBankStatus == true {
            viewRadioBank.backgroundColor =  UIColor(red: 124.0/255.0, green: 143.0/255.0, blue: 169.0/255.0, alpha: 1.0)
            btnBankStatus = false
            withDrawType = ""
        } else {
            viewRadioBank.backgroundColor =  UIColor(red: 244.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            btnBankStatus = true
            withDrawType = "bank"
        }
        
        btnWalletStatus = false
        
    }
    
    @IBAction func btnWalletAction(_ sender: UIButton) {
        if btnWalletStatus == true {
            
            btnWalletStatus = false
            withDrawType = ""
        } else {
            
            btnWalletStatus = true
            withDrawType = "wallet"
        }
        viewRadioBank.backgroundColor =   UIColor(red: 124.0/255.0, green: 143.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        btnBankStatus = false
    }
    func getMessages() {
         
         
         
         //Forgot password
         let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
         do {
             
             var text = try String(contentsOfFile: path!)
             //print("text",text)
             
             let xml = try! XML.parse(text)
             //<!-- Wallet Withdrawal Page -->
             if let text = xml.resource.merchant_invalid_token_withdrawal.text {
                 print("merchant_invalid_token_withdrawal --------",text)
             }
             if let text = xml.resource.merchant_wallet_withdrawal.text {
                 print("merchant_wallet_withdrawal --------",text)
             }
             //<!-- Wallet Withdrawal Request -->
             if let text = xml.resource.merchant_invalid_token_withdrawal_Req.text {
                 print("merchant_invalid_token_withdrawal_Req --------",text)
             }
             if let text = xml.resource.merchant_withdrawal_req_submit.text {
                 print("merchant_withdrawal_req_submit --------",text)
             }
             if let text = xml.resource.merchant_req_failed_amount_greater.text {
                 print("merchant_req_failed_amount_greater --------",text)
             }
             if let text = xml.resource.merchant_amount_required.text {
                 print("merchant_amount_required --------",text)
             }
             //<!-- Wallet Withdrawal History -->
             if let text = xml.resource.merchant_invalid_token_withdrawal_history.text {
                 print("merchant_invalid_token_withdrawal_history --------",text)
             }
             if let text = xml.resource.merchant_wallet_withdrawal_history.text {
                 print("merchant_wallet_withdrawal_history --------",text)
             }
         }catch(_){print("error")}
         
         let path1 = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
         do {
             
             var text = try String(contentsOfFile: path1!)
             //print("text",text)
             
             let xml = try! XML.parse(text)
             //<!-- Wallet Withdrawal Page -->
             if let text = xml.resource.merchant_invalid_token_withdrawal.text {
                 print("merchant_invalid_token_withdrawal --------",text)
             }
             if let text = xml.resource.merchant_wallet_withdrawal.text {
                 print("merchant_wallet_withdrawal --------",text)
             }
             //<!-- Wallet Withdrawal Request -->
             if let text = xml.resource.merchant_invalid_token_withdrawal_Req.text {
                 print("merchant_invalid_token_withdrawal_Req --------",text)
             }
             if let text = xml.resource.merchant_withdrawal_req_submit.text {
                 print("merchant_withdrawal_req_submit --------",text)
             }
             if let text = xml.resource.merchant_req_failed_amount_greater.text {
                 print("merchant_req_failed_amount_greater --------",text)
             }
             if let text = xml.resource.merchant_amount_required.text {
                 print("merchant_amount_required --------",text)
             }
             //<!-- Wallet Withdrawal History -->
             if let text = xml.resource.merchant_invalid_token_withdrawal_history.text {
                 print("merchant_invalid_token_withdrawal_history --------",text)
             }
             if let text = xml.resource.merchant_wallet_withdrawal_history.text {
                 print("merchant_wallet_withdrawal_history --------",text)
             }
         }catch(_){print("error")}
         
         
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
                
                
                if let text = xml.resource.Withdrawal.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Withdrawal_Acc_Bal.text {
                    self.lblAcc.text = text
                }
                if let text = xml.resource.Withdrawal_Enter_amount.text {
                    self.txtAmount.placeholder = text
                }
                if let text = xml.resource.Withdrawal_Withdraw_to_link_bank.text {
                    self.lbllink.text = text
                }
                if let text = xml.resource.Withdrawal_CONFIRM.text {
                    btnConfirmWithdraw.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Withdrawal_WITHDRAWAL_HISTORY.text {
                     print("text",text)
                    btnWHistory.setTitle(text, for: .normal)
                    let attributedString = NSMutableAttributedString(string: text)
                    
                    attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributedString.length))
                    btnWHistory.titleLabel?.attributedText = attributedString
                    
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions.text {
                    self.lblTerm.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions1.text {
                    self.lblOne.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions11.text {
                    //self.lblMinAmount.text = text
                    strMinWithdrawal = text + " "
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions2.text {
                    self.lblTwo.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions22.text {
                    self.lblTwoData.text = text
                }
                if let text = xml.resource.merchant_amount_required.text {
                    validateAmount = text
                }
                
                if let text = xml.resource.merchant_withdraw_type.text {
                    validateBank = text
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
                
                
                if let text = xml.resource.Withdrawal.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Withdrawal_Acc_Bal.text {
                    self.lblAcc.text = text
                }
                if let text = xml.resource.Withdrawal_Enter_amount.text {
                    self.txtAmount.placeholder = text
                }
                if let text = xml.resource.Withdrawal_Withdraw_to_link_bank.text {
                    self.lbllink.text = text
                }
                if let text = xml.resource.Withdrawal_CONFIRM.text {
                    btnConfirmWithdraw.setTitle(text, for: .normal)
                }
                if let text = xml.resource.Withdrawal_WITHDRAWAL_HISTORY.text {
                   print("text",text)
                    let attributedString = NSMutableAttributedString(string: text)
                    
                    attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributedString.length))
                    btnWHistory.titleLabel?.attributedText = attributedString
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions.text {
                    self.lblTerm.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions1.text {
                    self.lblOne.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions11.text {
                    //self.lblMinAmount.text = text
                    strMinWithdrawal = text + " "
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions2.text {
                    self.lblTwo.text = text
                }
                if let text = xml.resource.Withdrawal_Terms_and_Conditions22.text {
                    self.lblTwoData.text = text
                }
                if let text = xml.resource.merchant_amount_required.text {
                    validateAmount = text
                }
                if let text = xml.resource.merchant_withdraw_type.text {
                    validateBank = text
                }
               
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ForgotPwdVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        
        self.addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        txtAmount.delegate = self
        
        
        viewBank.layer.cornerRadius = 10
        viewAmount.layer.cornerRadius = 10
        
        
        btnConfirmWithdraw.layer.cornerRadius = btnConfirmWithdraw.frame.size.height/2
        
        viewRadioBank.layer.cornerRadius = viewRadioBank.frame.size.height/2
        
        
        self.withdrawPageLoad()
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtAmount.inputAccessoryView = numberToolbar
        
         self.changeLanguage()
        
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtAmount.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtAmount.resignFirstResponder()
    }
    @objc func dismissKeyboard()
    {
        txtAmount.resignFirstResponder()
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    @IBAction func btnConfirmWithdrawAction(_ sender: UIButton)
    {
        if txtAmount.text!.count > 0
        {
            let minValue = Int((self.withdrawPageLoadModel!.withdrawPageLoadModeldata?.minWithdrawalAmount!)!)
            let enterValue = Int(txtAmount.text!)!
            if minValue! > enterValue
            {
                self.showToast(message: strMinWithdrawal)
                return
            }
        }
        
        if txtAmount.text!.count <= 0
        {
            self.showToast(message: validateAmount)
            return
        }
            
            
        else {
            if  btnBankStatus == true
            {
                if lblBankName.text?.count == 0
                {
                    let sharedDefault = SharedDefault()

                    if sharedDefault.getLanguage() == 1
                    {
                        self.showToast(message: "ဘဏ်အသေးစိတ်မရှိပါ")

                    }
                    else
                    {
                        self.showToast(message: "Bank details are missing")

                    }
                    
                }
                else
                {
                    self.withdrawRequest()

                }
                
                
            } else {
                self.showToast(message: validateBank)
            }
        }
        
        
    }
    @IBAction func btnWHistoryAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalHistoryVC") as! WithdrawalHistoryVC
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    
    func withdrawRequest() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken(),
                    "amount":txtAmount.text!,
                    "withdraw_type":withDrawType
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.WithDrawalPageRequestURL
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
                    self.withdrawalModel = WithdrawalModel(response)
                    print("self.withdrawalModel ",self.withdrawalModel!)
                    print("self.withdrawalModel ",self.withdrawalModel?.httpcode!)
                    
                    
                    let statusCode = Int((self.withdrawalModel?.httpcode)!)
                    if statusCode == 200{
                        //let a:Double = (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
                        //self.lblAmtData.text =  (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
                        
                        /**var strTransID = String()
                         var strDateTime = String()
                         var strAmount = String()*/
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalInfoVC") as! WithdrawalInfoVC
                            if let range3 = (self.withdrawalModel?.message)!.range(of: "Failed", options: .caseInsensitive){
                                next.withDrawStatus = true
                                next.strMessage = (self.withdrawalModel?.message)!
                            } else {
                                next.withDrawStatus = false
                            }
                            
                            
                            next.strRefNo = (self.withdrawalModel?.withdrawalModeldata?.referalWithdrawalData?.refId)!
                            //next.strDateTime = (self.withdrawalModel?.withdrawalModeldata?.referalWithdrawalData?.dateTime)!/
                            next.strBalance = (self.withdrawalModel?.withdrawalModeldata?.referalWithdrawalData?.amount)!
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.withdrawPageLoadModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.withdrawPageLoadModel?.message)!)
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
    
    
    func withdrawPageLoad() {
        let sharedData = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedData.getAccessToken()
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.WithDrawalPageLoadURL
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
                    self.withdrawPageLoadModel = WithdrawPageLoadModel(response)
                    print("self.withdrawPageLoadModel ",self.withdrawPageLoadModel)
                    print("self.withdrawPageLoadModel ",self.withdrawPageLoadModel?.httpcode!)
                    
                    print("withdrawPageLoadModel",self.withdrawPageLoadModel)
                    let statusCode = Int((self.withdrawPageLoadModel?.httpcode)!)
                    if statusCode == 200{
                        //let a:Double = (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.referalAccountBalance!)!
                        self.lblAmtData.text =  (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.walletAccountBalance!)!
                        
                        self.lblAmtData.text =  self.lblAmtData.text! + " MMK"
                        
                        self.lblMinAmount.text =  self.strMinWithdrawal + String( (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.minWithdrawalAmount!)!)
                        self.lblProcessingCharge .text = String( (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.processingFeePercent!)!) + self.strProcessingCharge
                        
                        self.lblBankName.text = (self.withdrawPageLoadModel?.withdrawPageLoadModeldata?.drsBankDataWithdraw?.bankName!)!
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "UserHomeVC") as! UserHomeVC
                            
                            //self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.withdrawPageLoadModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.withdrawPageLoadModel?.message)!)
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
    
    
}
