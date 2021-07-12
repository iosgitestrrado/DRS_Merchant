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
import PhotosUI
import Photos
import SwiftyXMLParser


class RegistrationVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate ,UITextFieldDelegate,UITextViewDelegate, UIGestureRecognizerDelegate, UITableViewDelegate,UITableViewDataSource {
    var messageArray = [String]()//Burmese
    var messageArrayEng = [String]()//Burmese
     var messageArrayBur = [String]()//Burmese
    var appName:String = ""
     var appTitle:String = ""
    //merchant_login_required
    var loginEmptyValidation:String = String()
    //merchant_pass_required
    var pwdEmptyValidation:String = String()
    //merchant_email_required
    var emailEmptyValidation:String = String()
    //merchant_pay_pin_required
    var pinEmptyValidation:String = String()
    //merchant_bus_name_required
    var bNameEmptyValidation:String = String()
    //merchant_bus_contact_no_required
    var bCNumEmptyValidation:String = String()
    //merchant_contact_btwn_7_12
    var bCNumValidation:String = String()
    
    var strTitle: String! = String()
    
    var messageList = [String]()
    
    @IBOutlet weak var lblPin: UILabel!
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var lblOperation: UILabel!
    @IBOutlet weak var lblSign: UILabel!
    @IBOutlet weak var constrainBtnSignBottom: NSLayoutConstraint!
    var signExpandStatus:Bool = true
    var operationExpandStatus:Bool = true
    var bankExpandStatus:Bool = true
    var bCompanyLogoSelected:Bool = false

    var pinExpandStatus:Bool = true
    @IBOutlet weak var stackbottom: NSLayoutConstraint!
    @IBOutlet weak var viewSignupBottom: NSLayoutConstraint!
    @IBOutlet weak var viewSignUpFirst: UIView!
    @IBOutlet weak var viewODetail: UIView!
    @IBOutlet weak var viewBankDetail: UIView!
    @IBOutlet weak var viewPinCode: UIView!
    
    @IBOutlet weak var signUpHeight: NSLayoutConstraint!
    
    var itemsImages = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsNames = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsCode = ["+95","+91", "+86" ,"+60"]
    var timeStartStr : [String] = ["12:00 AM","12:30 AM","01:00 AM","01:30 AM","02:00 AM","03:00 AM","03:30 AM","4:00 AM","4:30 AM","05:00 AM","05:30 AM","06:00 AM","06:30 AM","07:00 AM","07:30 AM","08:00 AM","08:30 AM","09:00 AM","09:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","12:00 PM","12:30 PM","01:00 PM","01:30 PM","02:00 PM","03:00 PM","03:30 PM","4:00 PM","4:30 PM","05:00 PM","05:30 PM","06:00 PM","06:30 PM","07:00 PM","07:30 PM","08:00 PM","08:30 PM","09:00 PM","09:30 PM","10:00 PM","10:30 PM","11:00 PM","11:30 PM"]
    var timeEndStr : [String] = ["12:00 AM","12:30 AM","01:00 AM","01:30 AM","02:00 AM","03:00 AM","03:30 AM","4:00 AM","4:30 AM","05:00 AM","05:30 AM","06:00 AM","06:30 AM","07:00 AM","07:30 AM","08:00 AM","08:30 AM","09:00 AM","09:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","12:00 PM","12:30 PM","01:00 PM","01:30 PM","02:00 PM","03:00 PM","03:30 PM","4:00 PM","4:30 PM","05:00 PM","05:30 PM","06:00 PM","06:30 PM","07:00 PM","07:30 PM","08:00 PM","08:30 PM","09:00 PM","09:30 PM","10:00 PM","10:30 PM","11:00 PM","11:30 PM"]
    
    
    
    
    @IBOutlet weak var pinHeight: NSLayoutConstraint!
    @IBOutlet weak var bankHeight: NSLayoutConstraint!
    @IBOutlet weak var oprationHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var txtContactDialCode: UITextField!
    @IBOutlet weak var txtOffDay: UITextField!
    @IBOutlet weak var tableCountry: UITableView!
    @IBOutlet weak var viewCountryBg: UIView!
    @IBOutlet var txtPChargePhone: UITextField!
    var startStatus:Bool = false
    var endtatus:Bool = false
    @IBOutlet weak var txtDialCode: UITextField!
    var dialStatus:Bool = false
    
    var btnOK:UIButton = UIButton()
    var btnCancel:UIButton = UIButton()
    
    var finalselectedData = String()
    var finalselectedID = String()
    
    let tableBg = UIView()
    
    var tableViewDays: UITableView  =   UITableView()
    var selectedData = [String]()
    var selectedPopDayID = [String]()
    var animals : [String]  = [String]()
    
    //selectedValues
    var selectedArray = [String]()
    //index selected row in component
    var selectedRow = 0
    
    var dataSource2 = [String]()
    
    
    var companyImgData:String = String()
    var firstImgData:String = String()
    var secondImgData:String = String()
    var thirdImgData:String = String()
    
    @IBOutlet var txtStarttime: UITextField!
    
    
    var termStatus:Bool = false
    var imgStatusValue:Int = 0
    
    @IBOutlet var imgCompany: UIImageView!
    @IBOutlet var lblCompanyLogo: UILabel!
    @IBOutlet var btnCompanyLogo: UIButton!
    var imagePicker = UIImagePickerController()
    @IBOutlet var btnImgF: UIButton!
    @IBOutlet var btnImgS: UIButton!
    @IBOutlet var btnImgT: UIButton!
    @IBOutlet var lblCompany: UILabel!
    var selectedCountryID:Int = Int()
    var selectedCategoryID:Int = Int()
    var selectedDayID:Int = Int()
    
    var selectedprofitID:Int = Int()
    var selectedserviceTaxID:Int = Int()
    var selectedgovTaxID:Int = Int()
    var selectedRegionID:Int = Int()
    
    var countryStatus:Bool = false
    var regionStatus:Bool = false
    var categoryStatus:Bool = false
    var dayStatus:Bool = false
    var profitStatus:Bool = false
    var serviceTaxStatus:Bool = false
    var govTaxStatus:Bool = false
    
    let sharedDefault = SharedDefault()
    var signUpDropDownResponse: SignUpDropDownResponse?
    
    var loginResponse: LoginResponse?
    var accInfoResponse: AccountInfoResponse?
    var dayResponse: DayResponse?
    var regionResponse: RegionResponse?
    var countryResponse: CountryResponse?
    var categoryResponse: CategoryResponse?
    var genInfoResponse: GenInfoResponse?
    var profitResponse: ProfitResponse?
    var picker = UIPickerView()
    let toolBar = UIToolbar()
    var pickerData = [String]()
    var govTaxResponse: GovTaxResponse?
    var servTaxResponse: ServiceTaxResponse?
    
    @IBOutlet var cb1: CheckBox!
    
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var scrollRegister: UIScrollView!
    @IBOutlet weak var viewScroll: UIView!
    
    @IBOutlet var viewSignUp: UIView!
    
    @IBOutlet weak var txtLoginId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDRSReferral: UITextField!
    @IBOutlet weak var txtDRSUserId: UITextField!
    
    @IBOutlet var viewOperation: UIView!
    @IBOutlet weak var txtBusName: UITextField!
    @IBOutlet weak var txtBusAddress: UITextField!
    @IBOutlet weak var txtBusCountry: UITextField!
    @IBOutlet weak var txtBusRegion: UITextField!
    @IBOutlet weak var txtBusCategory: UITextField!
    @IBOutlet weak var txtBusCNum: UITextField!
    @IBOutlet weak var txtBusOpHr: UITextField!
    @IBOutlet weak var txtBusOffDay: UITextField!
    @IBOutlet weak var txtBusServiceTax: UITextField!
    @IBOutlet weak var txtBusGovTax: UITextField!
    @IBOutlet weak var txtBusProfit: UITextField!
    @IBOutlet weak var txtBusSpecial: UITextField!
    @IBOutlet weak var txtBusCertificate: UITextField!
    @IBOutlet weak var txtBusDirectorName: UITextField!
    @IBOutlet weak var txtBusICNum: UITextField!
    @IBOutlet weak var txtBusCName: UITextField!
    @IBOutlet weak var txtBusContactNum: UITextField!
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtswiftCode: UITextField!
    @IBOutlet weak var txtBranchAddress: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var txtHolderName: UITextField!
    @IBOutlet weak var txtAccNum: UITextField!
    var countryID = [Int]()
    var countryName = [String]()
    var categoryID = [Int]()
    var categoryName = [String]()
    var dayID = [Int]()
    var dayName = [String]()
    
    var regionID = [Int]()
    var regionName = [String]()
    
    var profitID = [Int]()
    var profitName = [String]()
    
    var serviceTaxID = [Int]()
    var serviceTaxName = [String]()
    
    var govTaxID = [Int]()
    var govTaxName = [String]()
    var pickerStatus:Int = 0
    
