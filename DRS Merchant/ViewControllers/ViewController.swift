//
//  ViewController.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 4/21/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class ViewController: UIViewController,UITextFieldDelegate ,UITableViewDataSource,UITableViewDelegate{
    
    var App_Name : String? = String()
    var LOGIN_VALIDATION_MSG : String? = String()
    var languageStatus : Bool? = false
    @IBOutlet weak var btnLanguage: UIButton!
    var languageItem = [String]()//Burmese
    var languageCode = [0,1]
    @IBOutlet weak var tableLanguage: UITableView!
    @IBOutlet weak var viewCountryBg: UIView!
    @IBOutlet weak var viewLanguageTable: UIView!
    let sharedDefault = SharedDefault()
    
    @IBOutlet var btnSignUp: UIButton!
    @IBOutlet var btnForgot: UIButton!
    @IBOutlet var btnSignin: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var lblWelcome: UILabel!
    
    var loginResponse: LoginResponse?
    var loginDictionary:Dictionary<String,String> = Dictionary<String,String>()
    
    
   
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount:Int = 0
        if tableView == tableLanguage {
            tableCount = languageItem.count
        }
        return tableCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableLanguage {
            let cellBal = tableLanguage.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
            cellBal.backgroundColor = UIColor.white
            
            cellBal.selectionStyle = .none
            cellBal.lblLanguage.text = languageItem[indexPath.row]
            
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView == tableLanguage {
            btnLanguage.titleLabel?.text = languageItem[indexPath.row]
            viewCountryBg.isHidden = true
            viewLanguageTable.isHidden = true
            languageStatus = false
            sharedDefault.setLanguage(language: languageCode[indexPath.row])
            
            self.changeLanguage()
            tableLanguage.reloadData()
            print("languageItem",languageItem)
            btnLanguage.setTitle(languageItem[indexPath.row], for: .normal)
        }
        
    }
    
    
    func changeLanguage() {
        
        languageItem.removeAll()
        
        if sharedDefault.getLanguage() == 1 {
            print("Bermese")
            btnLanguage.setTitle("ဗမာ", for: .normal)
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
            var text = try String(contentsOfFile: path!)
            
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
                
                if let text = xml.resource.App_Name.text {
                    App_Name = text
                    print("text",text)
                    sharedDefault.setAppName(loginStatus: text)
                }
                if let text = xml.resource.merc_login_welcome.text {
                    lblWelcome.text = text
                    print("text",text)
                }
                if let text = xml.resource.merc_login_enter_user_name.text {
                    txtUsername.placeholder = text
                    print("text",text)
                }
                if let text = xml.resource.merc_login_enter_pass.text {
                    txtPassword.placeholder = text
                    print("text",text)
                }
                if let text = xml.resource.merc_login_sign_in.text {
                    btnSignin.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.merc_login_sign_up.text {
                    btnSignUp.setTitle(text, for: .normal)
                    print("text",text)
                    
                }
                if let text = xml.resource.LOGIN_VALIDATION_MSG.text {
                   LOGIN_VALIDATION_MSG = text
                    print("text",text)
                    
                    
                }
                
                if let text = xml.resource.merc_login_forgot_pass.text {
                    let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnForgot.setAttributedTitle(buttonTitleStr, for: .normal)
                    
                }
                
            }
            catch(_){print("error")}
        }
        else if sharedDefault.getLanguage() == 0 {
            btnLanguage.setTitle("English", for: .normal)
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                print("text",text)
                
                let xml = try! XML.parse(text)
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.App_Name.text {
                    sharedDefault.setAppName(loginStatus: text)
                }
                if let text = xml.resource.Setting_language_eng.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.Setting_language_bur.text {
                    languageItem.append(text)
                }
                if let text = xml.resource.App_Name.text {
                    App_Name = text
                    print("text",text)
                    sharedDefault.setAppName(loginStatus: text)
                }
                
                if let text = xml.resource.merc_login_welcome.text {
                    lblWelcome.text = text
                    
                }
                if let text = xml.resource.merc_login_enter_user_name.text {
                    txtUsername.placeholder = text
                    
                }
                if let text = xml.resource.merc_login_enter_pass.text {
                    txtPassword.placeholder = text
                    
                }
                if let text = xml.resource.merc_login_sign_in.text {
                    btnSignin.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.merc_login_sign_up.text {
                    btnSignUp.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.merc_login_forgot_pass.text {
                   let attrs = [
                        NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
                        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
                    var buttonTitleStr = NSMutableAttributedString(string:text, attributes:attrs)
                    btnForgot.setAttributedTitle(buttonTitleStr, for: .normal)
                    
                    
                }
                
                if let text = xml.resource.LOGIN_VALIDATION_MSG.text {
                   LOGIN_VALIDATION_MSG = text
                    print("text",text)
                    
                }
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        
      
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewCountryBg.isHidden = true
        viewLanguageTable.isHidden = true
        //self.changeLanguage()
      
        btnSignUp.layer.cornerRadius = btnSignUp.frame.size.height/2
        viewLanguageTable.layer.cornerRadius = 10
        viewLanguageTable.clipsToBounds = true
        
        tableLanguage.dataSource = self
        tableLanguage.delegate = self
        
        txtUsername.delegate = self
        txtPassword.delegate = self
        txtUsername.layer.cornerRadius = 10
        //txtUsername.placeholder =  Constants.TxtUserPlaceholder
        txtUsername.backgroundColor = UIColor.white
        
        txtPassword.layer.cornerRadius = 10
        //txtPassword.placeholder =  Constants.TxtPwdPlaceholder
        txtPassword.backgroundColor = UIColor.white
        
        btnSignin.layer.cornerRadius =  btnSignin.frame.size.height/2
        
        
        let attrs = [
            NSAttributedString.Key.foregroundColor : UIColor(red: 96.0/255.0, green: 57.0/255.0, blue: 19.0/255.0, alpha: 1.0),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        var buttonTitleStr = NSMutableAttributedString(string:"Forgot Password", attributes:attrs)
        //btnForgot.setAttributedTitle(buttonTitleStr, for: .normal)
        
        buttonTitleStr = NSMutableAttributedString(string:"Register", attributes:attrs)
        self.changeLanguage()
    }

    @IBAction func btnLanguageAction(_ sender: UIButton) {
        //self.changeLanguage()
        if languageStatus == true {
            languageStatus = false
            viewCountryBg.isHidden = true
             viewLanguageTable.isHidden = true
        }
        else {
            languageStatus = true
             viewCountryBg.isHidden = false
            viewLanguageTable.isHidden = false
        }
        
    }
    @IBAction func btnRegisterAction(_ sender: Any) {
        
       /* let next = self.storyboard?.instantiateViewController(withIdentifier: "AccountSettingVC") as! AccountSettingVC
              self.navigationController?.pushViewController(next, animated: true)*/
        
       let next = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
       self.navigationController?.pushViewController(next, animated: true)
       
        /*
        let next = self.storyboard?.instantiateViewController(withIdentifier: "CreatePwdVC") as! CreatePwdVC
        self.navigationController?.pushViewController(next, animated: true)*/
    }
    @IBAction func btnForgotAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPwdVC") as! ForgotPwdVC
        self.navigationController?.pushViewController(next, animated: true)
        
        
    }
    @IBAction func btnSigninAction(_ sender: Any) {
        
       
        if Reachability.isConnectedToNetwork() {
            if (txtUsername.text!.count<=0 || txtPassword.text!.count<=0)
            {
                self.showAlert(title: sharedDefault.getAppName(), message: LOGIN_VALIDATION_MSG!)
                
            } else {
                loginDictionary.updateValue(txtUsername.text!, forKey: "user_name")
                loginDictionary.updateValue(txtPassword.text!, forKey: "password")
                loginDictionary.updateValue("sample token", forKey: "device_token")
                loginDictionary.updateValue("iOS", forKey: "os")
                
                self.login(email: txtUsername.text!, password: txtPassword.text!)
                
            }
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
    }
    
    func login(email: String, password: String) {
        self.view.activityStartAnimating()
        var tokenStr = String()
        
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: "fcm_token"){
            print("savedValue fcm_token ----- ",savedValue)
           
            tokenStr = sharedDefault.getFcmToken()
        } else {
             sharedDefault.setFcmToken(token: sharedDefault.getNewFcmToken())
            tokenStr = sharedDefault.getNewFcmToken()
        }
        
        var postDict = Dictionary<String,String>()
        postDict = ["user_name":email,
                    "password":password,
                    "device_token":tokenStr,
                    "os":"iOS"]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.loginURL
        
        AF.request(loginURL, method: .post, parameters: postDict, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
            print("Response:***:",data.description)
            
            switch (data.result) {
            case .failure(let error) :
                self.view.activityStopAnimating()
                
                if error._code == NSURLErrorTimedOut {
                    if self.sharedDefault.getLanguage() == 1 {
                        self.showToast(message: Constants.ReqTimedOutBur)
                    }else if self.sharedDefault.getLanguage() == 0 {
                        self.showToast(message: Constants.ReqTimedOutEng)
                    }
                    
                }
                else if error._code == 4 {
                    if self.sharedDefault.getLanguage() == 1 {
                        self.showToast(message: Constants.IntServerErrorBur)
                    }else if self.sharedDefault.getLanguage() == 0 {
                        self.showToast(message: Constants.IntServerErrorEng)
                    }
                    //self.showToast(message: "Internal server error! Please try again!")
                }
                else if error._code == -1003 {
                    if self.sharedDefault.getLanguage() == 1 {
                        self.showToast(message: Constants.ServerErrorBur)
                    }else if self.sharedDefault.getLanguage() == 0 {
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
                        sharedDefault .setLoginStatus(loginStatus: true)
                        sharedDefault.setAccessToken(token: (self.loginResponse?.loginData?.userData?.accessToken!)!)
                        
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "MerchantHomeVC") as! MerchantHomeVC
                        
                        self.navigationController?.pushViewController(next, animated: true)
                    }
                    if statusCode == 400{
                        sharedDefault .setLoginStatus(loginStatus: false)
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.loginResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            
                            
                            if sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if sharedDefault.getLanguage() == 0 {
                                self.showToast(message:Constants.InvalidAccessEng )
                            }
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                let customViewControllersArray : NSArray = [newViewController]
                                self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            
                        } else
                        {
                            
                            
                            if let range3 = (self.loginResponse?.message)!.range(of: "Your account not activated yet.Please contact admin for activation.", options: .caseInsensitive){
                                
                                
                                if sharedDefault.getLanguage() == 1
                                {

                                    self.showAlert(title: sharedDefault.getAppName() , message: "သင်၏အကောင့်ကိုမဖွင့်သေးပါ။ ကျေးဇူးပြု၍ admin ကိုဆက်သွယ်ပါ")

                                }
                                else
                                {
                                    self.showAlert(title: sharedDefault.getAppName() , message: "Your account is not activated yet.Please contact admin for activation.")

                                }
                                
                            }
                            
                            if let range3 = (self.loginResponse?.message)!.range(of: "Invalid credientials", options: .caseInsensitive){
                                
                                
                                if sharedDefault.getLanguage() == 1
                                {

                                    self.showAlert(title: sharedDefault.getAppName() , message: "မမှန်ကန်သောအထောက်အထားများ")

                                }
                                else
                                {
                                    self.showAlert(title: sharedDefault.getAppName() , message: "Invalid credientials")

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
    
    
    @IBAction func testAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "SalesReportVC") as! SalesReportVC
                        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
}

