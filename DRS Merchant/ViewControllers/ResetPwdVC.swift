//
//  ResetPwdVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/11/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class ResetPwdVC: UIViewController,UITextFieldDelegate {
    @IBOutlet var lblH1: UILabel!
    @IBOutlet var lblH2: UILabel!
    var loginResponse: LoginResponse?
    var strOTP:Int = Int()
    var PhoneNum:Int = Int()
    let sharedData = SharedDefault()
    var strTitle: String! = ""
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var txtConfirmNewPwd: UITextField!
    @IBOutlet var txtNewPwd: UITextField!
    
    var emptyNewPwd:String = ""
    var emptyConfirm:String = ""
    var samePwd:String = ""
    var otpMessagesB = [String]()
    var otpMessagesE = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ForgotPwdVC ")
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        
        self.addBackButton()
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
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
               if let text = xml.resource.merchant_pass_required_reset_pwd.text {
                   print("merchant_pass_required_reset_pwd --------",text)
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
               if let text = xml.resource.merchant_pass_required_reset_pwd.text {
                   print("merchant_pass_required_reset_pwd --------",text)
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
        emptyNewPwd = ""
        emptyConfirm = ""
        samePwd = ""
        
        
        if sharedData.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                
                if let text = xml.resource.Create_Pwd_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                
                if let text = xml.resource.forgot_password_Veriﬁcation_codes_OTP.text {
                    lblH1.text = text
                }
                if let text = xml.resource.forgot_password_Create_a_password.text {
                    lblH2.text = text
                }
                if let text = xml.resource.forgot_password_enter_pass.text {
                    txtNewPwd.placeholder = text
                }
                if let text = xml.resource.forgot_password_Reenter_pass.text {
                    txtConfirmNewPwd.placeholder = text
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                if let text = xml.resource.merchant_pass_required.text {
                    emptyNewPwd = text
                }
                if let text = xml.resource.merchant_pass_confirm_doessnot_match.text {
                    emptyConfirm = text
                }
                
                
                
                
            }
            catch(_){print("error")}
        }
        else if sharedData.getLanguage() == 0 {
            
            
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.Create_Pwd_Title.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.forgot_password_Veriﬁcation_codes_OTP.text {
                    lblH1.text = text
                }
                if let text = xml.resource.forgot_password_Create_a_password.text {
                    lblH2.text = text
                }
                if let text = xml.resource.forgot_password_enter_pass.text {
                    txtNewPwd.placeholder = text
                }
                if let text = xml.resource.forgot_password_Reenter_pass.text {
                    txtConfirmNewPwd.placeholder = text
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.forgot_password_enter.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                if let text = xml.resource.merchant_pass_required.text {
                    emptyNewPwd = text
                }
                if let text = xml.resource.merchant_pass_confirm_doessnot_match.text {
                    emptyConfirm = text
                }
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        //lblH1.text = Constants.CreatePwdPageHead
        //lblH2.text = Constants.CreatePwdPageSubHead
        //btnCreatePwd .setTitle(Constants.CreatePwdPageSubmit, for: .normal)
       // txtNewPwd.placeholder = Constants.CreatePwdPagePassword
       // txtConfirmNewPwd.placeholder = Constants.CreatePwdPageRePassword
        txtConfirmNewPwd.layer.cornerRadius = 10
        txtNewPwd.layer.cornerRadius = 10
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        
        txtConfirmNewPwd.delegate = self
        txtNewPwd.delegate = self
        
        self.changeLanguage()
        self.getLanguageMsg()
    }
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        

        
       print("emptyConfirm",emptyConfirm)
        
        if txtNewPwd.text == txtConfirmNewPwd.text {
            self.resetPassword(phone: sharedData.getPhoneNumber() as! String)
        }
        else if txtNewPwd.text?.count == 0{
            self.showAlert(title: sharedData.getAppName(), message: emptyNewPwd)
        }
        else if txtConfirmNewPwd.text?.count == 0{
            self.showAlert(title: sharedData.getAppName(), message: emptyConfirm)
        }
        else{
            self.showAlert(title: sharedData.getAppName(), message: emptyConfirm)
        }
    }
    
    func resetPassword( phone: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":String(PhoneNum),
                    "otp_token":String(strOTP),
                    "password":txtNewPwd.text!,
                    "password_confirmation":txtConfirmNewPwd.text!
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
                            //var msg = self.messageForgotpwdE[index]
                            var msg:String = ""
                            if self.sharedData.getLanguage() == 1 {
                                msg = self.otpMessagesB[index]
                            } else if self.sharedData.getLanguage() == 0 {
                                msg = self.otpMessagesE[index]
                            }
                            //var msg = self.messageForgotpwdE[index]
                            
                            if let range3 = ((self.loginResponse?.message) as! String).range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                //self.showAlert(title: self.sharedData.getAppName(), message: msg)
                                self.showToast(message: msg)
                                print("showAlert")
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTP") as! VerifyOTP
                            // self.navigationController?.pushViewController(next, animated: true)
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.loginResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            self.showToast(message:(self.loginResponse?.message!)! )
                            
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
                            
                            
                            for index in 0..<self.otpMessagesE.count {
                                //var msg = self.messageForgotpwdE[index]
                                var msg:String = ""
                                if self.sharedData.getLanguage() == 1 {
                                    msg = self.otpMessagesB[index]
                                } else if self.sharedData.getLanguage() == 0 {
                                    msg = self.otpMessagesE[index]
                                }
                                //var msg = self.messageForgotpwdE[index]
                                
                                if let range3 = ((self.loginResponse?.message) as! String).range(of: self.otpMessagesE[index], options: .caseInsensitive){
                                    self.showAlert(title: self.sharedData.getAppName(), message: msg)
                                    print("showAlert")
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