    @IBOutlet var viewBusInfo: UIView!
    @IBOutlet var viewBankInfo: UIView!
    @IBOutlet var viewPin: UIView!
    @IBOutlet var lblAgree: UILabel!
    
    
    @IBOutlet var txtTerms: UITextView!
    
    
    /**
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
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var myCGFloat = CGFloat(0.0)
        if tableView == tableViewDays {
            myCGFloat = 40.0
        } else if tableView == tableCountry {
            myCGFloat = 50.0;//Choose your custom row height
        }
        return myCGFloat
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var intCount:Int = 0
        
        if tableView == tableViewDays {
            intCount = animals.count
        } else if tableView == tableCountry  {
            intCount = itemsCode.count
        }
        return intCount
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewDays {
            let cells = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cells.textLabel?.text = animals[indexPath.row]
            cells.selectionStyle = .none
            if selectedData.contains(animals[indexPath.row]) {
                cells.accessoryType = .checkmark
            }else{
                cells.accessoryType = .none
            }
            return cells
        }
            
        else if tableView == tableCountry  {
            let cellBal = tableCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
            cellBal.backgroundColor = UIColor.white
            
            cellBal.selectionStyle = .none
            cellBal.imageView?.image = UIImage(named: itemsImages[indexPath.row])
            //cellBal.viewImg.layer.cornerRadius =  (cellBal.viewImg?.frame.size.height)!/2
            //cellBal.imageView?.layer.cornerRadius = (cellBal.imageView?.frame.size.height)!/2
            //cellBal.viewImg.clipsToBounds = true
            
            cellBal.lblDialCode.text = itemsCode[indexPath.row]
            return cellBal
        }
        
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewDays {
            
            print("selectedData y ",selectedPopDayID)
            
            if selectedData.contains(animals[indexPath.row]) {
                print("selectedData y ")
                
                selectedData.removeLast()
                selectedPopDayID.removeLast()
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }else {
                print("selectedData N ")
                if dayID[indexPath.row] == 0{
                    selectedData.removeAll()
                    selectedPopDayID.removeAll()
                    selectedData.append(animals[indexPath.row])
                    selectedPopDayID.append(String(dayID[indexPath.row]))
                    
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    
                    
                } else {
                    var indexi:Int = 0
                    var indexs:Int?
                    var regionStatus:Bool = false
                    for item in selectedPopDayID {
                        
                        if item == "0" {
                            regionStatus = true
                            indexs = indexi
                        }
                        indexi = indexi + 1
                    }
                    if regionStatus == true {
                        selectedData.remove(at: indexs!)
                        selectedPopDayID.remove(at: indexs!)
                        
                    }
                    
                    selectedData.append(animals[indexPath.row])
                    selectedPopDayID.append(String(dayID[indexPath.row]))
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                }
                
            }
            
        }
        else if tableView == tableCountry   {
            
            if dialStatus == true {
                txtContactDialCode.text = itemsCode[indexPath.row]
                viewCountryBg.isHidden = true
                dialStatus = false
            }
            else {
                txtDialCode.text = itemsCode[indexPath.row]
                viewCountryBg.isHidden = true
                dialStatus = false
            }
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        
    }
    
    
    
    
    //Animate textfield move up/down
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("textView")
        if URL.absoluteString == "https://www.ibm.com" {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
            self.navigationController?.pushViewController(next, animated: true)
            print("first")
        } else if URL.absoluteString == "https://www.google.com" {
            print("second")
            let next = self.storyboard?.instantiateViewController(withIdentifier: "AgreementVC") as! AgreementVC
            self.navigationController?.pushViewController(next, animated: true)
        }
        //UIApplication.shared.open(URL)
        return false
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear RegistrationVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = appTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
        
       
        
        
        
        
    }
    
    @objc func buttonTapped(sender : UIButton) {
        //Write button action here
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //animateViewMoving(up: false, moveValue:205)
        //self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 1750)
        textField.resignFirstResponder()
        return true
    }
    @objc func cancelbuttonTapped(sender : UIButton) {
        //Write button action here
        tableBg .removeFromSuperview()
        tableViewDays .removeFromSuperview()
    }
    @objc func oKbuttonTapped(sender : UIButton) {
        //Write button action here
        tableBg .removeFromSuperview()
        tableViewDays .removeFromSuperview()
        
        finalselectedID = selectedPopDayID.joined(separator: ",")
        finalselectedData = selectedData.joined(separator: ",")
        //print("stringId ",stringId)
        txtBusOffDay.text = finalselectedData
        print("stringData ",finalselectedData)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //delegate method
        //self.scrollRegister.contentSize = CGSize(width: self.view.frame.size.width, height: 2000)
        /* if textField == txtLoginId{
         self.animateViewMoving(up: true, moveValue: 0)//180
         }
         else if textField == txtPassword{
         self.animateViewMoving(up: true, moveValue: 0)//180
         }
         else if textField == txtEmail{
         self.animateViewMoving(up: true, moveValue: 0)//180
         }
         else if textField == txtDRSUserId{
         self.animateViewMoving(up: true, moveValue: 0)//180
         } else {
         if textField == txtBusCountry{
         self.animateViewMoving(up: true, moveValue: 180)//180
         }
         else   if textField == txtDRSReferral{
         self.animateViewMoving(up: true, moveValue: 180)//180
         }
         else {
         self.animateViewMoving(up: true, moveValue: 205)//180
         }
         }
         
         */
        
        if textField == txtContactDialCode
        {
            if viewSignUp.isHidden {
                constraintTop.constant = 1120.0
            }
            else {
                constraintTop.constant = 1300.0
            }
            
            dialStatus = true
            textField.resignFirstResponder()
            viewCountryBg.isHidden = false
            viewTop.bringSubviewToFront(viewBankInfo)
        }
        
        if textField == txtDialCode
        {
            if viewSignUp.isHidden
            {
                constraintTop.constant = 505.0
            }
            else
            {
                constraintTop.constant = 620.0
            }
            
            textField.resignFirstResponder()
            viewCountryBg.isHidden = false
        }
        
        if textField == txtStarttime
        {
            
            pickerData = self.timeStartStr
            txtStarttime.inputView = picker
            txtStarttime.inputAccessoryView = toolBar
            pickerStatus = 8
            startStatus = true
            
        }
        else if textField == txtBusOpHr
        {
            pickerData = self.timeEndStr
            txtBusOpHr.inputView = picker
            txtBusOpHr.inputAccessoryView = toolBar
            pickerStatus = 9
            endtatus = true
            
        }
            
