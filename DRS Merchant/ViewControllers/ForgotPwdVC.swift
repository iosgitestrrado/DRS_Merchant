//
//  ForgotPwdVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import ADCountryPicker
import SwiftyXMLParser

class ForgotPwdVC: UIViewController,UITextFieldDelegate, ADCountryPickerDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var tableCountry: UITableView!
    var strTitle: String! = String()
    var messageForgotpwdE = [String]()
    var messageForgotpwdB = [String]()
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    let picker = ADCountryPicker()
    @IBOutlet var imgFlag: UIImageView!
    var validMsg:String = ""
    let sharedDefault = SharedDefault()
    
    @IBOutlet weak var lblForgotPwdHead: UILabel!
    
    @IBOutlet var viewBG: UIView!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var lblMsg: UILabel!
    
    @IBOutlet var txtDialCode: UITextField!
    
    
    var forgotPwdResponse: ForgotPwdResponse?
    var itemsImages = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsNames = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsCode = ["+95","+91", "+86" ,"+60"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsImages.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == tableCountry {
            let cellBal = tableCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
            cellBal.backgroundColor = UIColor.white
            
            cellBal.selectionStyle = .none
            cellBal.imageView?.image = UIImage(named: itemsImages[indexPath.row])
            cellBal.viewImg.layer.cornerRadius =  (cellBal.viewImg?.frame.size.height)!/2
            cellBal.imageView?.layer.cornerRadius = (cellBal.imageView?.frame.size.height)!/2
            cellBal.viewImg.clipsToBounds = true
            //promotionCell.imgviewCollection.sd_setImage(with: URL(string: self.promotionArray[indexPath.row].image!), placeholderImage: nil)
            
            cellBal.lblDialCode.text = itemsCode[indexPath.row]
            cell = cellBal
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableNotification ",indexPath.row)
        print("tableNotification section ",indexPath.section)
        txtDialCode.text = itemsCode[indexPath.row]
        imgFlag.image = UIImage(named: itemsImages[indexPath.row])
        viewCountry.isHidden = true
        
        
    }
    func getMessages() {
        
        
        
        //Forgot password
        let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
        do {
            
            var text = try String(contentsOfFile: path!)
            //print("text",text)
            
            let xml = try! XML.parse(text)
            messageForgotpwdB.removeAll()
            if let text = xml.resource.merchant_otp_sent_ph_no.text {
                print("merchant_otp_sent_ph_no --------",text)
                messageForgotpwdB.append(text)
            }
            if let text = xml.resource.merchant_ph_no_btwn_7_13_forgotpwd.text {
                print("merchant_ph_no_btwn_7_13_forgotpwd --------",text)
                messageForgotpwdB.append(text)
            }
            if let text = xml.resource.merchant_ph_no_btwn_7_13.text {
                print("merchant_ph_no_btwn_7_13 --------",text)
                messageForgotpwdB.append(text)
            }
            if let text = xml.resource.merchant_ph_must_number.text {
                print("merchant_ph_must_number --------",text)
                messageForgotpwdB.append(text)
            }
            if let text = xml.resource.merchant_ph_no_required.text {
                print("merchant_ph_no_required --------",text)
                messageForgotpwdB.append(text)
            }
            if let text = xml.resource.merchant_cannot_fine_ph_no_forgotpwd.text {
                print("merchant_cannot_fine_ph_no_forgotpwd --------",text)
                messageForgotpwdB.append(text)
            }
            if let text = xml.resource.merchant_cannot_fine_ph_no_valid.text {
                print("merchant_cannot_fine_ph_no_valid --------",text)
                messageForgotpwdB.append(text)
            }
        }catch(_){print("error")}
        
        let path1 = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
        do {
            
            var text = try String(contentsOfFile: path1!)
            //print("text",text)
            
            let xml = try! XML.parse(text)
            messageForgotpwdE.removeAll()
            if let text = xml.resource.merchant_otp_sent_ph_no.text {
                print("merchant_otp_sent_ph_no --------",text)
                messageForgotpwdE.append(text)
            }
            if let text = xml.resource.merchant_ph_no_btwn_7_13_forgotpwd.text {
                print("merchant_ph_no_btwn_7_13_forgotpwd --------",text)
                messageForgotpwdE.append(text)
            }
            if let text = xml.resource.merchant_ph_no_btwn_7_13.text {
                print("merchant_ph_no_btwn_7_13 --------",text)
                messageForgotpwdE.append(text)
            }
            if let text = xml.resource.merchant_ph_must_number.text {
                print("merchant_ph_must_number --------",text)
                messageForgotpwdE.append(text)
            }
            if let text = xml.resource.merchant_ph_no_required.text {
                print("merchant_ph_no_required --------",text)
                messageForgotpwdE.append(text)
            }
            if let text = xml.resource.merchant_cannot_fine_ph_no_forgotpwd.text {
                print("merchant_cannot_fine_ph_no_forgotpwd --------",text)
                messageForgotpwdE.append(text)
            }
            if let text = xml.resource.merchant_cannot_fine_ph_no_valid.text {
                print("merchant_cannot_fine_ph_no_valid --------",text)
                messageForgotpwdE.append(text)
            }
        }catch(_){print("error")}
        
        
    }
    
    
    func changeLanguage() {
        
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var strHead:String = ""
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                messageForgotpwdB.removeAll()
                let xml = try! XML.parse(text)
                strHead = xml.resource.forgot_password_Let_us_help_you.text! + xml.resource.forgot_password_Enter_ur_details.text!
                if let text = xml.resource.forgot_password.text {
                    strTitle = text
                    self.title = strTitle
                    
                }
                
                if let text = xml.resource.forgot_phone_reg.text {
                    //lblForgotPwdHead.text = text
                    validMsg = text
                }
                if let text = xml.resource.forgot_password.text {
                    lblForgotPwdHead.text = text
                    
                }
                if let text = xml.resource.forgot_password_Let_us_help_you.text {
                    lblMsg.text = strHead
                    
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnSubmit.setTitle(text, for: .normal)
                    
                }
                if let text = xml.resource.forgot_phone.text {
                    txtPhone.placeholder =  text
                    
                }
                //Forgot password
                
                if let text = xml.resource.merchant_otp_sent_ph_no.text {
                    print("merchant_otp_sent_ph_no --------",text)
                    messageForgotpwdB.append(text)
                }
                if let text = xml.resource.merchant_ph_no_btwn_7_13_forgotpwd.text {
                    print("merchant_ph_no_btwn_7_13_forgotpwd --------",text)
                    messageForgotpwdB.append(text)
                }
                if let text = xml.resource.merchant_ph_no_btwn_7_13.text {
                    print("merchant_ph_no_btwn_7_13 --------",text)
                    messageForgotpwdB.append(text)
                }
                if let text = xml.resource.merchant_ph_must_number.text {
                    print("merchant_ph_must_number --------",text)
                    messageForgotpwdB.append(text)
                }
                if let text = xml.resource.merchant_ph_no_required.text {
                    print("merchant_ph_no_required --------",text)
                    messageForgotpwdB.append(text)
                }
                if let text = xml.resource.merchant_cannot_fine_ph_no_forgotpwd.text {
                    print("merchant_cannot_fine_ph_no_forgotpwd --------",text)
                    messageForgotpwdB.append(text)
                }
                if let text = xml.resource.merchant_cannot_fine_ph_no_valid.text {
                    print("merchant_cannot_fine_ph_no_valid --------",text)
                    messageForgotpwdB.append(text)
                }
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            var strHead:String = ""
            
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                print("text",text)
                let xml = try! XML.parse(text)
                messageForgotpwdE.removeAll()
                strHead = xml.resource.forgot_password_Let_us_help_you.text! + xml.resource.forgot_password_Enter_ur_details.text!
                if let text = xml.resource.forgot_password.text {
                    strTitle = text
                    self.title = strTitle
                    
                }
                if let text = xml.resource.forgot_phone_reg.text {
                    //lblForgotPwdHead.text = text
                    validMsg = text
                }
                if let text = xml.resource.forgot_phone.text {
                    txtPhone.placeholder =  text
                    
                }
                if let text = xml.resource.forgot_password.text {
                    lblForgotPwdHead.text = text
                    
                }
                if let text = xml.resource.forgot_password_Let_us_help_you.text {
                    lblMsg.text = strHead
                    
                }
                if let text = xml.resource.forgot_password_enter.text {
                    btnSubmit.setTitle(text, for: .normal)
                    
                }
                //Forgot password
                
                if let text = xml.resource.merchant_otp_sent_ph_no.text {
                    print("merchant_otp_sent_ph_no --------",text)
                    messageForgotpwdE.append(text)
                }
                if let text = xml.resource.merchant_ph_no_btwn_7_13_forgotpwd.text {
                    print("merchant_ph_no_btwn_7_13_forgotpwd --------",text)
                    messageForgotpwdE.append(text)
                }
                if let text = xml.resource.merchant_ph_no_btwn_7_13.text {
                    print("merchant_ph_no_btwn_7_13 --------",text)
                    messageForgotpwdE.append(text)
                }
                if let text = xml.resource.merchant_ph_must_number.text {
                    print("merchant_ph_must_number --------",text)
                    messageForgotpwdE.append(text)
                }
                if let text = xml.resource.merchant_ph_no_required.text {
                    print("merchant_ph_no_required --------",text)
                    messageForgotpwdE.append(text)
                }
                if let text = xml.resource.merchant_cannot_fine_ph_no_forgotpwd.text {
                    print("merchant_cannot_fine_ph_no_forgotpwd --------",text)
                    messageForgotpwdE.append(text)
                }
                
                if let text = xml.resource.merchant_cannot_fine_ph_no_valid.text {
                    print("merchant_cannot_fine_ph_no_valid --------",text)
                    messageForgotpwdE.append(text)
                }
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    @IBAction func btnSelectCountryAction(_ sender: Any) {
        viewCountry.isHidden = false
        /*
         let pickerNavigationController = UINavigationController(rootViewController: picker)
         pickerNavigationController.modalPresentationStyle = .fullScreen
         self.present(pickerNavigationController, animated: true, completion: nil)
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear ForgotPwdVC ")
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        viewBG.layer.cornerRadius = 15
        viewBG.clipsToBounds = true
        txtPhone.delegate = self
        self.addBackButton()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        self.getMessages()
        
        topConstraint.constant = viewTable.frame.origin.y
        tableCountry.delegate = self
        tableCountry.dataSource = self
        // Do any additional setup after loading the view.
        picker.delegate = self
        
        /// Optionally, set this to display the country calling codes after the names
        picker.showCallingCodes = true
        
        /// Flag to indicate whether country flags should be shown on the picker. Defaults to true
        picker.showFlags = true
        
        /// The nav bar title to show on picker view
        picker.pickerTitle = "Select a Country"
        
        /// The default current location, if region cannot be determined. Defaults to US
        picker.defaultCountryCode = "US"
        
        /// Flag to indicate whether the defaultCountryCode should be used even if region can be deteremined. Defaults to false
        picker.forceDefaultCountryCode = false
        
        
        /// The text color of the alphabet scrollbar. Defaults to black
        picker.alphabetScrollBarTintColor = UIColor.black
        
        /// The background color of the alphabet scrollar. Default to clear color
        picker.alphabetScrollBarBackgroundColor = UIColor.clear
        
        /// The tint color of the close icon in presented pickers. Defaults to black
        picker.closeButtonTintColor = UIColor.black
        
        /// The font of the country name list
        picker.font = UIFont(name: "Helvetica Neue", size: 15)
        
        /// The height of the flags shown. Default to 40px
        picker.flagHeight = 30
        
        /// Flag to indicate if the navigation bar should be hidden when search becomes active. Defaults to true
        picker.hidesNavigationBarWhenPresentingSearch = true
        
        /// The background color of the searchbar. Defaults to lightGray
        picker.searchBarBackgroundColor = UIColor.lightGray
        txtPhone.layer.cornerRadius = 15
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        lblMsg .sizeToFit()
        
        
        imgFlag.image  = UIImage(named: itemsImages[0])
        txtDialCode.text  = itemsCode[0]
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtPhone.inputAccessoryView = numberToolbar
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        viewCountry.isHidden = true
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtPhone.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtPhone.resignFirstResponder()
    }
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String) {
        print("rrrr",code)
        //let dialingCode =  picker.getDialCode(countryCode: code)
        /*if code.count>0 {
         txtDialCode.text = code
         }
         imgFlag.image = picker.getFlag(countryCode: code)*/
    }
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        print("dialCode",dialCode)
        print("code",code)
        print("name",name)
        txtDialCode.text = dialCode
        let flagImage =  picker.getFlag(countryCode: code)
        // let countryName =  picker.getCountryName(countryCode: code)
        /*let dialingCode =  picker.getDialCode(countryCode: code)
         if code.count > 0 {
         txtDialCode.text = code
         }
         print("code",code)*/
        imgFlag.image = flagImage
        //print(flagImage)
        //print(countryName)
        
        
        /**
         
         let flagImage =  picker.getFlag(countryCode: code)
         
         
         /// Returns the country name for the given country code
         ///
         /// - Parameter countryCode: ISO code of country to get dialing code for
         /// - Returns: the country name for given country code if it exists
         let countryName =  picker.getCountryName(countryCode: code)
         
         
         /// Returns the country dial code for the given country code
         ///
         /// - Parameter countryCode: ISO code of country to get dialing code for
         /// - Returns: the dial code for given country code if it exists
         let dialingCode =  picker.getDialCode(countryCode: code)
         */
        
        
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() {
            if (txtPhone.text!.count<=0 )
            {
                self.showAlert(title: sharedDefault.getAppName(), message: validMsg)
            }
            else if (txtDialCode.text!.count<=0 )
            {
                self.showAlert(title: sharedDefault.getAppName(), message: "Select country code")
            }else {
                let strPhone = txtDialCode.text! + txtPhone.text!
                print("strPhone ----- ",strPhone)
                self.forgotPwd(phone: txtPhone.text!)
                
            }
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
    }
    
    func forgotPwd( phone: String) {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["phone_number":phone,"country_code":txtDialCode.text!
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.forgotPwdURL
        
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
                    self.forgotPwdResponse = ForgotPwdResponse(response)
                    print("self.loginResponse ",self.forgotPwdResponse!)
                    print("self.loginResponse ",self.forgotPwdResponse?.httpcode!)
                    //print("self.loginResponse ",self.forgotPwdResponse?.forgotPwdData.)
                    
                    let statusCode = Int((self.forgotPwdResponse?.httpcode)!)
                    if statusCode == 200{
                        let sharedData = SharedDefault()
                        sharedData .setPhoneNumber(loginStatus: self.txtPhone.text!)
                        // self.showToast(message: "Reset password OTP sent to your registered phone number!")
                        print("message",self.messageForgotpwdB)
                        if let range3 = (self.forgotPwdResponse?.message)!.range(of: "Reset password OTP sent to your registered phone number!", options: .caseInsensitive){
                            
                            if self.sharedDefault.getLanguage() == 1 {
                                self.showToast(message:"စကားဝှက်ကိုပြန်လည်စတင်ပါ OTP သည်သင်၏မှတ်ပုံတင်ထားသောဖုန်းနံပါတ်သို့ပို့သည်")
                            } else if self.sharedDefault.getLanguage() == 0 {
                               self.showToast(message:(self.forgotPwdResponse?.message)!)
                            }
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOTP") as! VerifyOTP
                            next.countryCode = self.txtDialCode.text!
                            self.navigationController?.pushViewController(next, animated: true)
                        }
                        
                        
                    }
                    if statusCode == 400{
                        
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.forgotPwdResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            if self.sharedDefault.getLanguage() == 1 {
                                self.showToast(message:Constants.InvalidAccessBur )
                            } else  if self.sharedDefault.getLanguage() == 0 {
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
                            print("showAlert",(self.forgotPwdResponse?.message) as! String )
                            print("showAlert",(self.messageForgotpwdE))
                            for index in 0..<self.messageForgotpwdE.count {
                                //var msg = self.messageForgotpwdE[index]
                                var msg:String = ""
                                if self.sharedDefault.getLanguage() == 1 {
                                    msg = self.messageForgotpwdB[index]
                                } else if self.sharedDefault.getLanguage() == 0 {
                                    msg = self.messageForgotpwdE[index]
                                }
                                //var msg = self.messageForgotpwdE[index]
                                
                                if let range3 = ((self.forgotPwdResponse?.message) as! String).range(of: self.messageForgotpwdE[index], options: .caseInsensitive){
                                    self.showAlert(title: self.sharedDefault.getAppName(), message: msg)
                                    print("showAlert")
                                }
                            }
                           
                            //self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.forgotPwdResponse?.message)!)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPhone{
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
