//
//  RegistrationVC.swift
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

class VerifyOTP: UIViewController,UITextFieldDelegate {
    var strHeaderTwo:String = "A Verification code has been sent to XXXXXX"
    var timer: Timer?
    @IBOutlet weak var lblHeaderTwo: UILabel!
    var time:Int = 59
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHeadOne: UILabel!
    var strTitle: String! = String()
    var loginResponse: LoginResponse?
    var otpResponse: OTPResponse?
    @IBOutlet var viewTextField: UIView!
    let sharedData = SharedDefault()
    @IBOutlet weak var txtFirst: UITextField!
    var phoneNum = String()
    var countryCode = String()
    @IBOutlet weak var btnChangePhoneNum: UIButton!
    @IBOutlet weak var btnSendOtp: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtSixth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    var otpValidationMsg:String = ""
    var otpMessagesB = [String]()
    var otpMessagesE = [String]()
    
    func getLanguageMsg() {
        let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            let xml = try! XML.parse(text)
            //<!--  Reset Password -->
            otpMessagesB.removeAll()
            if let text = xml.resource.merchant_pass_reset_success.text {
                print("merchant_pass_reset_success --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_invalid_cred.text {
                print("merchant_invalid_cred --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_pass_must_6_char.text {
                print("merchant_pass_must_6_char --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_pass_confirm_doessnot_match.text {
                print("merchant_pass_confirm_doessnot_match --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_pass_required.text {
                print("merchant_pass_required --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_otp_verify_success.text {
                print("merchant_otp_verify_success --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_ph_no_btwn_7_13_otp.text {
                print("merchant_ph_no_btwn_7_13_otp --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_ph_must_number.text {
                print("merchant_ph_must_number --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_ph_no_required_otp_verification.text {
                print("merchant_ph_no_required_otp_verification --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_cannot_fine_ph_no_otpVerify.text {
                print("merchant_cannot_fine_ph_no_otpVerify --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_otp_required.text {
                print("merchant_otp_required --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_otp_incorrect.text {
                print("merchant_otp_incorrect --------",text)
                otpMessagesB.append(text)
            }
            if let text = xml.resource.merchant_otp_incorrect_new_otp.text {
                print("merchant_otp_incorrect_new_otp --------",text)
                otpMessagesB.append(text)
            }
            
            
        }
        catch(_){print("error")}
        let path1 = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path1!)
            let xml = try! XML.parse(text)
            //<!--  Reset Password -->
            otpMessagesE.removeAll()
            if let text = xml.resource.merchant_pass_reset_success.text {
                print("merchant_pass_reset_success --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_invalid_cred.text {
                print("merchant_invalid_cred --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_pass_must_6_char.text {
                print("merchant_pass_must_6_char --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_pass_confirm_doessnot_match.text {
                print("merchant_pass_confirm_doessnot_match --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_pass_required.text {
                print("merchant_pass_required --------",text)
                otpMessagesE.append(text)
            }
            //Otp verification
            if let text = xml.resource.merchant_otp_verify_success.text {
                print("merchant_otp_verify_success --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_ph_no_btwn_7_13_otp.text {
                print("merchant_ph_no_btwn_7_13_otp --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_ph_must_number.text {
                print("merchant_ph_must_number --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_ph_no_required_otp_verification.text {
                print("merchant_ph_no_required_otp_verification --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_cannot_fine_ph_no_otpVerify.text {
                print("merchant_cannot_fine_ph_no_otpVerify --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_otp_required.text {
                print("merchant_otp_required --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_otp_incorrect.text {
                print("merchant_otp_incorrect --------",text)
                otpMessagesE.append(text)
            }
            if let text = xml.resource.merchant_otp_incorrect_new_otp.text {
                print("merchant_otp_incorrect_new_otp --------",text)
                otpMessagesE.append(text)
            }
            
            
        }
        catch(_){print("error")}
    }
    
    func changeLanguage() {
        
        if sharedData.getLanguage() == 1 {
            print("changeLanguage")
           
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                var strHead:String = ""
            let xml = try! XML.parse(text)
              
                 if let text = xml.resource.forgot_password_Veriﬁcation_codes_OTP.text {
                     lblHeadOne.text = text
                     
                 }
                 if let text = xml.resource.forgot_password_Veriﬁcation_codes_OTP.text {
                     strHead = xml.resource.forgot_password_verification_codes_sent.text!
                     
                     let strOSName:String = sharedData.getPhoneNumber() as! String
                     self.lblHeaderTwo.text = strHead + strOSName.suffix(4)
                     
                 }
                 if let text = xml.resource.forgot_password_Send_Again_OTP.text {
                     btnSendOtp.setTitle(text, for: .normal)
                     print("btnSendOtp",text)
                     
                 }
            
                 if let text = xml.resource.forgot_password_Change_Phone_number.text {
                     //btnChangePhoneNum.setTitle(text, for: .normal)
                     print("forgot_password_Change_Phone_number",text)

                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                   
                    //btnSendOtp.setAttributedTitle(buttonTitleStr, for: .normal)
                    var buttonTitleSt = NSMutableAttributedString(string:text, attributes:attrs)
                    btnChangePhoneNum.setAttributedTitle(buttonTitleSt, for: .normal)
                     
                 }
                 if let text = xml.resource.forgot_password_enter.text {
                     btnNext.setTitle(text, for: .normal)
                      print("btnNext",text)
                 }
                
                if let text = xml.resource.merchant_otp_required.text {
                    otpValidationMsg = text
                     
                }
                
                
                
                
            }
            catch(_){print("error")}
        }
        else if sharedData.getLanguage() == 0 {
         var strHead:String = ""
         
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
             if let text = xml.resource.merchant_otp_required.text {
                 otpValidationMsg = text
                  
             }
                if let text = xml.resource.forgot_password_Veriﬁcation_codes_OTP.text {
                    lblHeadOne.text = text
                    
                }
                if let text = xml.resource.forgot_password_Veriﬁcation_codes_OTP.text {
                    strHead = xml.resource.forgot_password_verification_codes_sent.text!
                    
                    let strOSName:String = sharedData.getPhoneNumber() as! String
                    self.lblHeaderTwo.text = strHead + strOSName.suffix(4)
                    
                }
                if let text = xml.resource.forgot_password_Send_Again_OTP.text {
                    //btnSendOtp.setTitle(text, for: .normal)
                    print("btnSendOtp",text)
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    
                    //btnSendOtp.setAttributedTitle(buttonTitleStr, for: .normal)
                    var buttonTitleSt = NSMutableAttributedString(string:text, attributes:attrs)
                    btnSendOtp.setAttributedTitle(buttonTitleSt, for: .normal)
                    
                }
           
                if let text = xml.resource.forgot_password_Change_Phone_number.text {
                   let attrs = [
                         NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                         NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    
                     //btnSendOtp.setAttributedTitle(buttonTitleStr, for: .normal)
                     var buttonTitleSt = NSMutableAttributedString(string:text, attributes:attrs)
                     btnChangePhoneNum.setAttributedTitle(buttonTitleSt, for: .normal)
                      
                    print("forgot_password_Change_Phone_number",text)
                    
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnNext.setTitle(text, for: .normal)
                     print("btnNext",text)
                }
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear RegistrationVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Verify OTP"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
    }
    @objc func timerMethod()  {
        
        
            print("Timer fired!")
            if self.time<=0{
                timer!.invalidate()
                self.btnSendOtp.isSelected = false
            DispatchQueue.main.async {
                self.lblTime.text =  "(59)"
                }
                self.time = 59
            } else {
                self.time = self.time  - 1
                DispatchQueue.main.async {
                self.lblTime.text =  "(" + String(self.time) + ")"
                }
            }
            
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let sharedData = SharedDefault()
        print(sharedData.getPhoneNumber() as! String)
        let strOSName:String = sharedData.getPhoneNumber() as! String
        self.lblHeaderTwo.text = "A Verification code has been sent to XXXXXX" + strOSName.suffix(4)
        viewTextField.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = btnNext.frame.size.height/2
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerMethod), userInfo: nil, repeats: true)
        txtFirst.delegate = self
        txtFirst.attributedPlaceholder = NSAttributedString(string: "- - - - - -", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
        
        txtFirst.delegate = self
        
        let attrs = [
            NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        var buttonTitleStr = NSMutableAttributedString(string:"Send Again OTP", attributes:attrs)
        //btnSendOtp.setAttributedTitle(buttonTitleStr, for: .normal)
        var buttonTitleSt = NSMutableAttributedString(string:"Change Phone Number", attributes:attrs)
        //btnChangePhoneNum.setAttributedTitle(buttonTitleSt, for: .normal)
        
        self.changeLanguage()
        self.getLanguageMsg()
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        
        txtFirst.inputAccessoryView = numberToolbar
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtFirst.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtFirst.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtFirst {
            txtFirst.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtFirst {
            if txtFirst.text!.count<=0 {
                txtFirst.attributedPlaceholder = NSAttributedString(string: "- - - - - -", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 13.0/255.0, green: 32.0/255.0, blue: 88.0/255.0, alpha: 1.0)])
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func btnNextAction(_ sender: Any) {
        
        if (txtFirst.text!.count<=0 )
        {
            
            self.showAlert(title: sharedData.getAppName(), message: otpValidationMsg)
        }
        else {
            self.verifyOTP(phone: sharedData.getPhoneNumber() as! String)
        }
        
    }
    @IBAction func btnSendOtpAction(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerMethod), userInfo: nil, repeats: true)
        self.resendOTP(phone: sharedData.getPhoneNumber() as! String)
        
    }
    @IBAction func btnChangeNumber(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func resetPassword( phone: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phone
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.ResetPwdURL
        
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
                    //print("self.loginResponse ",self.forgotPwdResponse?.forgotPwdData.)
                    
                    let statusCode = Int((self.loginResponse?.httpcode)!)
                    if statusCode == 200{
                        
                        for index in 0..<self.otpMessagesE.count {
                            if let range3 = (self.loginResponse?.message)!.range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                if self.sharedData.getLanguage() == 1 {
                                    self.showToast(message: self.otpMessagesB[index])
                                } else if self.sharedData.getLanguage() == 0 {
                                    self.showToast(message: self.otpMessagesE[index])
                                }
                            }
                        }
                        
                        
                        
                    }
                    if statusCode == 400{
                        
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
    func verifyOTP( phone: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phone,
                    "otp":txtFirst.text!
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.VerifyURL
        
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
                    self.otpResponse = OTPResponse(response)
                    print("self.otpResponse ",self.otpResponse!)
                    print("self.loginResponse ",self.otpResponse?.httpcode!)
                    //print("self.loginResponse ",self.forgotPwdResponse?.forgotPwdData.)
                    
                    let statusCode = Int((self.otpResponse?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.otpResponse?.message!)!)
                        
                        for index in 0..<self.otpMessagesE.count {
                            if let range3 = (self.otpResponse?.message)!.range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                if self.sharedData.getLanguage() == 1 {
                                    self.showToast(message: self.otpMessagesB[index])
                                } else if self.sharedData.getLanguage() == 0 {
                                    self.showToast(message: self.otpMessagesE[index])
                                }
                            }
                        }
                        
                        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "ResetPwdVC") as! ResetPwdVC
                        next.strOTP = (self.otpResponse?.oTPData?.verifyData?.otpToken!)!
                        next.PhoneNum = (self.otpResponse?.oTPData?.verifyData?.phoneNumber!)!
                        self.navigationController?.pushViewController(next, animated: true)
                        //self.navigationController?.popToRootViewController(animated: true)
                        //}
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.otpResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            //self.showToast(message:(self.otpResponse?.message!)! )
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
                           print("self.otpMessagesE.count",self.otpMessagesE)
                            for index in 0..<self.otpMessagesE.count {
                                if let range3 = (self.otpResponse?.message)!.range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                    if self.sharedData.getLanguage() == 1 {
                                        //self.showToast(message: self.otpMessagesB[index])
                                        self.showAlert(title: self.sharedData.getAppName(), message: self.otpMessagesB[index])
                                    } else if self.sharedData.getLanguage() == 0 {
                                        //self.showToast(message: self.otpMessagesE[index])
                                        self.showAlert(title: self.sharedData.getAppName(), message: self.otpMessagesE[index])
                                    }
                                }
                            }
                            
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
    
    
    
    func resendOTP( phone: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phone,
                    "country_code":countryCode
            
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.ResendOTPURL
        
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
                    //print("self.loginResponse ",self.forgotPwdResponse?.forgotPwdData.)
                    
                    let statusCode = Int((self.loginResponse?.httpcode)!)
                    if statusCode == 200{
                        //self.showToast(message: (self.loginResponse?.message!)!)
                        
                        for index in 0..<self.otpMessagesE.count {
                            if let range3 = (self.loginResponse?.message)!.range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                if self.sharedData.getLanguage() == 1 {
                                    self.showToast(message: self.otpMessagesB[index])
                                } else if self.sharedData.getLanguage() == 0 {
                                    self.showToast(message: self.otpMessagesE[index])
                                }
                            }
                        }
                        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        //let next = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTP") as! VerifyOTP
                        // self.navigationController?.pushViewController(next, animated: true)
                        //self.navigationController?.popToRootViewController(animated: true)
                        //}
                        
                        
                    }
                    if statusCode == 400{
                        
                        
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
                           print("self.otpMessagesE.count",self.otpMessagesE)
                            for index in 0..<self.otpMessagesE.count {
                                if let range3 = (self.otpResponse?.message)!.range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                    if self.sharedData.getLanguage() == 1 {
                                        //self.showToast(message: self.otpMessagesB[index])
                                        self.showAlert(title: self.sharedData.getAppName(), message: self.otpMessagesB[index])
                                    } else if self.sharedData.getLanguage() == 0 {
                                        //self.showToast(message: self.otpMessagesE[index])
                                        self.showAlert(title: self.sharedData.getAppName(), message: self.otpMessagesE[index])
                                    }
                                }
                            }
                            
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