        else if textField == txtBusCountry
        {
            pickerData = self.countryName
            txtBusCountry.inputView = picker
            txtBusCountry.inputAccessoryView = toolBar
            pickerStatus = 1
            countryStatus = true
            
        }
        else if textField == txtBusCategory
        {
            pickerData = self.categoryName
            txtBusCategory.inputView = picker
            txtBusCategory.inputAccessoryView = toolBar
            pickerStatus = 2
            categoryStatus = true
            
        }
        else if textField == txtBusOffDay
        {
            /*
             pickerData = self.dayName
             txtBusOffDay.inputView = picker
             txtBusOffDay.inputAccessoryView = toolBar*/
            txtBusOffDay.resignFirstResponder()
            pickerStatus = 3
            dayStatus = true
            animals.removeAll()
            animals = self.dayName
            
            tableBg.frame = CGRect(x: 50, y: 70, width: self.view.frame.size.width-100, height: 420)
            tableBg.layer.cornerRadius = 10
            tableBg.clipsToBounds = true
            tableBg.backgroundColor = UIColor.white
            
            btnCancel = UIButton(frame: CGRect(x: 10, y: tableBg.frame.size.height-50, width: 100, height: 45))
            btnCancel.setTitle("Cancel", for: .normal)
            btnCancel.backgroundColor = .white
            btnCancel.setTitleColor(UIColor.red, for: .normal)
            btnCancel.addTarget(self, action: #selector(self.cancelbuttonTapped), for: .touchUpInside)
            tableBg.addSubview(btnCancel)
            btnCancel.layer.cornerRadius = btnCancel.frame.size.height/2
            
            btnOK = UIButton(frame: CGRect(x: tableBg.frame.size.width-100, y: tableBg.frame.size.height-50, width:100 , height: 45))
            btnOK.setTitle("OK", for: .normal)
            btnOK.backgroundColor = UIColor.red
            
            btnOK.setTitleColor(UIColor.white, for: .normal)
            btnOK.addTarget(self, action: #selector(self.oKbuttonTapped), for: .touchUpInside)
            tableBg.addSubview(btnOK)
            btnOK.layer.cornerRadius = btnCancel.frame.size.height/2
            
            self.view .addSubview(tableBg)
            
            //tableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
            tableViewDays = UITableView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width-100, height: 350), style: UITableView.Style.plain)
            tableViewDays.delegate      =   self
            tableViewDays.dataSource    =   self
            tableViewDays.allowsMultipleSelection = true
            
            tableViewDays.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tableBg.addSubview(self.tableViewDays)
            
            
        }
        else if textField == txtBusProfit
        {
            pickerData = self.profitName
            txtBusProfit.inputView = picker
            txtBusProfit.inputAccessoryView = toolBar
            pickerStatus = 4
            profitStatus = true
            picker.reloadAllComponents()
        }
        else if textField == txtBusGovTax
        {
            pickerData = self.govTaxName
            txtBusGovTax.inputView = picker
            txtBusGovTax.inputAccessoryView = toolBar
            pickerStatus = 5
            govTaxStatus = true
            picker.reloadAllComponents()
        }
        else if textField == txtBusServiceTax
        {
            pickerData = self.serviceTaxName
            txtBusServiceTax.inputView = picker
            txtBusServiceTax.inputAccessoryView = toolBar
            pickerStatus = 6
            serviceTaxStatus = true
            picker.reloadAllComponents()
        }
        else if textField == txtBusRegion
        {
            pickerData = self.regionName
            txtBusRegion.inputView = picker
            txtBusRegion.inputAccessoryView = toolBar
            pickerStatus = 7
            regionStatus = true
            picker.reloadAllComponents()
            
        }
        
        
    }
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollRegister.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollRegister.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollRegister.contentInset = contentInset
    }
    @IBAction func btnPinExpandAction(_ sender: Any) {
        if pinExpandStatus == true {
            
            pinHeight.constant = 86
            viewPin.isHidden = false
            pinExpandStatus = false
            
        } else {
            pinHeight.constant = 50
            viewPin.isHidden = true
            pinExpandStatus = true
        }
    }
    @IBAction func btnBankDetAction(_ sender: Any) {
        if bankExpandStatus == true {
            
            bankHeight.constant = 266
            viewBankInfo.isHidden = false
            bankExpandStatus = false
            
        } else {
            bankHeight.constant = 50
            viewBankInfo.isHidden = true
            bankExpandStatus = true
        }
    }
    
    @IBAction func btnOPDetailAction(_ sender: Any) {
        if operationExpandStatus == true {
            
            oprationHeight.constant = 1039
            viewBusInfo.isHidden = false
            operationExpandStatus = false
            
        } else {
            oprationHeight.constant = 50
            viewBusInfo.isHidden = true
            operationExpandStatus = true
        }
    }
    @IBAction func btnSignExpandAction(_ sender: UIButton) {
        
        if signExpandStatus == true {
            
            signUpHeight.constant = 245
            viewSignUp.isHidden = false
            signExpandStatus = false
            
        } else {
            signUpHeight.constant = 50
            viewSignUp.isHidden = true
            signExpandStatus = true
        }
        
    }
    func getLanguageMsg() {
           let sharedDefault = SharedDefault()
           
          
           if sharedDefault.getLanguage() == 1 {
               print("changeLanguage")
               
               let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                messageArrayBur.removeAll()
                   
                   if let text = xml.resource.merchant_register_success.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_login_id_already_taken.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_email_already_taken.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_contact_no_already_taken.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_business_contact_btwn_7_12.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_contact_btwn_7_12.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_ref_id_valid.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_pass_6_char.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_login_required.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_bus_name_required.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_email_required.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_email_required.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_bus_contact_no_required.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_pass_required.text {
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_pay_pin_required.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_contact_must_number.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_bus_contact_must_no.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_email_valid.text {
                       messageArrayBur.append(text)
                   }
                   
                   if let text = xml.resource.merchant_register_success.text {
                       print("merchant_register_success --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_login_id_already_taken.text {
                       print("merchant_login_id_already_taken --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_email_already_taken.text {
                       print("merchant_email_already_taken --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_contact_no_already_taken.text {
                       print("merchant_contact_no_already_taken --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_business_contact_btwn_7_12.text {
                       print("merchant_business_contact_btwn_7_12 --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_contact_btwn_7_12.text {
                       print("merchant_contact_btwn_7_12 --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_ref_id_valid.text {
                       print("merchant_ref_id_valid --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_pass_6_char.text {
                       print("merchant_pass_6_char --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_login_required.text {
                       print("merchant_login_required --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_bus_name_required.text {
                       print("merchant_bus_name_required --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_email_required.text {
                       print("merchant_email_required --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_bus_contact_no_required.text {
                       print("merchant_bus_contact_no_required --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_pass_required.text {
                       print("merchant_pass_required --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_pay_pin_required.text {
                       print("merchant_pay_pin_required --------",text)
                       messageArray.append(text)
                   }
                   if let text = xml.resource.merchant_contact_must_number.text {
                       print("merchant_contact_must_number --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_bus_contact_must_no.text {
                       print("merchant_bus_contact_must_no --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_email_valid.text {
                       print("merchant_email_valid --------",text)
                       messageArrayBur.append(text)
                   }
                   if let text = xml.resource.merchant_dial_code.text {
                       print("merchant_dial_code --------",text)
                       messageArrayBur.append(text)
                   }
                   
                   
                   
               }
               catch(_){print("error")}
           } else if sharedDefault.getLanguage() == 0 {
               
               let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
               do {
                   var text = try String(contentsOfFile: path!)
                   //print("text",text)
                   let xml = try! XML.parse(text)
                messageArrayEng.removeAll()
                   
                   
                   if let text = xml.resource.merchant_register_success.text {
                       print("merchant_register_success --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_login_id_already_taken.text {
                       print("merchant_login_id_already_taken --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_email_already_taken.text {
                       print("merchant_email_already_taken --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_contact_no_already_taken.text {
                       print("merchant_contact_no_already_taken --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_business_contact_btwn_7_12.text {
                       print("merchant_business_contact_btwn_7_12 --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_contact_btwn_7_12.text {
                       print("merchant_contact_btwn_7_12 --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_ref_id_valid.text {
                       print("merchant_ref_id_valid --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_pass_6_char.text {
                       print("merchant_pass_6_char --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_login_required.text {
                       print("merchant_login_required --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_bus_name_required.text {
                       print("merchant_bus_name_required --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_email_required.text {
                       print("merchant_email_required --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_bus_contact_no_required.text {
                       print("merchant_bus_contact_no_required --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_pass_required.text {
                       print("merchant_pass_required --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_pay_pin_required.text {
                       print("merchant_pay_pin_required --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_contact_must_number.text {
                       print("merchant_contact_must_number --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_bus_contact_must_no.text {
                       print("merchant_bus_contact_must_no --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_email_valid.text {
                       print("merchant_email_valid --------",text)
                       messageArrayEng.append(text)
                   }
                   if let text = xml.resource.merchant_dial_code.text {
                       print("merchant_dial_code --------",text)
                       messageArrayEng.append(text)
                   }
               }
               catch(_){print("error")}
               
               
           }
           
       }
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        
        messageList.removeAll()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                
                if let text = xml.resource.business_reg.text {
                    appTitle = text
                    self.title = appTitle
                }
                
                if let text = xml.resource.App_Name.text {
                    appName = text
                }
                
                if let text = xml.resource.business_reg_submit.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                
                if let text = xml.resource.Setting_Account_Setting.text {
                    self.title = text
                }
                if let text = xml.resource.business_reg_sign_up.text { //Acc__Setting_general_info
                    self.lblSign.text = text
                }
                if let text = xml.resource.business_reg_Operation_Details.text {
                    self.lblOperation.text = text
                }
                if let text = xml.resource.business_reg_Bank_Det.text {
                    self.lblBank.text = text
                }
                if let text = xml.resource.business_reg_Payment_Pin_Code.text {
                    self.lblPin.text = text
                }
                
                if let text = xml.resource.business_reg_ur_login_id.text {
                    txtLoginId.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_pass.text {
                    txtPassword.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Email_Add.text {
                    txtEmail.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_DRS_Referral_ID.text {
                    txtDRSReferral.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_ur_DRS_User_ID.text {
                    txtDRSUserId.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Bank_Name.text {
                    txtBankName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Branch_Add.text {
                    txtBranchAddress.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Bank_Swift_Code.text {
                    txtswiftCode.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Bank_Holder_Name.text {
                    txtHolderName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Bank_Acc_Num.text {
                    txtAccNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Enter_ur_Code.text {
                    txtPin.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Business_Name.text {
                    txtBusName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Business_Add.text {
                    txtBusAddress.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Country.text {
                    txtBusCountry.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Region.text {
                    txtBusRegion.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Category.text {
                    txtBusCategory.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Start_Hr.text {
                    txtStarttime.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_End_Hr.text {
                    txtBusOpHr.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Off_Day.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                
                txtContactDialCode.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                txtDialCode.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                
                
                
                
                if let text = xml.resource.business_reg_Do_u_apply_service_tax.text {
                    self.txtBusServiceTax.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Do_u_apply_government_tax.text {
                    self.txtBusGovTax.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Profit_Sharing.text {
                    self.txtBusProfit.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Spcl_Cond.text {
                    self.txtBusSpecial.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Busns_Certificate.text {
                    self.txtBusCertificate.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Dir_Name.text {
                    self.txtBusDirectorName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Dir_IC_Num.text {
                    self.txtBusICNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Person_in_Charge.text {
                    self.txtBusCName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Contact_Num.text {
                    //self.txtBusContactNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.business_reg_Contact_Num.text {
                    self.txtPChargePhone.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_Cont_Num.text {
                    txtBusCNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Company_Logo.text {
                    lblCompanyLogo.text = text
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnImgF.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnImgS.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnImgT.setTitle(text, for: .normal)
                    print("text",text)
                }
                
                
                if let text = xml.resource.business_reg_Terms_and_Conditions.text {
                    let font = UIFont.systemFont(ofSize: 16)
                   // let attributedString = NSMutableAttributedString(string: "I have read and agree Terms and Conditions, and Agreement.")
                    let attributedString = NSMutableAttributedString(string: text)
                       let style = NSMutableParagraphStyle()
                       style.lineSpacing = 50.5
                       
                    let linkAttributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor:  UIColor.red,
                        NSAttributedString.Key.underlineColor: UIColor.red,
                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                        NSAttributedString.Key.paragraphStyle : style
                    ]
                    
                    attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 22, length: 21))
                    attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 54, length: 15))//9
                       attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: text.count))
                       
                    let mutableParagraphStyle = NSMutableParagraphStyle()
                                   // Customize the line spacing for paragraph.
                    mutableParagraphStyle.lineSpacing = CGFloat(15.0)
                    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, attributedString.length))
                    
                    attributedString.addAttributes(linkAttributes, range: NSRange(location: 22, length: 21))
                    
                    txtTerms.linkTextAttributes = linkAttributes
                    txtTerms.isEditable = false
                    txtTerms.delegate=self
                    txtTerms.attributedText = attributedString
                    }
                
                if let text = xml.resource.merchant_register_success.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_login_id_already_taken.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_email_already_taken.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_contact_no_already_taken.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_business_contact_btwn_7_12.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_contact_btwn_7_12.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_ref_id_valid.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_pass_6_char.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_login_required.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_bus_name_required.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_email_required.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_email_required.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_bus_contact_no_required.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_pass_required.text {
                    messageList.append(text)
                }
                if let text = xml.resource.merchant_pay_pin_required.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_contact_must_number.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_bus_contact_must_no.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_email_valid.text {
                    messageList.append(text)
                }
                
                if let text = xml.resource.merchant_register_success.text {
                    print("merchant_register_success --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_login_id_already_taken.text {
                    print("merchant_login_id_already_taken --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_email_already_taken.text {
                    print("merchant_email_already_taken --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_contact_no_already_taken.text {
                    print("merchant_contact_no_already_taken --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_business_contact_btwn_7_12.text {
                    print("merchant_business_contact_btwn_7_12 --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_contact_btwn_7_12.text {
                    print("merchant_contact_btwn_7_12 --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_ref_id_valid.text {
                    print("merchant_ref_id_valid --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_pass_6_char.text {
                    print("merchant_pass_6_char --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_login_required.text {
                    print("merchant_login_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_bus_name_required.text {
                    print("merchant_bus_name_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_email_required.text {
                    print("merchant_email_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_bus_contact_no_required.text {
                    print("merchant_bus_contact_no_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_pass_required.text {
                    print("merchant_pass_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_pay_pin_required.text {
                    print("merchant_pay_pin_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_contact_must_number.text {
                    print("merchant_contact_must_number --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_bus_contact_must_no.text {
                    print("merchant_bus_contact_must_no --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_email_valid.text {
                    print("merchant_email_valid --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_dial_code.text {
                    print("merchant_dial_code --------",text)
                    messageArray.append(text)
                }
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
            
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                 
                if let text = xml.resource.business_reg.text {
                    appTitle = text
                    self.title = appTitle
                }
                
                if let text = xml.resource.App_Name.text {
                    appName = text
                }

                if let text = xml.resource.business_reg_Terms_and_Conditions.text {
                    let font = UIFont.systemFont(ofSize: 16)
                   // let attributedString = NSMutableAttributedString(string: "I have read and agree Terms and Conditions, and Agreement.")
                    let attributedString = NSMutableAttributedString(string: text)
                    let linkAttributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor:  UIColor.red,
                        NSAttributedString.Key.underlineColor: UIColor.red,
                        NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                    ]
                    
                    attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 22, length: 21))
                    attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 48, length: 9))
                    attributedString.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: 57))
                    
                    attributedString.addAttributes(linkAttributes, range: NSRange(location: 22, length: 21))
                    
                    txtTerms.linkTextAttributes = linkAttributes
                    txtTerms.isEditable = false
                    txtTerms.delegate=self
                    txtTerms.attributedText = attributedString
                    }
                if let text = xml.resource.Setting_Account_Setting.text {
                    self.title = text
                }
                if let text = xml.resource.business_reg_sign_up.text { //Acc__Setting_general_info
                    self.lblSign.text = text
                }
                if let text = xml.resource.business_reg_Operation_Details.text {
                    self.lblOperation.text = text
                }
                if let text = xml.resource.business_reg_Bank_Det.text {
                    self.lblBank.text = text
                }
                if let text = xml.resource.business_reg_Payment_Pin_Code.text {
                    self.lblPin.text = text
                }
                if let text = xml.resource.Acc_Setting_ur_Login_ID.text {
                    txtLoginId.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Pass.text {
                    txtPassword.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Email_Add.text {
                    txtEmail.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_DRS_Referral_ID.text {
                    txtDRSReferral.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Your_DRS_User_ID.text {
                    txtDRSUserId.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Bank_Name.text {
                    txtBankName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Branch_Add.text {
                    txtBranchAddress.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Bank_Swift_Code.text {
                    txtswiftCode.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Bank_Holder_Name.text {
                    txtHolderName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Bank_Acc_Num.text {
                    txtAccNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Payment_Pin.text {
                    txtPin.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Business_Name.text {
                    txtBusName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Business_Address.text {
                    txtBusAddress.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Country.text {
                    txtBusCountry.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Region.text {
                    txtBusRegion.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Category.text {
                    txtBusCategory.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Start_Hr.text {
                    txtStarttime.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_End_Hr.text {
                    txtBusOpHr.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Off_Days.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Off_Days.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                txtContactDialCode.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                txtDialCode.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                
                
                
                
                if let text = xml.resource.Acc_Setting_Do_you_apply_service_tax.text {
                    self.txtBusServiceTax.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Do_you_apply_government_tax.text {
                    self.txtBusGovTax.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Profit_Sharing.text {
                    self.txtBusProfit.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Special_Condition.text {
                    self.txtBusSpecial.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Business_Certificate.text {
                    self.txtBusCertificate.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Director_Name.text {
                    self.txtBusDirectorName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Director_IC_Number.text {
                    self.txtBusICNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Person_in_Charge_Name.text {
                    self.txtBusCName.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Contact_Number.text {
                    // self.txtBusContactNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Contact_Num.text {
                    self.txtPChargePhone.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.business_reg_submit.text {
                    btnSubmit.setTitle(text, for: .normal)
                }
                if let text = xml.resource.business_reg_Cont_Num.text {
                    txtBusCNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Company_Logo.text {
                    lblCompanyLogo.text = text
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnImgF.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnImgS.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnImgT.setTitle(text, for: .normal)
                    print("text",text)
                }
                //merchant_login_required
                loginEmptyValidation = ""
                //merchant_pass_required
                pwdEmptyValidation = ""
                //merchant_email_required
                emailEmptyValidation = ""
                //merchant_pay_pin_required
                pinEmptyValidation = ""
                //merchant_bus_name_required
                bNameEmptyValidation = ""
                //merchant_bus_contact_no_required
                bCNumEmptyValidation = ""
                //merchant_contact_btwn_7_12
                bCNumValidation = ""
                
                if let text = xml.resource.merchant_register_success.text {
                    print("merchant_register_success --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_login_id_already_taken.text {
                    print("merchant_login_id_already_taken --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_email_already_taken.text {
                    print("merchant_email_already_taken --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_contact_no_already_taken.text {
                    print("merchant_contact_no_already_taken --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_business_contact_btwn_7_12.text {
                    print("merchant_business_contact_btwn_7_12 --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_contact_btwn_7_12.text {
                    print("merchant_contact_btwn_7_12 --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_ref_id_valid.text {
                    print("merchant_ref_id_valid --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_pass_6_char.text {
                    print("merchant_pass_6_char --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_login_required.text {
                    print("merchant_login_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_bus_name_required.text {
                    print("merchant_bus_name_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_email_required.text {
                    print("merchant_email_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_bus_contact_no_required.text {
                    print("merchant_bus_contact_no_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_pass_required.text {
                    print("merchant_pass_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_pay_pin_required.text {
                    print("merchant_pay_pin_required --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_contact_must_number.text {
                    print("merchant_contact_must_number --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_bus_contact_must_no.text {
                    print("merchant_bus_contact_must_no --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_email_valid.text {
                    print("merchant_email_valid --------",text)
                    messageArray.append(text)
                }
                if let text = xml.resource.merchant_dial_code.text {
                    print("merchant_dial_code --------",text)
                    messageArray.append(text)
                }
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signUpHeight.constant = 245
        viewSignUp.isHidden = false
        signExpandStatus = false
        
        oprationHeight.constant = 1039
        viewBusInfo.isHidden = false
        operationExpandStatus = false
        
        bankHeight.constant = 300
        viewBankInfo.isHidden = false
        bankExpandStatus = false
        
        
        
        pinHeight.constant = 86
        viewPin.isHidden = false
        pinExpandStatus = false
        
        
        viewSignupBottom.priority = UILayoutPriority(rawValue: 998)
        stackbottom.priority = UILayoutPriority(rawValue: 999)
        
        
        viewSignUpFirst.layer.cornerRadius = 15
        viewODetail.layer.cornerRadius = 15
        viewBankDetail.layer.cornerRadius = 15
        viewPinCode.layer.cornerRadius = 15
        
        viewSignUpFirst.clipsToBounds=true
        viewODetail.clipsToBounds=true
        viewBankDetail.clipsToBounds=true
        viewPinCode.clipsToBounds=true
        
        
        tableCountry.delegate = self
        tableCountry.dataSource = self
        
        txtOffDay.delegate = self
        txtContactDialCode.delegate = self
        txtDialCode.text = itemsCode[0]
        txtContactDialCode.text = itemsCode[0]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
        if Reachability.isConnectedToNetwork() {
            self .getCountry()
            /*self.getCategory()
             self.getDayResponse()
             self.getGovTax()
             self.getProfit()
             self.getServTax()*/
        }
        
        txtPChargePhone.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnImageView))
        lblCompanyLogo.isUserInteractionEnabled = true
        lblCompanyLogo.addGestureRecognizer(tap)
        imgCompany.backgroundColor = Constants.textBGColor
        imgCompany.layer.cornerRadius = 10
        
        btnImgF.clipsToBounds = true
        btnImgS.clipsToBounds = true
        btnImgT.clipsToBounds = true
//         let attributedString = NSMutableAttributedString(string: "I agree with the Terms and Conditions, and Agreement.")
//        //let attributedString = NSMutableAttributedString(string: "I agree with the Terms and Conditions, and Agreement.")
//
//        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 17, length: 20))
//        attributedString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 43, length: 9))
//
//        attributedString.addAttribute(.link, value: "https://www.ibm.com", range: NSRange(location: 17, length: 21))
//        attributedString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 43, length: 9))
//
//        txtTerms.isEditable = false
//        txtTerms.delegate=self
//        txtTerms.attributedText = attributedString
        
        
        
        //[lblAgree addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];
        
        btnImgT.titleLabel?.textAlignment = .center
        btnImgS.titleLabel?.textAlignment = .center
        btnImgF.titleLabel?.textAlignment = .center
        
        btnSubmit.layer.cornerRadius = btnSubmit.frame.size.height/2
        btnImgT.backgroundColor = Constants.textBGColor
        btnImgS.backgroundColor = Constants.textBGColor
        btnImgF.backgroundColor = Constants.textBGColor
        //  btnCompanyLogo.backgroundColor = Constants.textBGColor
        
        
        btnImgT.layer.cornerRadius = 10
        btnImgS.layer.cornerRadius = 10
        btnImgF.layer.cornerRadius = 10
        // btnCompanyLogo.layer.cornerRadius = 10
        //btnCompanyLogo.clipsToBounds = true
        txtOffDay.autocorrectionType = .no
        txtContactDialCode.autocorrectionType = .no
        txtLoginId.autocorrectionType = .no
        txtEmail.autocorrectionType = .no
        txtDRSReferral.autocorrectionType = .no
        txtDRSUserId.autocorrectionType = .no
        
        txtStarttime.autocorrectionType = .no
        txtBusOpHr.autocorrectionType = .no
        txtBusCountry.autocorrectionType = .no
        txtBusCategory.autocorrectionType = .no
        txtBusName.autocorrectionType = .no
        txtBusOffDay.autocorrectionType = .no
        txtBusProfit.autocorrectionType = .no
        txtBusGovTax.autocorrectionType = .no
        txtBusServiceTax.autocorrectionType = .no
        txtBusRegion.autocorrectionType = .no
        txtPChargePhone.autocorrectionType = .no
        txtBusAddress.autocorrectionType = .no
        txtBankName.autocorrectionType = .no
        txtswiftCode.autocorrectionType = .no
        txtBranchAddress.autocorrectionType = .no
        txtPin.autocorrectionType = .no
        txtBusSpecial.autocorrectionType = .no
        txtHolderName.autocorrectionType = .no
        txtAccNum.autocorrectionType = .no
        
        txtBusCertificate.autocorrectionType = .no
        txtBusDirectorName.autocorrectionType = .no
        txtBusICNum.autocorrectionType = .no
        txtBusCName.autocorrectionType = .no
        
        txtContactDialCode.delegate = self
        txtDialCode.delegate = self
        txtPChargePhone.delegate = self
        txtStarttime.delegate = self
        txtBusOpHr.delegate = self
        
        txtBusCountry.delegate = self
        txtBusCategory.delegate = self
        txtBusOffDay.delegate = self
        txtBusProfit.delegate = self
        txtBusGovTax.delegate = self
        txtBusServiceTax.delegate = self
        txtBusRegion.delegate = self
        
        txtBankName.delegate = self
        txtswiftCode.delegate = self
        txtBranchAddress.delegate = self
        
        txtPin.delegate = self
        txtHolderName.delegate = self
        txtAccNum.delegate = self
        
        
        txtBusName.delegate = self
        txtBusAddress.delegate = self
        txtBusCountry.delegate = self
        txtBusRegion.delegate = self
        txtBusCategory.delegate = self
        txtBusCNum.delegate = self
        txtBusOpHr.delegate = self
        txtBusOffDay.delegate = self
        txtBusServiceTax.delegate = self
        txtBusGovTax.delegate = self
        txtBusProfit.delegate = self
        txtBusSpecial.delegate = self
        txtBusCertificate.delegate = self
        txtBusDirectorName.delegate = self
        txtBusICNum.delegate = self
        txtBusCName.delegate = self
        txtBusRegion.delegate = self
        //txtBusContactNum.delegate = self
        
        txtLoginId.delegate = self
        txtPassword.delegate = self
        txtEmail.delegate = self
        txtDRSReferral.delegate = self
        txtDRSUserId.delegate = self
        
        
        
        
        
        
        
        
        
        cb1.style = .tick
        cb1.borderStyle = .roundedSquare(radius: 3)
        cb1.addTarget(self, action: #selector(onCheckBoxValueChange(_:)), for: .valueChanged)
        
        viewBusInfo.layer.cornerRadius = 10
        viewBankInfo.layer.cornerRadius = 10
        viewPin.layer.cornerRadius = 10
        
        //viewOperation.layer.cornerRadius = 10
        viewSignUp.layer.cornerRadius = 10
        
        txtContactDialCode.backgroundColor = Constants.textBGColor
        txtLoginId.backgroundColor = Constants.textBGColor
        txtPassword.backgroundColor = Constants.textBGColor
        txtEmail.backgroundColor = Constants.textBGColor
        txtDRSReferral.backgroundColor = Constants.textBGColor
        txtDRSUserId.backgroundColor = Constants.textBGColor
        
        txtDialCode.backgroundColor = Constants.textBGColor
        txtDialCode.layer.cornerRadius = 10
        txtOffDay.backgroundColor = Constants.textBGColor
        txtOffDay.layer.cornerRadius = 10
        
        txtLoginId.layer.cornerRadius = 10
        txtPassword.layer.cornerRadius = 10
        txtEmail.layer.cornerRadius = 10
        txtDRSReferral.layer.cornerRadius = 10
        txtDRSUserId.layer.cornerRadius = 10
        txtContactDialCode.layer.cornerRadius = 10
        
        txtBusName.layer.cornerRadius = 10
        txtBusAddress.layer.cornerRadius = 10
        txtBusCountry.layer.cornerRadius = 10
        txtBusRegion.layer.cornerRadius = 10
        txtBusCategory.layer.cornerRadius = 10
        
        txtBusCNum.layer.cornerRadius = 10
        txtBusOpHr.layer.cornerRadius = 10
        txtBusOffDay.layer.cornerRadius = 10
        txtBusServiceTax.layer.cornerRadius = 10
        
        txtBusGovTax.layer.cornerRadius = 10
        txtBusProfit.layer.cornerRadius = 10
        txtBusSpecial.layer.cornerRadius = 10
        txtBusCertificate.layer.cornerRadius = 10
        txtBusDirectorName.layer.cornerRadius = 10
        
        txtBusICNum.layer.cornerRadius = 10
        txtBusCName.layer.cornerRadius = 10
        
        txtBankName.layer.cornerRadius = 10
        txtswiftCode.layer.cornerRadius = 10
        txtBranchAddress.layer.cornerRadius = 10
        txtPin.layer.cornerRadius = 10
        txtHolderName.layer.cornerRadius = 10
        txtAccNum.layer.cornerRadius = 10
        txtStarttime.layer.cornerRadius = 10
        
        
        
        txtPChargePhone.layer.cornerRadius = 10
        
        
        
        let paddingViewCDial = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtContactDialCode.frame.height))
        txtContactDialCode.leftView = paddingViewCDial
        txtContactDialCode.leftViewMode = UITextField.ViewMode.always
        
        let paddingViewoff = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtOffDay.frame.height))
        txtOffDay.leftView = paddingViewoff
        txtOffDay.leftViewMode = UITextField.ViewMode.always
        
        let paddingView111 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtPChargePhone.leftView = paddingView111
        txtPChargePhone.leftViewMode = UITextField.ViewMode.always
        
        let paddingView1 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtLoginId.leftView = paddingView1
        txtLoginId.leftViewMode = UITextField.ViewMode.always
        
        let paddingView01 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtStarttime.frame.height))
        txtStarttime.leftView = paddingView01
        txtStarttime.leftViewMode = UITextField.ViewMode.always
        
        
        
        
        let paddingView2 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtPassword.frame.height))
        txtPassword.leftView = paddingView2
        txtPassword.leftViewMode = UITextField.ViewMode.always
        
        let paddingView3 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtEmail.frame.height))
        txtEmail.leftView = paddingView3
        txtEmail.leftViewMode = UITextField.ViewMode.always
        
        let paddingView4 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtDRSReferral.frame.height))
        txtDRSReferral.leftView = paddingView4
        txtDRSReferral.leftViewMode = UITextField.ViewMode.always
        
        let paddingView5 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtDRSUserId.frame.height))
        txtDRSUserId.leftView = paddingView5
        txtDRSUserId.leftViewMode = UITextField.ViewMode.always
        
        
        let paddingView12 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusName.leftView = paddingView12
        txtBusName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView13 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusAddress.leftView = paddingView13
        txtBusAddress.leftViewMode = UITextField.ViewMode.always
        
        let paddingView14 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusCountry.leftView = paddingView14
        txtBusCountry.leftViewMode = UITextField.ViewMode.always
        
        let paddingView15 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusRegion.leftView = paddingView15
        txtBusRegion.leftViewMode = UITextField.ViewMode.always
        
        let paddingView16 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusCategory.leftView = paddingView16
        txtBusCategory.leftViewMode = UITextField.ViewMode.always
        
        let paddingView17 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusOpHr.leftView = paddingView17
        txtBusOpHr.leftViewMode = UITextField.ViewMode.always
        
        let paddingView18 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusOffDay.leftView = paddingView18
        txtBusOffDay.leftViewMode = UITextField.ViewMode.always
        
        let paddingView19 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusCNum.leftView = paddingView19
        txtBusCNum.leftViewMode = UITextField.ViewMode.always
        
        let paddingView20 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusServiceTax.leftView = paddingView20
        txtBusServiceTax.leftViewMode = UITextField.ViewMode.always
        
        
        let paddingView21 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusGovTax.leftView = paddingView21
        txtBusGovTax.leftViewMode = UITextField.ViewMode.always
        
        let paddingView22 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusProfit.leftView = paddingView22
        txtBusProfit.leftViewMode = UITextField.ViewMode.always
        
        let paddingView23 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusSpecial.leftView = paddingView23
        txtBusSpecial.leftViewMode = UITextField.ViewMode.always
        
        let paddingView24 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusProfit.leftView = paddingView24
        txtBusProfit.leftViewMode = UITextField.ViewMode.always
        
        let paddingView25 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusSpecial.leftView = paddingView25
        txtBusSpecial.leftViewMode = UITextField.ViewMode.always
        
        let paddingView26 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusCertificate.leftView = paddingView26
        txtBusCertificate.leftViewMode = UITextField.ViewMode.always
        
        let paddingView27 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusDirectorName.leftView = paddingView27
        txtBusDirectorName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView28 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusICNum.leftView = paddingView28
        txtBusICNum.leftViewMode = UITextField.ViewMode.always
        
        let paddingView29 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusCName.leftView = paddingView29
        txtBusCName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView30 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBankName.leftView = paddingView30
        txtBankName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView31 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtswiftCode.leftView = paddingView31
        txtswiftCode.leftViewMode = UITextField.ViewMode.always
        
        let paddingView32 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBranchAddress.leftView = paddingView32
        txtBranchAddress.leftViewMode = UITextField.ViewMode.always
        
        let paddingView33 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtPin.leftView = paddingView33
        txtPin.leftViewMode = UITextField.ViewMode.always
        
        let paddingView34 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtHolderName.leftView = paddingView34
        txtHolderName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView35 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtAccNum.leftView = paddingView35
        txtAccNum.leftViewMode = UITextField.ViewMode.always
        
        
        txtBankName.backgroundColor = Constants.textBGColor
        txtswiftCode.backgroundColor = Constants.textBGColor
        txtBranchAddress.backgroundColor = Constants.textBGColor
        txtPin.backgroundColor = Constants.textBGColor
        txtHolderName.backgroundColor = Constants.textBGColor
        txtAccNum.backgroundColor = Constants.textBGColor
        
        
        txtBusName.backgroundColor = Constants.textBGColor
        txtBusAddress.backgroundColor = Constants.textBGColor
        txtBusCountry.backgroundColor = Constants.textBGColor
        txtBusRegion.backgroundColor = Constants.textBGColor
        txtBusCategory.backgroundColor = Constants.textBGColor
        
        txtBusCNum.backgroundColor = Constants.textBGColor
        txtBusOpHr.backgroundColor = Constants.textBGColor
        txtBusOffDay.backgroundColor = Constants.textBGColor
        txtBusServiceTax.backgroundColor = Constants.textBGColor
        
        txtBusGovTax.backgroundColor = Constants.textBGColor
        txtBusProfit.backgroundColor = Constants.textBGColor
        txtBusSpecial.backgroundColor = Constants.textBGColor
        txtBusCertificate.backgroundColor = Constants.textBGColor
        txtBusDirectorName.backgroundColor = Constants.textBGColor
        
        txtBusICNum.backgroundColor = Constants.textBGColor
        txtBusCName.backgroundColor = Constants.textBGColor
        txtStarttime.backgroundColor = Constants.textBGColor
        //txtBusContactNum.backgroundColor = Constants.textBGColor
        txtPChargePhone.backgroundColor = Constants.textBGColor
        txtContactDialCode.backgroundColor = Constants.textBGColor
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        // CGRectMake(0, 200, view.frame.width, 300)
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        let paddingView1112 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtDialCode.frame.height))
        txtDialCode.leftView = paddingView1112
        txtDialCode.leftViewMode = UITextField.ViewMode.always
        
        let view90 = UIView(frame: CGRect(x: 0, y: txtDialCode.frame.size.height/2, width: 10, height: 10))
        txtDialCode.rightViewMode = UITextField.ViewMode.always
        let imageView90 = UIImageView(frame: CGRect(x: -5, y: 0, width: 10, height: 10))
        let image90 = UIImage(named: "DownArrow")
        imageView90.image = image90
        view90.addSubview(imageView90)
        txtDialCode.rightView = view90
        
        
        
        let view990 = UIView(frame: CGRect(x: 0, y: txtContactDialCode.frame.size.height/2, width: 10, height: 10))
        txtContactDialCode.rightViewMode = UITextField.ViewMode.always
        let imageView990 = UIImageView(frame: CGRect(x: -5, y: 0, width: 10, height: 10))
        let image990 = UIImage(named: "DownArrow")
        imageView990.image = image990
        view990.addSubview(imageView990)
        txtContactDialCode.rightView = view990
        
        
        let view11 = UIView(frame: CGRect(x: 0, y: txtStarttime.frame.size.height/2, width: 10, height: 10))
        txtStarttime.rightViewMode = UITextField.ViewMode.always
        let imageView11 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image11 = UIImage(named: "DownArrow")
        imageView11.image = image11
        view11.addSubview(imageView11)
        txtStarttime.rightView = view11
        
        let view12 = UIView(frame: CGRect(x: 0, y: txtBusOpHr.frame.size.height/2, width: 10, height: 10))
        txtBusOpHr.rightViewMode = UITextField.ViewMode.always
        let imageView12 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image12 = UIImage(named: "DownArrow")
        imageView12.image = image12
        view12.addSubview(imageView12)
        txtBusOpHr.rightView = view12
        
        
        
        let viewS = UIView(frame: CGRect(x: 0, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusCountry.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image = UIImage(named: "DownArrow")
        imageView.image = image
        viewS.addSubview(imageView)
        txtBusCountry.rightView = viewS
        
        let viewS1 = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusRegion.rightViewMode = UITextField.ViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image1 = UIImage(named: "DownArrow")
        imageView1.image = image1
        viewS1.addSubview(imageView1)
        txtBusRegion.rightView = viewS1
        
        let viewS2 = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusCategory.rightViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image2 = UIImage(named: "DownArrow")
        imageView2.image = image2
        viewS2.addSubview(imageView2)
        txtBusCategory.rightView = viewS2
        
        let viewS3 = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusOffDay.rightViewMode = UITextField.ViewMode.always
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image3 = UIImage(named: "DownArrow")
        imageView3.image = image3
        viewS3.addSubview(imageView3)
        txtBusOffDay.rightView = viewS3
        
        let viewS4 = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusServiceTax.rightViewMode = UITextField.ViewMode.always
        let imageView4 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image4 = UIImage(named: "DownArrow")
        imageView4.image = image4
        viewS4.addSubview(imageView4)
        txtBusServiceTax.rightView = viewS4
        
        let viewS5 = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusGovTax.rightViewMode = UITextField.ViewMode.always
        let imageView5 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image5 = UIImage(named: "DownArrow")
        imageView5.image = image5
        viewS5.addSubview(imageView5)
        txtBusGovTax.rightView = viewS5
        
        let viewS6 = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
        txtBusProfit.rightViewMode = UITextField.ViewMode.always
        let imageView6 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image6 = UIImage(named: "DownArrow")
        imageView6.image = image6
        viewS6.addSubview(imageView6)
        txtBusProfit.rightView = viewS6
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        
        txtBusCNum.inputAccessoryView = numberToolbar
        txtPChargePhone.inputAccessoryView = numberToolbar
        txtAccNum.inputAccessoryView = numberToolbar
        txtPin.inputAccessoryView = numberToolbar
        
        
        
        self.changeLanguage()
        
        print("messageArray --",messageArray)
        
    }
    
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtBusCNum.resignFirstResponder()
        txtPChargePhone.resignFirstResponder()
        txtAccNum.resignFirstResponder()
        txtPin.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtBusCNum.resignFirstResponder()
        txtPChargePhone.resignFirstResponder()
        txtAccNum.resignFirstResponder()
        txtPin.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as? String // dropdown item
    }
    
    @objc func donePicker() {
        picker.selectRow(0, inComponent: 0, animated: true)
        picker.reloadAllComponents();
        txtBusCountry.resignFirstResponder()
        txtBusCategory.resignFirstResponder()
        txtBusOffDay.resignFirstResponder()
        txtBusProfit.resignFirstResponder()
        txtBusGovTax.resignFirstResponder()
        txtBusServiceTax.resignFirstResponder()
        txtBusRegion.resignFirstResponder()
        txtBusOpHr.resignFirstResponder()
        txtStarttime.resignFirstResponder()
        
        if countryStatus == true {
            if txtBusCountry.text!.count <= 0
            {
                if self.countryID.count > 0
                {
                    selectedCountryID = self.countryID[0]

                }
                else
                {
                    selectedCountryID = 0

                }
//                selectedCountryID = self.countryID[0]
//                txtBusCountry.text = self.countryName[0]
                if self.countryName.count > 0
                {
                    txtBusCountry.text = self.countryName[0]

                }
                else
                {
                    txtBusCountry.text = ""

                }
                
            }
            
            
            self.getRegion(countryID: String(selectedCountryID))
        }
            
        else if categoryStatus == true
        {
            
            if txtBusCategory.text!.count <= 0
            {
                
                if self.categoryID.count > 0
                {
                    selectedCategoryID = self.categoryID[0]

                }
                else
                {
                    selectedCategoryID = 0

                }
                
//                selectedCategoryID = self.categoryID[0]
//                txtBusCategory.text = self.categoryName[0]
                
                if self.categoryName.count > 0
                {
                    txtBusCategory.text = self.categoryName[0]

                }
                else
                {
                    txtBusCategory.text = ""

                }
            }
            
        }
        else if dayStatus == true
        {
            print("selectedDayID",selectedDayID)
            if txtBusOffDay.text!.count <= 0
            {
                if self.dayID.count > 0
                {
                    selectedDayID = self.dayID[0]

                }
                else
                {
                    selectedDayID = 0

                }
//                selectedDayID = self.dayID[0]
//                txtBusOffDay.text = self.dayName[0]
                if self.dayName.count > 0
                {
                    txtBusOffDay.text = self.dayName[0]

                }
                else
                {
                    txtBusOffDay.text = ""

                }
            }
            
            
        }
        else if profitStatus == true
        {
            if txtBusProfit.text!.count <= 0
            {
                
                if self.profitID.count > 0
                {
                    selectedprofitID = self.profitID[0]

                }
                else
                {
                    selectedprofitID = 0

                }
//                txtBusProfit.text = self.profitName[0]
                if self.profitName.count > 0
                {
                    txtBusProfit.text = self.profitName[0]

                }
                else
                {
                    txtBusProfit.text = ""

                }
            }
            
        }
        else if govTaxStatus ==  true
        {
            print("selectedgovTaxID ---- ",selectedgovTaxID)
            
            if txtBusGovTax.text!.count <= 0
            {
                if self.govTaxID.count > 0
                {
                    selectedgovTaxID = self.govTaxID[0]

                }
                else
                {
                    selectedgovTaxID = 0

                }
//                selectedgovTaxID = self.govTaxID[0]
//                txtBusGovTax.text = self.govTaxName[0]
                if self.govTaxName.count > 0
                {
                    txtBusGovTax.text = self.govTaxName[0]

                }
                else
                {
                    txtBusGovTax.text = ""

                }
            }
            
        }
        else if serviceTaxStatus == true
        {
            if txtBusServiceTax.text!.count <= 0
            {
                if self.serviceTaxID.count > 0
                {
                    selectedserviceTaxID = self.serviceTaxID[0]

                }
                else
                {
                    selectedserviceTaxID = 0

                }
//                selectedserviceTaxID = self.serviceTaxID[0]
//                txtBusServiceTax.text = self.serviceTaxName[0]
                if self.serviceTaxName.count > 0
                {
                    txtBusServiceTax.text = self.serviceTaxName[0]

                }
                else
                {
                    txtBusServiceTax.text = ""

                }
            }
        }
        else if regionStatus == true
        {
            if txtBusRegion.text!.count <= 0
            {
                if self.regionID.count > 0
                {
                    selectedRegionID = self.regionID[0]

                }
                else
                {
                    selectedRegionID = 0

                }
                if self.regionName.count > 0
                {
                    txtBusRegion.text = self.regionName[0]

                }
                else
                {
                    txtBusRegion.text = ""

                }
            }
            
        } else if startStatus == true
        {
            if txtStarttime.text!.count <= 0
            {
//                txtStarttime.text = timeStartStr[0]
                if self.timeStartStr.count > 0
                {
                    txtStarttime.text = timeStartStr[0]

                }
                else
                {
                    txtStarttime.text = ""

                }
            }
        }
        else if endtatus == true
        {
            if txtBusOpHr.text!.count <= 0
            {
//                txtBusOpHr.text = timeEndStr[0]
                
                if self.timeEndStr.count > 0
                {
                    txtBusOpHr.text = timeEndStr[0]

                }
                else
                {
                    txtBusOpHr.text = ""

                }
            }
        }
        
        pickerStatus = 0
        profitStatus = false
        countryStatus = false
        regionStatus  = false
        serviceTaxStatus = false
        govTaxStatus = false
        dayStatus = false
        categoryStatus = false
        startStatus = false
        endtatus = false
        
        
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    
    {
        
        if pickerData.count>0
        {
            
        
        print("daddasd++++++ ",pickerData[row])
        //selectedCountry = pickerData[row] // selected item
        //textFiled.text = selectedCountry
        
        
        
        if pickerStatus == 1
        {
            selectedCountryID = self.countryID[row]
            //pickerStatus = 0
            txtBusCountry.text = pickerData[row]
            self.getRegion(countryID: String(selectedCountryID))
        }
        else if pickerStatus == 2
        {
            selectedCategoryID = self.categoryID[row]
            //pickerStatus = 0
            txtBusCategory.text = pickerData[row]
        }
        else if pickerStatus == 3
        {
            selectedDayID = self.dayID[row]
            //pickerStatus = 0
            txtBusOffDay.text = pickerData[row]
        }
        else if pickerStatus == 4
        {
            selectedprofitID = self.profitID[row]
            //pickerStatus = 0
            txtBusProfit.text = pickerData[row]
        }
        else if pickerStatus == 5
        {
            selectedgovTaxID = self.govTaxID[row]
            //pickerStatus = 0
            txtBusGovTax.text = pickerData[row]
        }
        else if pickerStatus == 6
        {
            //pickerStatus = 0
            txtBusServiceTax.text = pickerData[row]
            
            selectedserviceTaxID = self.serviceTaxID[row]
        }
        else if pickerStatus == 7
        {
            //pickerStatus = 0
            txtBusRegion.text = pickerData[row]
            selectedRegionID = self.regionID[row]
            
        }
        else if pickerStatus == 8
        {
            //pickerStatus = 0
            txtStarttime.text = pickerData[row]
            
            
        }
        else if pickerStatus == 9
        {
            //pickerStatus = 0
            txtBusOpHr.text = pickerData[row]
            
            
        }
        
        
        
        }
        
        
    }
    
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if termStatus == true
        {
            self.signup()
        }
        else
        {
            //
            if sharedDefault.getLanguage() == 1{
                self.showAlert(title: appName, message: "စည်းကမ်းချက်များကိုလက်ခံပါ")
            } else  if sharedDefault.getLanguage() == 0{
                self.showAlert(title: appName, message: Constants.TermsValidation)
            }
        }
        
    }
    
    
    func signup() {
        if Reachability.isConnectedToNetwork() {
            //merchant_login_required
            var loginEmptyValidation:String = String()
            //merchant_pass_required
            var pwdEmptyValidation:String = String()
            //merchant_email_required
            var emailEmptyValidation:String = String()
            //merchant_pay_pin_required
            var pinEmptyValidation:String = String()
            //merchant_bus_name_required
            var bNameEmptyValidation:String = String()
            //merchant_bus_contact_no_required
            var bCNumEmptyValidation:String = String()
            //merchant_contact_btwn_7_12
            var bCNumValidation:String = String()
            var i:Int = 0
            for msg in self.messageArray {
                
                print(i,msg)
                i = i + 1
            }
            
            if (txtLoginId.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[8])
            }
            else if (txtPassword.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[7])
            }
            else if (txtEmail.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[10])
            }
            
//            else if (txtDRSReferral.text!.count<=0)
//            {
//
//            }
            else if (txtBusAddress.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "စီးပွားရေးလိပ်စာကွက်လပ်လိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The business address field is required")

                }
            }
            else if (txtBusCountry.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "စီးပွားရေးတိုင်းပြည်နယ်ပယ်ဖြည့်ရန်လိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The business country field is required")

                }
            }
            
            else if (txtBusRegion.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "စီးပွားရေးareaရိယာလိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The business region field is required")

                }
            }
            
            else if (txtBusCategory.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "စီးပွားရေးအမျိုးအစားလယ်ကွက်လိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The business category field is required")

                }
            }
            else if (txtStarttime.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "လုပ်ငန်းလည်ပတ်မှုစတင်ချိန်အချိန်လိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The business operation start time field is required")

                }
            }
            else if (txtBusOpHr.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "စီးပွားရေးလုပ်ငန်းလည်ပတ်မှုအဆုံးသတ်အချိန်ကာလလိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The business operation end time field is required")

                }
                
            }
            
            else if (bCompanyLogoSelected == false)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "ကုမ္ပဏီတံဆိပ်လိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The company logo required")

                }
                
            }
            
            
            
            
            
//            else if (txtBusOffDay.text!.count<=0)
//            {
//                if sharedDefault.getLanguage() == 1
//                {
//                    
//                    self.showAlert(title: appName, message: "စီးပွားရေးလုပ်ငန်းလည်ပတ်မှုအဆုံးသတ်အချိန်ကာလလိုအပ်သည်")
//
//                }
//                else
//                {
//                    self.showAlert(title: appName, message: "The business operation end time field is required")
//
//                }
//                
//            }
            
//            else if (txtOffDay.text!.count<=0)
//            {
//
//            }
//            else if (txtBusServiceTax.text!.count<=0)
//            {
//
//            }
//            else if (txtBusGovTax.text!.count<=0)
//            {
//
//            }
            
            else if (txtBusProfit.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "အမြတ်ခွဲဝေရေးလယ်ကွင်းလိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The profit sharing field is required")

                }
            }
            else if (txtBusSpecial.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "အထူးလယ်ကွင်းလိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The special condition field is required")

                }
            }
            else if (txtBusCertificate.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "လက်မှတ်လိုအပ်ပါသည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The certificate field is required")

                }
            }
            else if (txtBusDirectorName.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "ဒါရိုက်တာနာမည်ဗလာ")

                }
                else
                {
                    self.showAlert(title: appName, message: "The director name field is required")

                }
            }
            else if (txtBusICNum.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "ညွှန်ကြားရေးမှူး IC နံပါတ်နေရာလိုအပ်ပါသည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The director IC number field is required")

                }
            }
            else if (txtBusCNum.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[11])
            }
            else if (txtBusCNum.text!.count<7 || txtBusCNum.text!.count>12)
            {
                self.showAlert(title: appName, message: self.messageArray[5])
            }
            else if (txtBusCName.text!.count<=0)
            {
                if sharedDefault.getLanguage() == 1
                {
                    
                    self.showAlert(title: appName, message: "တာဝန်ခံအမည်လယ်ပြင်၌လူတစ် ဦး လိုအပ်သည်")

                }
                else
                {
                    self.showAlert(title: appName, message: "The person in charge name field is required")

                }
            }
//            else if (txtPChargePhone.text!.count<=0)
//            {
//
//            }
//            else if (txtBankName.text!.count<=0)
//            {
//                if sharedDefault.getLanguage() == 1
//                {
//                    
//                    self.showAlert(title: appName, message: "ဘဏ်အမည်ကွက်လပ်ဖြည့်ရန်လိုအပ်သည်")
//
//                }
//                else
//                {
//                    self.showAlert(title: appName, message: "The bank name field is required")
//
//                }
//            }
//            else if (txtBranchAddress.text!.count<=0)
//            {
//                if sharedDefault.getLanguage() == 1
//                {
//                    
//                    self.showAlert(title: appName, message: "ဘဏ်လိပ်စာကွက်လပ်ဖြည့်ပါ")
//
//                }
//                else
//                {
//                    self.showAlert(title: appName, message: "The bank address field is required")
//
//                }
//            }
//            else if (txtswiftCode.text!.count<=0)
//            {
//                if sharedDefault.getLanguage() == 1
//                {
//                    
//                    self.showAlert(title: appName, message: "ဘဏ်ဆွစ်ဖ်ကုဒ်လိုအပ်ပါသည်")
//
//                }
//                else
//                {
//                    self.showAlert(title: appName, message: "The bank swift code is required")
//
//                }
//            }
//            else if (txtHolderName.text!.count<=0)
//            {
//                if sharedDefault.getLanguage() == 1
//                {
//                    
//                    self.showAlert(title: appName, message: "ဘဏ်ပိုင်ရှင်အမည်လိုအပ်ပါသည်")
//
//                }
//                else
//                {
//                    self.showAlert(title: appName, message: "The bank holder name is required")
//
//                }
//            }
//            else if (txtAccNum.text!.count<=0)
//            {
//                if sharedDefault.getLanguage() == 1
//                {
//                    
//                    self.showAlert(title: appName, message: "ဘဏ်အကောင့်နံပါတ်လိုအပ်ပါသည်")
//
//                }
//                else
//                {
//                    self.showAlert(title: appName, message: "The bank account number is required")
//
//                }
//            }
            
            else if (txtPin.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[12])
            }
            else if (txtBusName.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[9])
            }
            
            else if (txtDialCode.text!.count<=0)
            {
                self.showAlert(title: appName, message: self.messageArray[15])
            }
                
                
            else {
                //
                
                self.view.activityStartAnimating()
                var postDict = Dictionary<String,String>()
                postDict = [
                    "login_id":txtLoginId.text!,
                    "password":txtPassword.text!,
                    "email":txtEmail.text!,
                    "referral_id":txtDRSReferral.text!,
                    "business_name":txtBusName.text!,
                    "business_address":txtBusAddress.text!,
                    "country":String(selectedCountryID),
                    "region":String(selectedRegionID),
                    "category":String(selectedCategoryID),
                    "business_contact_number":txtBusCNum.text!,
                    "operation_start_time":txtStarttime.text!,
                    "operation_end_time":txtBusOpHr.text!,
                    "off_day":finalselectedID,
                    "service_tax":String(selectedserviceTaxID),
                    "government_tax":String(selectedgovTaxID),
                    "profit_share":String(selectedprofitID),
                    "special_condition":txtBusSpecial.text!,
                    "business_certificate":txtBusCertificate.text!,
                    "director_name":txtBusDirectorName.text!,
                    "director_icnumber":txtBusICNum.text!,
                    "person_incharge":txtBusCName.text!,//txtPChargePhone
                    "contact_number":txtBusCNum.text!,
                    "bank_name":txtBankName.text!,
                    "branch_address":txtBranchAddress.text!,
                    "swift_code":txtswiftCode.text!,
                    "account_holder":txtHolderName.text!,
                    "account_number":txtAccNum.text!,
                    "payment_pincode":txtPin.text!,
                    "company_logo":companyImgData,
                    "promo_image_1":firstImgData,
                    "promo_image_2":secondImgData,
                    "promo_image_3":thirdImgData,
                    "business_country_code":txtDialCode.text!,
                    "contact_country_code":txtContactDialCode.text!,
                    
                    
                ]
                //"drs_userid":txtDRSUserId.text!,
                
                print("PostData: ",postDict)
                let loginURL = Constants.baseURL+Constants.SignupURL
                
                AF.request(loginURL, method: .post, parameters: postDict, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
                    // print("Response:***:",data.description)
                    
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
                            print("response ---- ",response)
                            self.loginResponse = LoginResponse(response)
                            print("self.loginResponse ",self.loginResponse!)
                            print("self.loginResponse ",self.loginResponse?.httpcode!)
                            print("self.loginResponse ",self.loginResponse?.loginData?.userData!)
                            let sharedDefault = SharedDefault()
                            let statusCode = Int((self.loginResponse?.httpcode)!)
                            if statusCode == 200
                            {
//                                if let range3 = (self.loginResponse?.message)!.range(of: self.messageArray[0], options: .caseInsensitive)
//                                {
//                                    self.showToast(message: self.messageArray[0])
//                                }
//                                
                                
                                
                                if sharedDefault.getLanguage() == 1
                                {
                                    
                                    self.showToast(message: "မှတ်ပုံတင်ခြင်းအောင်မြင်ပါပြီ။admin၏အတည်ပြုချက်ကိုစောင့်ပေးပါ")

                                }
                                else
                                {
                                    self.showToast(message: "Registration Successful.Please wait for admin approval")

                                }
                                
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                                {
                                    let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                    self.navigationController?.pushViewController(next, animated: true)
                                }
                            }
                            if statusCode == 400{
                                
                                
                                self.view.activityStopAnimating()
                                
//                                for msg in self.messageArray
//                                {
//                                    if let range3 = (self.loginResponse?.message)!.range(of: msg, options: .caseInsensitive)
//                                    {
//                                        self.showToast(message:msg )
//                                    }
//                                }
                                
                                // Changes by Praveen
                                
                                if let range3 = (self.loginResponse?.message)!.range(of: "The email has already been taken.", options: .caseInsensitive){
                                    let sharedDefault = SharedDefault()
                                    if sharedDefault.getLanguage() == 1
                                    {
                                            self.showAlert(title: sharedDefault.getAppName(), message: "အီးမေးလ်ကိုယူထားပြီးဖြစ်သည်")
                                    }
                                    else  if sharedDefault.getLanguage() == 0
                                    {
                                        self.showAlert(title: sharedDefault.getAppName(), message: "The email has already been taken.")
                                    }
                                }
                                
                                
                                if let range3 = (self.loginResponse?.message)!.range(of: "The login id has already been taken.", options: .caseInsensitive){
                                    let sharedDefault = SharedDefault()
                                    if sharedDefault.getLanguage() == 1
                                    {
                                            self.showAlert(title: sharedDefault.getAppName(), message: "Login IDကိုယူထားပြီးဖြစ်သည်")
                                    }
                                    else  if sharedDefault.getLanguage() == 0
                                    {
                                        self.showAlert(title: sharedDefault.getAppName(), message: "The login id has already been taken.")
                                    }
                                }
                                
                                
                                
                                
                                    if let range3 = (self.loginResponse?.message)!.range(of: "The business contact number has already been taken.", options: .caseInsensitive){
                                        let sharedDefault = SharedDefault()
                                        if sharedDefault.getLanguage() == 1
                                        {
                                                self.showAlert(title: sharedDefault.getAppName(), message: "စီးပွားရေးအဆက်အသွယ်ဖုန်းနံပါတ်ကိုယူထားပြီးဖြစ်သည်")
                                        }
                                        else  if sharedDefault.getLanguage() == 0
                                        {
                                            self.showAlert(title: sharedDefault.getAppName(), message: "The business contact number has already been taken.")
                                        }
                                    }
                                       
                                if let range3 = (self.loginResponse?.message)!.range(of: "The referral id must be valid.", options: .caseInsensitive){
                                    let sharedDefault = SharedDefault()
                                    if sharedDefault.getLanguage() == 1
                                    {
                                            self.showAlert(title: sharedDefault.getAppName(), message: "လွှဲပြောင်းသူIDတရားဝင်ဖြစ်ရမည်")
                                    }
                                    else  if sharedDefault.getLanguage() == 0
                                    {
                                        self.showAlert(title: sharedDefault.getAppName(), message: "The referral id must be valid.")
                                    }
                                }
                                // Changes by Praveen

                                
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
                                    
                                }
//                                else
//                                {
//
//
//                                    for item in self.messageArray
//                                    {
//                                        if let range3 = (self.loginResponse?.message)!.range(of: item, options: .caseInsensitive){
//                                            //self.showToast(message:msg )
//                                            self.showAlert(title: sharedDefault.getAppName(), message: item)
//                                        }
//                                    }
//                                }
                                
                                
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
        
        
    }
    @objc func onCheckBoxValueChange(_ sender: CheckBox) {
        
        print(sender.isChecked)
        if sender.isChecked{
            termStatus = true
            
        }
        else{
            termStatus = false
        }
        
    }
    
    func getDayResponse() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.DayURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.dayResponse = DayResponse(response)
                    print("self.loginResponse ",self.dayResponse!)
                    print("self.loginResponse ",self.dayResponse?.httpcode!)
                    print("self.loginResponse ",self.dayResponse?.dayData?.dayList)
                    
                    let statusCode = Int((self.dayResponse?.httpcode)!)
                    if statusCode == 200{
                        self.dayID.removeAll()
                        self.dayName.removeAll()
                        for item in (self.dayResponse?.dayData?.dayList)! {
                            self.dayID.append(item.id!)
                            self.dayName.append(item.day!)
                        }
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.dayResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.dayResponse?.message)!)
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
    
    func getRegion(countryID:String) {
        self.view.activityStartAnimating()
        
        var postDict = Dictionary<String,String>()
        postDict = ["country_id":countryID,
        ]
        let loginURL = Constants.baseURL+Constants.RegionURL
        
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
                    self.regionResponse = RegionResponse(response)
                    print("self.regionResponse ",self.regionResponse!)
                    print("self.regionResponse ",self.regionResponse?.httpcode!)
                    print("self.regionResponse ",self.regionResponse?.regionData?.regionsList?.capacity)
                    
                    let statusCode = Int((self.regionResponse?.httpcode)!)
                    if statusCode == 200{
                        self.regionID.removeAll()
                        self.regionName.removeAll()
                        for item in (self.regionResponse?.regionData?.regionsList)! {
                            self.regionID.append(item.id!)
                            self.regionName.append(item.name!)
                        }
                        print("self.regionID ",self.regionID)
                        print("self.regionName ",self.regionName)
                    }
                    if statusCode == 400{
                        self.view.activityStopAnimating()
                        if let range3 = (self.regionResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.regionResponse?.message)!)
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
    
    func getCategory() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.CategoryURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.categoryResponse = CategoryResponse(response)
                    print("self.loginResponse ",self.categoryResponse!)
                    print("self.loginResponse ",self.categoryResponse?.httpcode!)
                    print("self.loginResponse ",self.categoryResponse?.categoryData?.categories!)
                    
                    let statusCode = Int((self.categoryResponse?.httpcode)!)
                    if statusCode == 200{
                        self.categoryID.removeAll()
                        self.categoryName.removeAll()
                        for item in (self.categoryResponse?.categoryData?.categories)! {
                            self.categoryID.append(item.id!)
                            self.categoryName.append(item.categoryName!)
                        }
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.categoryResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.categoryResponse?.message)!)
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
    
    func getCountry() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.SignupDropDownURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.signUpDropDownResponse = SignUpDropDownResponse(response)
                    print("self.loginResponse ",self.signUpDropDownResponse!.message)
                    print("self.loginResponse ",self.signUpDropDownResponse?.httpcode!)
                    //print("self.loginResponse ",self.countryResponse?.countryData?.countryList)
                    print("self.loginResponse ",self.signUpDropDownResponse!.signUpDpData?.countryList!)
                    let statusCode = Int((self.signUpDropDownResponse?.httpcode)!)
                    if statusCode == 200{
                        self.countryID.removeAll()
                        self.countryName.removeAll()
                        for item in (self.signUpDropDownResponse!.signUpDpData?.countryList)! {
                            self.countryID.append(item.id!)
                            self.countryName.append(item.name!)
                        }
                        self.categoryID.removeAll()
                        self.categoryName.removeAll()
                        for item in (self.signUpDropDownResponse!.signUpDpData?.categories)! {
                            self.categoryID.append(item.id!)
                            self.categoryName.append(item.categoryName!)
                        }
                        
                        self.govTaxID.removeAll()
                        self.govTaxName.removeAll()
                        for item in (self.signUpDropDownResponse!.signUpDpData?.govtaxList)! {
                            self.govTaxID.append(item.id!)
                            self.govTaxName.append(item.title!)
                        }
                        
                        self.profitID.removeAll()
                        self.profitName.removeAll()
                        for item in (self.signUpDropDownResponse!.signUpDpData?.profitList)! {
                            self.profitID.append(item.id!)
                            self.profitName.append(item.title!)
                        }
                        self.serviceTaxID.removeAll()
                        self.serviceTaxName.removeAll()
                        for item in (self.signUpDropDownResponse!.signUpDpData?.servicetaxList)! {
                            self.serviceTaxID.append(item.id!)
                            self.serviceTaxName.append(item.title!)
                        }
                        
                        self.dayID.removeAll()
                        self.dayName.removeAll()
                        for item in (self.signUpDropDownResponse!.signUpDpData?.dayList)! {
                            self.dayID.append(item.id!)
                            self.dayName.append(item.day!)
                        }
                        
                        
                        
                        
                        
                    }/*
                     print("countryID ",self.countryID)
                     print("countryName ",self.countryName)
                     if statusCode == 400{
                     
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
    
    func getGovTax() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.GovTaxURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.govTaxResponse = GovTaxResponse(response)
                    print("self.profitResponse ",self.govTaxResponse!)
                    print("self.profitResponse ",self.govTaxResponse?.httpcode!)
                    print("self.profitResponse ",self.govTaxResponse?.govTaxData?.govtaxList)
                    
                    let statusCode = Int((self.govTaxResponse?.httpcode)!)
                    if statusCode == 200{
                        self.govTaxID.removeAll()
                        self.govTaxName.removeAll()
                        for item in (self.govTaxResponse?.govTaxData?.govtaxList)! {
                            self.govTaxID.append(item.id!)
                            self.govTaxName.append(item.title!)
                        }
                    }
                    print("govTaxID ",self.govTaxID)
                    print("govTaxName ",self.govTaxName)
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.govTaxResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.govTaxResponse?.message)!)
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
    func getProfit() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.ProfitURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.profitResponse = ProfitResponse(response)
                    print("self.profitResponse ",self.profitResponse!)
                    print("self.profitResponse ",self.profitResponse?.httpcode!)
                    print("self.profitResponse ",self.profitResponse?.profitData?.profitList)
                    
                    let statusCode = Int((self.profitResponse?.httpcode)!)
                    if statusCode == 200{
                        self.profitID.removeAll()
                        self.profitName.removeAll()
                        for item in (self.profitResponse?.profitData?.profitList)! {
                            self.profitID.append(item.id!)
                            //self.profitName.append(item.percent!)
                            
                            self.profitName.append(String(item.percent!))
                        }
                    }
                    print("profitID ",self.profitID)
                    print("profitName ",self.profitName)
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.profitResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.profitResponse?.message)!)
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
    
    
    func getServTax() {
        self.view.activityStartAnimating()
        
        
        let loginURL = Constants.baseURL+Constants.ServiceTaxURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.servTaxResponse = ServiceTaxResponse(response)
                    print("self.profitResponse ",self.servTaxResponse!)
                    print("self.profitResponse ",self.servTaxResponse?.httpcode!)
                    print("self.profitResponse ",self.servTaxResponse?.serviceTaxData?.servicetaxList)
                    
                    let statusCode = Int((self.servTaxResponse?.httpcode)!)
                    if statusCode == 200{
                        self.serviceTaxID.removeAll()
                        self.serviceTaxName.removeAll()
                        for item in (self.servTaxResponse?.serviceTaxData?.servicetaxList)! {
                            self.serviceTaxID.append(item.id!)
                            self.serviceTaxName.append(item.title!)
                        }
                    }
                    print("serviceTaxID ",self.serviceTaxID)
                    print("serviceTaxName ",self.serviceTaxName)
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.servTaxResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.servTaxResponse?.message)!)
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
    
    
    @IBAction func btnThirdAction(_ sender: UIButton) {
        imgStatusValue = 3
        //self.btnClicked(imgID: "3")
        self.showAlert()
    }
    
    @IBAction func btnFirstAction(_ sender: UIButton) {
        imgStatusValue = 1
        //self.btnClicked(imgID: "1")
        self.showAlert()
    }
    
    @IBAction func btnCompanyLogoAction(_ sender: UIButton) {
        imgStatusValue = 4
        self.showAlert()
    }
    
    @IBAction func bthSecondAction(_ sender: UIButton) {
        imgStatusValue = 2
        // self.btnClicked(imgID: "2")
        self.showAlert()
    }
    
    func btnClicked(imgID:String) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Info ------->",info as Any)
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            print(asset?.value(forKey: "filename") as Any)
        }
        let pImage = info[UIImagePickerController.InfoKey.originalImage]
        if imgStatusValue == 1 {
            btnImgF .setBackgroundImage(pImage as? UIImage, for: .normal)
            //btnLogoF.setImage(pImage as? UIImage, for: .normal)
            btnImgF.setTitle("", for: .normal)
            //firstImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            firstImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            
        }
        else if imgStatusValue == 2
        {
            btnImgS .setBackgroundImage(pImage as? UIImage, for: .normal)
            btnImgS.setTitle("", for: .normal)
            
            secondImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            secondImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            
        }
        else if imgStatusValue == 3
        {
            lblCompanyLogo.text = ""
            btnImgT.setBackgroundImage(pImage as? UIImage, for: .normal)
            btnImgT.setTitle("", for: .normal)
            //thirdImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            thirdImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
        }
        else if imgStatusValue == 4
        {
            
            imgCompany.image = pImage as? UIImage
            //updateDetails["avatar"] = convertImageToBase64(image: ((pImage as? UIImage)!))
            //companyImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            //timage.jpeg(UIImage.JPEGQuality(rawValue: 0.5)!)
            //print("companyImgData",companyImgData)
            companyImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.5)!)!)
            lblCompanyLogo.text = ""
            
        }
        
        imgStatusValue = 0
        // btnProfilePic.setImage(pImage as? UIImage, for: .normal)
        //updateDetails["avatar"] = convertImageToBase64(image: ((pImage as? UIImage)!))
        dismiss(animated: true, completion: nil)
    }
    
    //This is the tap gesture added on my UIImageView.
    @IBAction func didTapOnImageView(sender: UITapGestureRecognizer) {
        //call Alert function
        self.showAlert()
        imgStatusValue = 4
    }
    
    //Show alert to selected the media source type.
    func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType)
    {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
        {
             bCompanyLogoSelected = true
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
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
