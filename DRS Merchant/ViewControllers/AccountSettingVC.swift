//
//  AccountSettingVC.swift
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


class AccountSettingVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate, UITableViewDelegate,UITableViewDataSource {
    var loginEmptyValidation:String = ""
    var emailEmptyValidation:String = ""
    var pinEmptyValidation:String = ""
    var bNameEmptyValidation:String = ""
    var bCNumEmptyValidation:String = ""
     var bCNumValidation:String = ""
    
    var loginEmptyValidationB:String = ""
    var emailEmptyValidationB:String = ""
    var pinEmptyValidationB:String = ""
    var bNameEmptyValidationB:String = ""
    var bCNumEmptyValidationB:String = ""
     var bCNumValidationB:String = ""
    
    var strTitle: String! = String()
    @IBOutlet weak var lblGenInfo: UILabel!
    @IBOutlet weak var lblBus: UILabel!
    @IBOutlet weak var lblBank: UILabel!
    @IBOutlet weak var lblPay: UILabel!
    
    
    var accSettingsMsgE = [String]()
    var accSettingsMsgB = [String]()
    
    @IBOutlet weak var viewCountryBg: UIView!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    var startStatus:Bool = false
    @IBOutlet weak var txtBusContactDialCode: UITextField!
    @IBOutlet weak var txtPChargeDial: UITextField!
    var endtatus:Bool = false
    var dialStatus:Bool = false
    @IBOutlet weak var tableCountry: UITableView!
    @IBOutlet weak var txtOffDaysNum: UITextField!
    var genInfoSelected:Bool = false
    
    var timeStr : [String] = ["12:00 AM","12:30 AM","01:00 AM","01:30 AM","02:00 AM","03:00 AM","03:30 AM","4:00 AM","4:30 AM","05:00 AM","05:30 AM","06:00 AM","06:30 AM","07:00 AM","07:30 AM","08:00 AM","08:30 AM","09:00 AM","09:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","12:00 PM","12:30 PM","01:00 PM","01:30 PM","02:00 PM","03:00 PM","03:30 PM","4:00 PM","4:30 PM","05:00 PM","05:30 PM","06:00 PM","06:30 PM","07:00 PM","07:30 PM","08:00 PM","08:30 PM","09:00 PM","09:30 PM","10:00 PM","10:30 PM","11:00 PM","11:30 PM"]
    var timeEndStr : [String] = ["12:00 AM","12:30 AM","01:00 AM","01:30 AM","02:00 AM","03:00 AM","03:30 AM","4:00 AM","4:30 AM","05:00 AM","05:30 AM","06:00 AM","06:30 AM","07:00 AM","07:30 AM","08:00 AM","08:30 AM","09:00 AM","09:30 AM","10:00 AM","10:30 AM","11:00 AM","11:30 AM","12:00 PM","12:30 PM","01:00 PM","01:30 PM","02:00 PM","03:00 PM","03:30 PM","4:00 PM","4:30 PM","05:00 PM","05:30 PM","06:00 PM","06:30 PM","07:00 PM","07:30 PM","08:00 PM","08:30 PM","09:00 PM","09:30 PM","10:00 PM","10:30 PM","11:00 PM","11:30 PM"]
    var imageFirst:UIImage = UIImage()
    var imageSeond:UIImage = UIImage()
    var imageThird:UIImage = UIImage()
    var imageCompanyFourth:UIImage = UIImage()
    
    var btnOK:UIButton = UIButton()
    var btnCancel
        :UIButton = UIButton()
    var finalselectedData = String()
    var finalselectedID = String()
    
    
    var companyImgData:String = String()
    var firstImgData:String = String()
    var secondImgData:String = String()
    var thirdImgData:String = String()
    
    let tableBg = UIView()
    
    var tableViewDays: UITableView  =   UITableView()
    var selectedData = [String]()
    var selectedPopDayID = [String]()
    var animals : [String]  = [String]()
    var imageUpload: ImageUpload?
    var accountInfoDetailResponse: AccountInfoDetailResponse?
    var signUpDropDownResponse: SignUpDropDownResponse?
    @IBOutlet var imgCompany: UIImageView!
    var countryStatus:Bool = false
    var regionStatus:Bool = false
    var categoryStatus:Bool = false
    var dayStatus:Bool = false
    var profitStatus:Bool = false
    var serviceTaxStatus:Bool = false
    var govTaxStatus:Bool = false
    let sharedData = SharedDefault()
    
    
    
    //,UIPickerViewDelegate, UIPickerViewDataSource
    var loginResponse: LoginResponse?
    var picker = UIPickerView()
    let toolBar = UIToolbar()
    var pickerData = [String]()
    
    var imagePicker = UIImagePickerController()
    var bankInfoResponse: BankInfoResponse?
    var accInfoResponse: AccountInfoResponse?
    var dayResponse: DayResponse?
    var regionResponse: RegionResponse?
    var countryResponse: CountryResponse?
    var categoryResponse: CategoryResponse?
    var genInfoResponse: GenInfoResponse?
    var govTaxResponse: GovTaxResponse?
    var servTaxResponse: ServiceTaxResponse?
    
    
    @IBOutlet var lblCompany: UILabel!
    var profitResponse: ProfitResponse?
    
    var selectedCountryID:Int = Int()
    var selectedCategoryID:Int = Int()
    var selectedDayID:Int = Int()
    
    var selectedprofitID:Int = Int()
    var selectedserviceTaxID:Int = Int()
    var selectedgovTaxID:Int = Int()
    var selectedRegionID:Int = Int()
    
    @IBOutlet var btnLogoF: UIButton!
    @IBOutlet var btnLogoS: UIButton!
    @IBOutlet var btnLogoT: UIButton!
    var regionDictionary:Dictionary<String,String> = Dictionary<String,String>()
    
    var selectedCountry: String?
    var countryList = ["Algeria", "Andorra", "Angola", "India","Thailand"]
    var itemsImages = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsNames = ["Myanmar","India", "China" ,"Malasyia"]
    var itemsCode = ["+95","+91", "+86" ,"+60"]
    
    @IBOutlet var scrollAccSettings: UIScrollView!
    @IBOutlet var viewScrollContent: UIView!
    
    @IBOutlet var viewGenInfo: UIView!
    @IBOutlet var viewGenInfoDetail: UIView!
    @IBOutlet var btnGenInfo: UIButton!
    @IBOutlet var bottomGenInfoDetail: NSLayoutConstraint!
    @IBOutlet var bottomGenInfo: NSLayoutConstraint!
    
    @IBOutlet weak var txtLoginId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDRSReferral: UITextField!
    @IBOutlet weak var txtDRSUserId: UITextField!
    
    
    @IBOutlet var viewBusInfo: UIView!
    @IBOutlet var viewBusInfoDetail: UIView!
    @IBOutlet weak var btnBusInfo: UIButton!
    @IBOutlet var bottomBusInfoDetail: NSLayoutConstraint!
    @IBOutlet var bottomBusInfo: NSLayoutConstraint!
    
    @IBOutlet var viewBankInfo: UIView!
    @IBOutlet var viewBankInfoDetail: UIView!
    @IBOutlet weak var btnBankInfo: UIButton!
    @IBOutlet var bottomBankInfoDetail: NSLayoutConstraint!
    @IBOutlet var bottomBankInfo: NSLayoutConstraint!
    
    @IBOutlet var viewPin: UIView!
    @IBOutlet var viewPinInfoDetail: UIView!
    @IBOutlet weak var btnPinInfo: UIButton!
    @IBOutlet var bottomPinInfoDetail: NSLayoutConstraint!
    @IBOutlet var bottomPinInfo: NSLayoutConstraint!
    
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtswiftCode: UITextField!
    @IBOutlet weak var txtBranchAddress: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var txtPin: UITextField!
    @IBOutlet weak var txtHolderName: UITextField!
    @IBOutlet weak var txtAccNum: UITextField!
    
    @IBOutlet weak var txtBusName: UITextField!
    @IBOutlet weak var txtBusAddress: UITextField!
    @IBOutlet weak var txtBusCountry: UITextField!
    @IBOutlet weak var txtBusRegion: UITextField!
    @IBOutlet weak var txtBusCategory: UITextField!
    @IBOutlet weak var txtBusOpStartHr: UITextField!
    @IBOutlet weak var txtBusOpEndHr: UITextField!
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
    @IBOutlet var txtPersonInPhone: UITextField!
    
    var statusValue:Int = 0
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
        
        if tableView == tableCountry {
            intCount = itemsCode.count
        } else  if tableView == tableViewDays {
            intCount = animals.count
        }
        return intCount
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableCountry {
            let cellBal = tableCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
            cellBal.backgroundColor = UIColor.white
            
            cellBal.selectionStyle = .none
            cellBal.imageView?.image = UIImage(named: itemsImages[indexPath.row])
            
            cellBal.lblDialCode.text = itemsCode[indexPath.row]
            return cellBal
        }
        else  if tableView == tableViewDays {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = animals[indexPath.row]
            cell.selectionStyle = .none
            if finalselectedData.contains(animals[indexPath.row])
            {
                cell.accessoryType = .checkmark
            }
            else
            {
                cell.accessoryType = .none
            }
            return cell
        }
        
        
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableCountry {
            if dialStatus == true {
                
                txtPChargeDial.text = itemsCode[indexPath.row]
                viewCountryBg.isHidden = true
                dialStatus = false
            }
            else {
                txtBusContactDialCode.text = itemsCode[indexPath.row]
                viewCountryBg.isHidden = true
                dialStatus = false
            }
        }
        else  if tableView == tableViewDays {
            
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
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        /*for item in 0..<selectedData.count {
         if selectedData[item] == animals[indexPath.row] {
         selectedData.remove(at: item)
         selectedID.remove(at: item)
         }
         }*/
        //selectedData.remove(at: indexPath.row)
        //selectedID.remove(at: indexPath.row)
        print("selectedData  ",selectedData)
        print("selectedID  ",selectedPopDayID)
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
        pickerStatus = 0
        picker.selectRow(0, inComponent: 0, animated: true)
        picker.reloadAllComponents();
        
        txtBusCountry.resignFirstResponder()
        txtBusCategory.resignFirstResponder()
        txtBusOffDay.resignFirstResponder()
        txtBusProfit.resignFirstResponder()
        txtBusGovTax.resignFirstResponder()
        txtBusServiceTax.resignFirstResponder()
        txtBusRegion.resignFirstResponder()
        
        txtBusOpStartHr.resignFirstResponder()
        txtBusOpEndHr.resignFirstResponder()
        
        
        
        if countryStatus == true {
            if txtBusCountry.text!.count <= 0 {
                selectedCountryID = self.countryID[0]
                txtBusCountry.text = self.countryName[0]
                
            }
            
            
            self.getRegion(countryID: String(selectedCountryID))
        }
            
        else if categoryStatus == true
        {
            
            if txtBusCategory.text!.count <= 0 {
                selectedCategoryID = self.categoryID[0]
                txtBusCategory.text = self.categoryName[0]
            }
            
        }
        else if dayStatus == true
        {
            print("selectedDayID",selectedDayID)
            if txtBusOffDay.text!.count <= 0 {
                selectedDayID = self.dayID[0]
                txtBusOffDay.text = self.dayName[0]
            }
            
        }
        else if profitStatus == true
        {
            if txtBusProfit.text!.count <= 0 {
                selectedprofitID = self.profitID[0]
                txtBusProfit.text = self.profitName[0]
            }
            
        }
        else if govTaxStatus ==  true
        {
            print("selectedgovTaxID ---- ",selectedgovTaxID)
            
            if txtBusGovTax.text!.count <= 0 {
                selectedgovTaxID = self.govTaxID[0]
                txtBusGovTax.text = self.govTaxName[0]
            }
            
        }
        else if serviceTaxStatus == true
        {
            if txtBusServiceTax.text!.count <= 0 {
                selectedserviceTaxID = self.serviceTaxID[0]
                txtBusServiceTax.text = self.serviceTaxName[0]
            }
        }
        else if regionStatus == true
        {
            if txtBusRegion.text!.count <= 0 {
                selectedRegionID = self.regionID[0]
                txtBusRegion.text = self.regionName[0]
            }
            
        }
        else if txtBusOpStartHr.text?.count == 0
        {
            txtBusOpStartHr.text = timeStr[0]
        }
        else if txtBusOpEndHr.text?.count == 0
        {
            txtBusOpEndHr.text = timeEndStr[0]
        }
        pickerStatus = 0
        profitStatus = false
        countryStatus = false
        regionStatus  = false
        serviceTaxStatus = false
        govTaxStatus = false
        dayStatus = false
        categoryStatus = false
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
            txtBusOpStartHr.text = pickerData[row]
            
            
        }
        else if pickerStatus == 9
        {
            txtBusOpEndHr.text = pickerData[row]
        }
        
        
        
        
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //animateViewMoving(up: false, moveValue: 205)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //delegate method
        /* if textField != txtLoginId || textField != txtPassword || textField != txtEmail || textField != txtDRSUserId || textField != txtDRSUserId
         {
         if textField == txtBusCountry{
         self.animateViewMoving(up: true, moveValue: 180)//180
         }
         else {
         self.animateViewMoving(up: true, moveValue: 205)//180
         }
         }
         */
        if textField == txtPChargeDial 
        {
            constraintTop.constant = 1070.0
            dialStatus = true
            textField.resignFirstResponder()
            viewCountryBg.isHidden = false
            
        }
        if textField == txtBusContactDialCode
        {
            constraintTop.constant = 430.0
            textField.resignFirstResponder()
            viewCountryBg.isHidden = false
        }
        
        
        if textField == txtBusOpStartHr
        {
            
            
            pickerData = self.timeStr
            txtBusOpStartHr.inputView = picker
            txtBusOpStartHr.inputAccessoryView = toolBar
            pickerStatus = 8
            startStatus = true
            if txtBusOpStartHr.text!.count>0{
                for item in 0..<self.timeStr.count {
                    if self.timeStr[item] == txtBusOpStartHr.text!  {
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                    
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusOpEndHr
        {
            pickerData = self.timeEndStr
            txtBusOpEndHr.inputView = picker
            txtBusOpEndHr.inputAccessoryView = toolBar
            pickerStatus = 9
            endtatus = true
            if txtBusOpEndHr.text!.count>0{
                for item in 0..<self.timeEndStr.count {
                    if self.timeEndStr[item] == txtBusOpEndHr.text!  {
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusCountry
        {
            pickerData = self.countryName
            txtBusCountry.inputView = picker
            txtBusCountry.inputAccessoryView = toolBar
            pickerStatus = 1
            countryStatus = true
            if txtBusCountry.text!.count>0{
                for item in 0..<self.countryName.count {
                    if self.countryName[item] == txtBusCountry.text!  {
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusCategory
        {
            pickerData = self.categoryName
            txtBusCategory.inputView = picker
            txtBusCategory.inputAccessoryView = toolBar
            pickerStatus = 2
            categoryStatus = true
            if txtBusCategory.text!.count>0{
                for item in 0..<self.categoryName.count {
                    if (txtBusCategory.text! == self.categoryName[item]){
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                    
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusOffDay
        {
            /* pickerData = self.dayName
             txtBusOffDay.inputView = picker
             txtBusOffDay.inputAccessoryView = toolBar*/
            textField.resignFirstResponder()
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
            if txtBusProfit.text!.count>0{
                for item in 0..<self.profitName.count {
                    if (txtBusProfit.text! == self.profitName[item]){
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusGovTax
        {
            pickerData = self.govTaxName
            txtBusGovTax.inputView = picker
            txtBusGovTax.inputAccessoryView = toolBar
            pickerStatus = 5
            govTaxStatus = true
            if txtBusGovTax.text!.count>0{
                for item in 0..<self.govTaxName.count {
                    if (txtBusGovTax.text! == self.govTaxName[item]){
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusServiceTax
        {
            pickerData = self.serviceTaxName
            txtBusServiceTax.inputView = picker
            txtBusServiceTax.inputAccessoryView = toolBar
            pickerStatus = 6
            serviceTaxStatus = true
            if txtBusServiceTax.text!.count>0{
                for item in 0..<self.serviceTaxName.count {
                    if (txtBusServiceTax.text! == self.serviceTaxName[item]){
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
        }
        else if textField == txtBusRegion
        {
            pickerData = self.regionName
            txtBusRegion.inputView = picker
            txtBusRegion.inputAccessoryView = toolBar
            pickerStatus = 7
            regionStatus = true
            //picker.reloadAllComponents()
            if txtBusRegion.text!.count>0{
                for item in 0..<self.regionName.count {
                    if (txtBusRegion.text! == self.regionName[item]){
                        picker.selectRow(item, inComponent: 0, animated: false)
                    }
                }
                
            }
            else {
                picker.selectRow(0, inComponent: 0, animated: false)
            }
            
            
        }
        
        
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
    
    @IBAction func btnThirdAction(_ sender: UIButton) {
        statusValue = 3
        //self.btnClicked(imgID: "3")
        self.showAlert()
    }
    
    @IBAction func btnFirstAction(_ sender: UIButton) {
        statusValue = 1
        //self.btnClicked(imgID: "1")
        self.showAlert()
    }
    
    @IBAction func bthSecondAction(_ sender: UIButton) {
        statusValue = 2
        //self.btnClicked(imgID: "2")
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear SettingsVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        
        
        
        /*
         let date = NSDate()
         
         let formatter = DateFormatter()
         formatter.dateFormat = "hh:mm:ss a"
         let time = formatter.string(from: date as Date)
         print("time ------- ",time)
         */
        
        
        
        if genInfoSelected == true
        {
            self.btnBusInfoActionPage()
        }
        
        
        
    }
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollAccSettings.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollAccSettings.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollAccSettings.contentInset = contentInset
    }
    func getMessages(){
        let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path!)
            //print("text",text)
            let xml = try! XML.parse(text)
            accSettingsMsgE.removeAll()
            //<!-- Account update -->
            if let text = xml.resource.merchant_invalid_token_account_update.text {
                print("merchant_invalid_token_account_update --------",text)
                accSettingsMsgB.append(text)
            }
            if let text = xml.resource.merchant_acc_update_success.text {
                print("merchant_acc_update_success --------",text)
                accSettingsMsgB.append(text)
            }
            if let text = xml.resource.merchant_contact_must_number.text {
                print("merchant_contact_must_number --------",text)
                accSettingsMsgB.append(text)
            }
            if let text = xml.resource.merchant_bus_contact_must_no_account_update.text {
                print("merchant_bus_contact_must_no_account_update --------",text)
                accSettingsMsgB.append(text)
            }
            if let text = xml.resource.merchant_business_contact_btwn_7_12_account_update.text {
                print("merchant_business_contact_btwn_7_12_account_update --------",text)
                accSettingsMsgB.append(text)
            }
            if let text = xml.resource.merchant_email_valid_account_update.text {
                print("merchant_email_valid_account_update --------",text)
                accSettingsMsgB.append(text)
            }
            
            
            if let text = xml.resource.merchant_contact_must_no_account_update.text {
                print("merchant_contact_must_no_account_update --------",text)
                accSettingsMsgB.append(text)
            }
            
            if let text = xml.resource.merchant_login_id_required.text {
                print("merchant_login_id_required --------",text)
                accSettingsMsgB.append(text)
                loginEmptyValidationB = text
            }
            if let text = xml.resource.merchant_email_required_account_update.text {
                print("merchant_email_required_account_update --------",text)
                accSettingsMsgB.append(text)
                emailEmptyValidationB = text
            }
            if let text = xml.resource.merchant_pay_pin_required_account_update.text {
                print("merchant_pay_pin_required_account_update --------",text)
                accSettingsMsgB.append(text)
                pinEmptyValidationB = text
            }
            if let text = xml.resource.merchant_bus_name_required_account_update.text {
                print("merchant_bus_name_required_account_update --------",text)
                accSettingsMsgB.append(text)
                bNameEmptyValidationB = text
            }
            if let text = xml.resource.merchant_bus_contact_no_required_account_update.text {
                print("merchant_bus_contact_no_required_account_update --------",text)
                accSettingsMsgB.append(text)
                bCNumEmptyValidationB = text
            }
            if let text = xml.resource.merchant_business_contact_btwn_7_12_account_update.text {
                print("merchant_business_contact_btwn_7_12_account_update --------",text)
                accSettingsMsgB.append(text)
                bCNumValidationB = text
            }
            
        }
        catch(_){print("error")}
        let path1 = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
        do {
            var text = try String(contentsOfFile: path1!)
            print("text",text)
            let xml = try! XML.parse(text)
            accSettingsMsgE.removeAll()
            //<!-- Account update -->
            if let text = xml.resource.merchant_invalid_token_account_update.text {
                print("merchant_invalid_token_account_update --------",text)
                accSettingsMsgE.append(text)
            }
            if let text = xml.resource.merchant_acc_update_success.text {
                print("merchant_acc_update_success --------",text)
                accSettingsMsgE.append(text)
            }
            if let text = xml.resource.merchant_contact_must_number.text {
                print("merchant_contact_must_number --------",text)
                accSettingsMsgE.append(text)
            }
            if let text = xml.resource.merchant_bus_contact_must_no_account_update.text {
                print("merchant_bus_contact_must_no_account_update --------",text)
                accSettingsMsgE.append(text)
            }
           
            if let text = xml.resource.merchant_email_valid_account_update.text {
                print("merchant_email_valid_account_update --------",text)
                accSettingsMsgE.append(text)
            }
            if let text = xml.resource.merchant_bus_name_required_account_update.text {
                print("merchant_bus_name_required_account_update --------",text)
                accSettingsMsgE.append(text)
            }
            
            if let text = xml.resource.merchant_contact_must_no_account_update.text {
                print("merchant_contact_must_no_account_update --------",text)
                accSettingsMsgE.append(text)
            }
            if let text = xml.resource.merchant_login_id_required.text {
                print("merchant_login_id_required --------",text)
                accSettingsMsgE.append(text)
                loginEmptyValidation = text
            }
            if let text = xml.resource.merchant_email_required_account_update.text {
                print("merchant_email_required_account_update --------",text)
                accSettingsMsgE.append(text)
                emailEmptyValidation = text
            }
            if let text = xml.resource.merchant_pay_pin_required_account_update.text {
                print("merchant_pay_pin_required_account_update --------",text)
                accSettingsMsgE.append(text)
                pinEmptyValidation = text
            }
            if let text = xml.resource.merchant_bus_name_required_account_update.text {
                print("merchant_bus_name_required_account_update --------",text)
                accSettingsMsgB.append(text)
                bNameEmptyValidation = text
            }
            if let text = xml.resource.merchant_bus_contact_no_required_account_update.text {
                print("merchant_bus_contact_no_required_account_update --------",text)
                accSettingsMsgE.append(text)
                bCNumEmptyValidation = text
            }
            if let text = xml.resource.merchant_business_contact_btwn_7_12_account_update.text {
                print("merchant_business_contact_btwn_7_12_account_update --------",text)
                accSettingsMsgE.append(text)
                bCNumValidation = text
            }
            
        }
        catch(_){print("error")}
        print("accSettingsMsgE",accSettingsMsgE)
        print("accSettingsMsgB",accSettingsMsgB)
        
    }
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                print("text",text)
                let xml = try! XML.parse(text)
                
                
                if let text = xml.resource.Setting_Account_Setting.text {
                    strTitle  = text
                    self.title = strTitle
                }
                if let text = xml.resource.Acc__Setting_general_info.text { //Acc__Setting_general_info
                    self.lblGenInfo.text = text
                }
                if let text = xml.resource.Acc_Setting_Business_Info.text {
                    self.lblBus.text = text
                }
                if let text = xml.resource.Acc_Setting_Bank_Info.text {
                    self.lblBank.text = text
                }
                if let text = xml.resource.Acc_Setting_Payment_Pin_Code.text {
                    self.lblPay.text = text
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
                    txtBusOpStartHr.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_End_Hr.text {
                    txtBusOpEndHr.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Off_Days.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Off_Days.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                txtPChargeDial.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                txtBusContactDialCode.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                
                
                
                
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
                
                if let text = xml.resource.Acc_Setting_Contact_Num.text {
                    self.txtBusContactNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Contact_Num.text {
                    self.txtPersonInPhone.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Company_Logo.text {
                    lblCompany.text = text
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnLogoF.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnLogoS.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnLogoT.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_UPDATE.text {
                    btnUpdate.setTitle(text, for: .normal)
                    print("text",text)
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
                
                
                if let text = xml.resource.Setting_Account_Setting.text {
                    strTitle  = text
                    self.title = strTitle
                }
                if let text = xml.resource.Acc__Setting_general_info.text { //Acc__Setting_general_info
                    self.lblGenInfo.text = text
                }
                if let text = xml.resource.Acc_Setting_Business_Info.text {
                    self.lblBus.text = text
                }
                if let text = xml.resource.Acc_Setting_Bank_Info.text {
                    self.lblBank.text = text
                }
                if let text = xml.resource.Acc_Setting_Payment_Pin_Code.text {
                    self.lblPay.text = text
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
                    txtBusOpStartHr.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_End_Hr.text {
                    txtBusOpEndHr.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Off_Days.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Off_Days.text {
                    txtBusOffDay.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                txtPChargeDial.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                txtBusContactDialCode.attributedPlaceholder = NSAttributedString(string: "+1", attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                
                
                
                
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
                
                if let text = xml.resource.Acc_Setting_Contact_Num.text {
                    self.txtBusContactNum.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                
                if let text = xml.resource.Acc_Setting_Contact_Num.text {
                    self.txtPersonInPhone.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Constants.PlaceholderColorReg])
                }
                if let text = xml.resource.Acc_Setting_Company_Logo.text {
                    lblCompany.text = text
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnLogoF.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnLogoS.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_Upload_Image.text {
                    btnLogoT.setTitle(text, for: .normal)
                    print("text",text)
                }
                if let text = xml.resource.Acc_Setting_UPDATE.text {
                    btnUpdate.setTitle(text, for: .normal)
                    print("text",text)
                }
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewDidLoad() {
        
        self.changeLanguage()
        self.getMessages()
        super.viewDidLoad()
        self.imgCompany.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnImageView))
        lblCompany.isUserInteractionEnabled = true
        lblCompany.addGestureRecognizer(tap)
        imgCompany.backgroundColor = Constants.textBGColor
        imgCompany.layer.cornerRadius = 10
        
        txtBusContactDialCode.text = itemsCode[0]
        txtPChargeDial.text = itemsCode[0]
        
        
        tableCountry.delegate = self
        tableCountry.dataSource = self
        
        btnLogoF.backgroundColor = Constants.textBGColor
        btnLogoS.backgroundColor = Constants.textBGColor
        btnLogoT.backgroundColor = Constants.textBGColor
        //lblCompany.backgroundColor = Constants.textBGColor
        btnLogoF.clipsToBounds = true
        btnLogoS.clipsToBounds = true
        btnLogoT.clipsToBounds = true
        btnLogoF.layer.cornerRadius = 10
        btnLogoS.layer.cornerRadius = 10
        btnLogoT.layer.cornerRadius = 10
        lblCompany.layer.cornerRadius = 10
        lblCompany?.layer.masksToBounds = true
        
        btnLogoF.titleLabel?.textAlignment = .center
        btnLogoS.titleLabel?.textAlignment = .center
        btnLogoT.titleLabel?.textAlignment = .center
        
        btnUpdate.layer.cornerRadius = btnUpdate.frame.size.height/2
        
        txtPChargeDial.backgroundColor = Constants.textBGColor
        txtBusContactDialCode.backgroundColor = Constants.textBGColor
        
        
        txtLoginId.backgroundColor = Constants.textBGColor
        txtPassword.backgroundColor = Constants.textBGColor
        txtEmail.backgroundColor = Constants.textBGColor
        txtDRSReferral.backgroundColor = Constants.textBGColor
        txtDRSUserId.backgroundColor = Constants.textBGColor
        
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
        
        txtBusOpStartHr.backgroundColor = Constants.textBGColor
        txtBusOpEndHr.backgroundColor = Constants.textBGColor
        txtBusOffDay.backgroundColor = Constants.textBGColor
        txtBusServiceTax.backgroundColor = Constants.textBGColor
        
        txtBusGovTax.backgroundColor = Constants.textBGColor
        txtBusProfit.backgroundColor = Constants.textBGColor
        txtBusSpecial.backgroundColor = Constants.textBGColor
        txtBusCertificate.backgroundColor = Constants.textBGColor
        txtBusDirectorName.backgroundColor = Constants.textBGColor
        
        txtBusICNum.backgroundColor = Constants.textBGColor
        txtBusCName.backgroundColor = Constants.textBGColor
        txtBusContactNum.backgroundColor = Constants.textBGColor
        //txtOffDaysNum.backgroundColor = Constants.textBGColor
        self.txtPersonInPhone.backgroundColor = Constants.textBGColor
        
        
        
        let paddingViewDial = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtBusContactDialCode.frame.height))
        txtBusContactDialCode.leftView = paddingViewDial
        txtBusContactDialCode.leftViewMode = UITextField.ViewMode.always
        
        let paddingViewDial1 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtPChargeDial.frame.height))
        txtPChargeDial.leftView = paddingViewDial1
        txtPChargeDial.leftViewMode = UITextField.ViewMode.always
        
        
        let paddingView123 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtPersonInPhone.leftView = paddingView123
        txtPersonInPhone.leftViewMode = UITextField.ViewMode.always
        
        
        let paddingView1 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtLoginId.leftView = paddingView1
        txtLoginId.leftViewMode = UITextField.ViewMode.always
        
        /*
         txtLoginId.rightViewMode = UITextField.ViewMode.always
         let imageView = UIImageView(frame: CGRect(x: 120, y: 0, width: 10, height: 10))
         let image = UIImage(named: "DownArrow")
         imageView.image = image
         txtLoginId.rightView = imageView*/
        
        let paddingView2 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtPassword.leftView = paddingView2
        txtPassword.leftViewMode = UITextField.ViewMode.always
        
        let paddingView3 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtEmail.leftView = paddingView3
        txtEmail.leftViewMode = UITextField.ViewMode.always
        
        let paddingView4 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtDRSReferral.leftView = paddingView4
        txtDRSReferral.leftViewMode = UITextField.ViewMode.always
        
        let paddingView5 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtDRSUserId.leftView = paddingView5
        txtDRSUserId.leftViewMode = UITextField.ViewMode.always
        
        let paddingView6 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBankName.leftView = paddingView6
        txtBankName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView7 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtswiftCode.leftView = paddingView7
        txtswiftCode.leftViewMode = UITextField.ViewMode.always
        
        let paddingView8 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBranchAddress.leftView = paddingView8
        txtBranchAddress.leftViewMode = UITextField.ViewMode.always
        
        let paddingView9 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtPin.leftView = paddingView9
        txtPin.leftViewMode = UITextField.ViewMode.always
        
        let paddingView10 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtHolderName.leftView = paddingView10
        txtHolderName.leftViewMode = UITextField.ViewMode.always
        
        let paddingView11 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtAccNum.leftView = paddingView11
        txtAccNum.leftViewMode = UITextField.ViewMode.always
        
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
        txtBusOpEndHr.leftView = paddingView17
        txtBusOpEndHr.leftViewMode = UITextField.ViewMode.always
        
        let paddingView18 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusOffDay.leftView = paddingView18
        txtBusOffDay.leftViewMode = UITextField.ViewMode.always
        
        let paddingView19 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusOpStartHr.leftView = paddingView19
        txtBusOpStartHr.leftViewMode = UITextField.ViewMode.always
        
        let paddingView20 = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: txtLoginId.frame.height))
        txtBusServiceTax.leftView = paddingView20
        txtBusServiceTax.leftViewMode = UITextField.ViewMode.always
        
        txtPChargeDial.layer.cornerRadius = 10
        txtBusContactDialCode.layer.cornerRadius = 10
        
        
        txtPersonInPhone.layer.cornerRadius = 10
        txtLoginId.layer.cornerRadius = 10
        txtPassword.layer.cornerRadius = 10
        txtEmail.layer.cornerRadius = 10
        txtDRSReferral.layer.cornerRadius = 10
        txtDRSUserId.layer.cornerRadius = 10
        
        txtBankName.layer.cornerRadius = 10
        txtswiftCode.layer.cornerRadius = 10
        txtBranchAddress.layer.cornerRadius = 10
        txtPin.layer.cornerRadius = 10
        txtHolderName.layer.cornerRadius = 10
        txtAccNum.layer.cornerRadius = 10
        
        txtBusName.layer.cornerRadius = 10
        txtBusAddress.layer.cornerRadius = 10
        txtBusCountry.layer.cornerRadius = 10
        txtBusRegion.layer.cornerRadius = 10
        txtBusCategory.layer.cornerRadius = 10
        
        txtBusOpStartHr.layer.cornerRadius = 10
        txtBusOpEndHr.layer.cornerRadius = 10
        txtBusOffDay.layer.cornerRadius = 10
        txtBusServiceTax.layer.cornerRadius = 10
        
        txtBusGovTax.layer.cornerRadius = 10
        txtBusProfit.layer.cornerRadius = 10
        txtBusSpecial.layer.cornerRadius = 10
        txtBusCertificate.layer.cornerRadius = 10
        txtBusDirectorName.layer.cornerRadius = 10
        
        txtBusICNum.layer.cornerRadius = 10
        txtBusCName.layer.cornerRadius = 10
        txtBusContactNum.layer.cornerRadius = 10
        
        
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
        txtBusContactNum.leftView = paddingView30
        txtBusContactNum.leftViewMode = UITextField.ViewMode.always
        
        
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
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
        
        bottomGenInfoDetail.priority = UILayoutPriority(rawValue: 998)
        bottomGenInfo.priority = UILayoutPriority(rawValue: 999)
        viewGenInfoDetail.isHidden = true
        
        bottomBusInfoDetail.priority = UILayoutPriority(rawValue: 998)
        bottomBusInfo.priority = UILayoutPriority(rawValue: 999)
        viewBusInfoDetail.isHidden = true
        
        bottomBankInfoDetail.priority = UILayoutPriority(rawValue: 998)
        bottomBankInfo.priority = UILayoutPriority(rawValue: 999)
        viewBankInfoDetail.isHidden = true
        
        bottomPinInfoDetail.priority = UILayoutPriority(rawValue: 998)
        bottomPinInfo.priority = UILayoutPriority(rawValue: 999)
        viewPinInfoDetail.isHidden = true
        
        
        if Reachability.isConnectedToNetwork() {
            
            
            self .getCountry()
            
            
            
        }
        
        txtPChargeDial.delegate = self
        txtBusContactDialCode.delegate = self
        txtPersonInPhone.delegate = self
        txtBusContactNum.delegate = self
        txtBusOpStartHr.delegate = self
        txtBusOpEndHr.delegate = self
        
        viewGenInfo.layer.cornerRadius = 15
        viewGenInfo.clipsToBounds = true
        viewBusInfo.layer.cornerRadius = 15
        viewBusInfo.clipsToBounds = true
        viewBankInfo.layer.cornerRadius = 15
        viewBankInfo.clipsToBounds = true
        viewPin.layer.cornerRadius = 15
        viewPin.clipsToBounds = true
        
        
        txtLoginId.delegate = self
        txtPassword.delegate = self
        txtEmail.delegate = self
        txtDRSReferral.delegate = self
        txtDRSUserId.delegate = self
        
        
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
        txtBusOpStartHr.delegate = self
        txtBusOpEndHr.delegate = self
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
        
        self.txtBusContactNum.delegate = self
        self.txtPersonInPhone.delegate = self
        // Do any additional setup after loading the view.
        
        
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
        
        
        let viewS = UIView(frame: CGRect(x: -15, y: txtBusCountry.frame.size.height/2, width: 10, height: 10))
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
        
        
        let view11 = UIView(frame: CGRect(x: 0, y: txtBusOpStartHr.frame.size.height/2, width: 10, height: 10))
        txtBusOpStartHr.rightViewMode = UITextField.ViewMode.always
        let imageView11 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image11 = UIImage(named: "DownArrow")
        imageView11.image = image11
        view11.addSubview(imageView11)
        txtBusOpStartHr.rightView = view11
        
        let view12 = UIView(frame: CGRect(x: 0, y: txtBusOpEndHr.frame.size.height/2, width: 10, height: 10))
        txtBusOpEndHr.rightViewMode = UITextField.ViewMode.always
        let imageView12 = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let image12 = UIImage(named: "DownArrow")
        imageView12.image = image12
        view12.addSubview(imageView12)
        txtBusOpEndHr.rightView = view12
        
        
        
        let view13 = UIView(frame: CGRect(x: 0, y: txtBusContactDialCode.frame.size.height/2, width: 10, height: 10))
        txtBusContactDialCode.rightViewMode = UITextField.ViewMode.always
        let imageView13 = UIImageView(frame: CGRect(x: -5, y: 0, width: 10, height: 10))
        let image13 = UIImage(named: "DownArrow")
        imageView13.image = image13
        view13.addSubview(imageView13)
        txtBusContactDialCode.rightView = view13
        
        let view14 = UIView(frame: CGRect(x: 0, y: txtPChargeDial.frame.size.height/2, width: 10, height: 10))
        txtPChargeDial.rightViewMode = UITextField.ViewMode.always
        let imageView14 = UIImageView(frame: CGRect(x: -5, y: 0, width: 10, height: 10))
        let image14 = UIImage(named: "DownArrow")
        imageView14.image = image14
        view14.addSubview(imageView14)
        txtPChargeDial.rightView = view14
        
        
        
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtAccNum.inputAccessoryView = numberToolbar
        txtBusContactNum.inputAccessoryView = numberToolbar
        txtPersonInPhone.inputAccessoryView = numberToolbar
    }
    
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtAccNum.resignFirstResponder()
        txtBusContactNum.resignFirstResponder()
        txtPersonInPhone.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtAccNum.resignFirstResponder()
        txtBusContactNum.resignFirstResponder()
        txtPersonInPhone.resignFirstResponder()
    }
    
    func getAllInfo(accessToken: String) {
        self.view.activityStartAnimating()
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":accessToken,
        ]
        let loginURL = Constants.baseURL+Constants.AccountURL
        
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
                    //accountInfoDetailResponse
                    let response = JSON(data.data!)
                    self.accountInfoDetailResponse = AccountInfoDetailResponse(response)
                    print("self.accountInfoDetailResponse 1",self.accountInfoDetailResponse!)
                    print("self.accountInfoDetailResponse 1",String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.referalId)!))
                    print("self.accountInfoDetailResponse 1",self.accountInfoDetailResponse)
                    
                    
                    let statusCode = Int((self.accountInfoDetailResponse?.httpcode)!)
                    if statusCode == 200{
                        self.txtLoginId.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.loginId)!)
                        //self.txtPassword.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.)!)
                        self.txtEmail.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.email)!)
                        self.txtDRSReferral.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.referalId)!)
                        //self.txtDRSUserId.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.loginId)!)
                        self.txtPin.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.generalInfoDat?.paymentPincode)!)
                        
                        self.txtBankName.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.bankInfoDat?.bankName)!)
                        self.txtswiftCode.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.bankInfoDat?.swiftCode)!)
                        self.txtBranchAddress.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.bankInfoDat?.branchAddress)!)
                        self.txtHolderName.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.bankInfoDat?.accountHolder)!)
                        self.txtAccNum.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.bankInfoDat?.accountNumber)!)
                        
                        self.txtBusName.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.businessName)!)
                        self.txtBusAddress.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.businessAddress)!)
                        //self.txtBusCountry.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.country)!)
                        //self.txtBusRegion.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.region)!)
                        //self.txtBusCategory.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.category)!)
                        self.txtBusContactNum.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.businessContactNumber)!)
                        self.txtPersonInPhone.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.contactNumber)!)
                        
                        self.txtBusContactDialCode.text = (self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.busCountryCode)!
                        self.txtPChargeDial.text = (self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.contactCountryCode)!
                        
                        let inFormatter = DateFormatter()
                        inFormatter.locale = Locale(identifier: "en_US_POSIX")
                        inFormatter.dateFormat = "HH:mm:ss"
                        
                        let outFormatter = DateFormatter()
                        outFormatter.locale = Locale(identifier: "en_US_POSIX")
                        outFormatter.dateFormat = "hh:mm a"
                        
                        //let inStr = "03:30:00"
                        let inStr = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.operationStartTime)!)
                        let date = inFormatter.date(from: inStr)!
                        let outStr = outFormatter.string(from: date)
                        print(outStr) // -> outputs 04:50
                        
                        self.txtBusOpStartHr.text = outStr
                        
                        let inFormatter1 = DateFormatter()
                        inFormatter1.locale = Locale(identifier: "en_US_POSIX")
                        inFormatter1.dateFormat = "HH:mm:ss"
                        
                        let outFormatter1 = DateFormatter()
                        outFormatter1.locale = Locale(identifier: "en_US_POSIX")
                        outFormatter1.dateFormat = "hh:mm a"
                        
                        //let inStr = "03:30:00"
                        
                        let inStr1 = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.operationEndTime)!)
                        let date1 = inFormatter.date(from: inStr1)!
                        let outStr1 = outFormatter.string(from: date1)
                        print(outStr1) // -> outputs 04:50
                        self.txtBusOpEndHr.text = outStr1
                        
                        print("outStr",outStr)
                        print("outStr1",outStr1)
                        
                        
                        
                        // self.txtBusOpEndHr.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.operationStartTime)!)
                        //self.txtBusOpStartHr.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.operationEndTime)!)
                        
                        self.txtBusOffDay.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.offDaysLabel)!)
                        //self.txtBusServiceTax.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.serviceTax)!)
                        //self.txtBusGovTax.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.governmentTax)!)
                        //self.txtBusProfit.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.profitShare)!)
                        self.txtBusSpecial.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.specialCondition)!)
                        self.txtBusCertificate.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.businessCertificate)!)
                        //String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.businessCertificate)!)
                        self.txtBusDirectorName.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.directorName)!)
                        self.txtBusICNum.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.directorIcnumber)!)
                        self.txtBusCName.text = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.personIncharge)!)
                        self.finalselectedID =  String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.offDays)!)
                        self.finalselectedData = String((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.offDaysLabel)!)
                        
                        self.regionStatus = true
                        for item in 0..<self.countryID.count {
                            //print("txtBusCountry",self.countryID[item])
                            //if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.country)!) == self.countryID[item]{
                            if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.country)!) == self.countryID[item]{
                                self.txtBusCountry.text = self.countryName[item]
                                self.selectedCountryID = self.countryID[item]
                                
                            }
                        }
                        
                        
                        
                        for item in 0..<self.categoryID.count {
                            //print("categoryID",self.categoryID[item])
                            if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.category)!) == self.categoryID[item]{
                                self.txtBusCategory.text = self.categoryName[item]
                                self.selectedCategoryID = self.categoryID[item]
                            }
                        }
                        /*
                         for item in 0..<self.dayID.count {
                         //print("dayID",self.dayID[item])
                         if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.offDays)!) == self.dayID[item]{
                         self.txtBusOffDay.text = self.dayName[item]
                         self.selectedDayID = self.dayID[item]
                         }
                         }
                         */
                        for item in 0..<self.profitID.count {
                            //print("profitID",self.profitID[item])
                            if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.profitShare)!) == self.profitID[item]{
                                self.txtBusProfit.text = self.profitName[item]
                                self.selectedprofitID = self.profitID[item]
                            }
                        }
                        
                        for item in 0..<self.serviceTaxID.count {
                            //print("profitID",self.serviceTaxID[item])
                            if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.serviceTax)!) == self.serviceTaxID[item]{
                                self.txtBusServiceTax.text = self.serviceTaxName[item]
                                self.selectedserviceTaxID = self.serviceTaxID[item]
                            }
                        }
                        
                        for item in 0..<self.govTaxID.count {
                            //print("govTaxName",self.govTaxID[item])
                            //print("govTaxName",self.govTaxName[item])
                            if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.governmentTax)!) == self.govTaxID[item]{
                                self.txtBusGovTax.text = self.govTaxName[item]
                                self.selectedgovTaxID = self.govTaxID[item]
                                //print("selectedgovTaxID",self.govTaxName[item])
                            }
                        }
                        
                        
                        
                        let url = URL(string: (self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.companyLogo)!)
                        
                        DispatchQueue.global().async {
                            if url != nil{
                                
                                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    if data!.count>0{
                                        self.imgCompany.layer.cornerRadius = 10
                                        if let data = try? Data(contentsOf: url!) {
                                            self.imgCompany.image = UIImage(data: data)
                                        }
                                        
                                        
                                    }
                                    self.lblCompany.text = ""
                                }
                                
                            }
                        }
                        
                        let url1 = URL(string: (self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.promoImage1)!)
                        
                        
                        
                        DispatchQueue.global().async {
                            if url1 != nil{
                                let data = try? Data(contentsOf: url1!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    if let data = try? Data(contentsOf: url1!) {
                                        DispatchQueue.main.async {
                                            self.btnLogoF.setImage(UIImage(data: data)?.withRenderingMode(.alwaysOriginal), for: .normal)
                                        }
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        
                        let url2 = URL(string: (self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.promoImage2)!)
                        if url2 != nil{
                            DispatchQueue.global().async {
                               
                                DispatchQueue.main.async {
                                    // self.btnLogoS.setImage(UIImage(data: data!), for: .normal)
                                    if let data = try? Data(contentsOf: url2!) {
                                        DispatchQueue.main.async {
                                            self.btnLogoS.setImage(UIImage(data: data)?.withRenderingMode(.alwaysOriginal), for: .normal)
                                        }
                                    }
                                    //self.btnLogoS.setImage(UIImage(data: data!)?.withRenderingMode(.alwaysOriginal), for: .normal)
                                }
                            }
                            
                            
                        }
                        let url3 = URL(string: (self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.promoImage3)!)
                        if url3 != nil{
                            DispatchQueue.global().async {
                               
                                DispatchQueue.main.async {
                                    if let data = try? Data(contentsOf: url3!) {
                                        DispatchQueue.main.async {
                                            self.btnLogoT.setImage(UIImage(data: data)?.withRenderingMode(.alwaysOriginal), for: .normal)
                                        }
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        self.getRegion(countryID: String(self.selectedCountryID))
                        
                        
                        
                        
                    }
                    if statusCode == 400{
                        self.view.activityStopAnimating()
                        if let range3 = (self.accountInfoDetailResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.accountInfoDetailResponse?.message)!)
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
                        
                        self.getAllInfo(accessToken: self.sharedData.getAccessToken())
                        //self.getUserGenInfo(accessToken: self.sharedData.getAccessToken())
                        //self.getUserAccInfo(accessToken: self.sharedData.getAccessToken())
                        //self.getBankInfo(accessToken: self.sharedData.getAccessToken())
                        
                        
                    }
                    self.view.activityStopAnimating()
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    @IBAction func btnGenInfoAction(_ sender: UIButton) {
        
        if sender.isSelected == false {
            bottomGenInfoDetail.priority = UILayoutPriority(rawValue: 999)
            bottomGenInfo.priority = UILayoutPriority(rawValue: 998)
            viewGenInfoDetail.isHidden = false
            
        } else {
            bottomGenInfoDetail.priority = UILayoutPriority(rawValue: 998)
            bottomGenInfo.priority = UILayoutPriority(rawValue: 999)
            viewGenInfoDetail.isHidden = true
            
        }
        sender.isSelected = !sender.isSelected
        
        
    }
    
    func btnBusInfoActionPage() {
        
        genInfoSelected = false
        bottomBusInfoDetail.priority = UILayoutPriority(rawValue: 999)
        bottomBusInfo.priority = UILayoutPriority(rawValue: 998)
        viewBusInfoDetail.isHidden = false
        //self .getUserAccInfo(accessToken: "11486552")
        
        
        
    }
    @IBAction func btnBusInfoAction(_ sender: UIButton) {
        
        if sender.isSelected == false {
            bottomBusInfoDetail.priority = UILayoutPriority(rawValue: 999)
            bottomBusInfo.priority = UILayoutPriority(rawValue: 998)
            viewBusInfoDetail.isHidden = false
            //self .getUserAccInfo(accessToken: "11486552")
            
        } else {
            bottomBusInfoDetail.priority = UILayoutPriority(rawValue: 998)
            bottomBusInfo.priority = UILayoutPriority(rawValue: 999)
            viewBusInfoDetail.isHidden = true
            
        }
        sender.isSelected = !sender.isSelected
        
    }
    @IBAction func btnBankInfoAction(_ sender: UIButton) {
        
        if sender.isSelected == false {
            bottomBankInfoDetail.priority = UILayoutPriority(rawValue: 999)
            bottomBankInfo.priority = UILayoutPriority(rawValue: 998)
            viewBankInfoDetail.isHidden = false
            
        } else {
            bottomBankInfoDetail.priority = UILayoutPriority(rawValue: 998)
            bottomBankInfo.priority = UILayoutPriority(rawValue: 999)
            viewBankInfoDetail.isHidden = true
            
        }
        sender.isSelected = !sender.isSelected
        
    }
    @IBAction func btnBankPinAction(_ sender: UIButton) {
        
        if sender.isSelected == false {
            bottomPinInfoDetail.priority = UILayoutPriority(rawValue: 999)
            bottomPinInfo.priority = UILayoutPriority(rawValue: 998)
            viewPinInfoDetail.isHidden = false
            
        } else {
            bottomPinInfoDetail.priority = UILayoutPriority(rawValue: 998)
            bottomPinInfo.priority = UILayoutPriority(rawValue: 999)
            viewPinInfoDetail.isHidden = true
            
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func btnUpdateAction(_ sender: Any) {
        self.accountUpdate()
    }
    
    
    
    
    func getUserGenInfo(accessToken:String) {
        self.view.activityStartAnimating()
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":accessToken,
        ]
        let loginURL = Constants.baseURL+Constants.GenInfoURL
        
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
                    self.genInfoResponse = GenInfoResponse(response)
                    print("self.genInfoResponse 1",self.genInfoResponse!)
                    print("self.genInfoResponse 1",self.genInfoResponse?.httpcode!)
                    print("self.genInfoResponse 1",self.genInfoResponse?.generalInfoData?.generalInfo)
                    
                    
                    let statusCode = Int((self.genInfoResponse?.httpcode)!)
                    if statusCode == 200{
                        self.txtLoginId.text = String((self.genInfoResponse?.generalInfoData?.generalInfo?.loginId)!)
                        self.txtEmail.text = String((self.genInfoResponse?.generalInfoData?.generalInfo?.email)!)
                        self.txtDRSReferral.text = String((self.genInfoResponse?.generalInfoData?.generalInfo?.referalId)!)
                        self.txtDRSUserId.text = String((self.genInfoResponse?.generalInfoData?.generalInfo?.drsUserid)!)
                        self.txtPin.text = String((self.genInfoResponse?.generalInfoData?.generalInfo?.paymentPincode)!)
                        
                    }
                    if statusCode == 400{
                        self.view.activityStopAnimating()
                        if let range3 = (self.genInfoResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.genInfoResponse?.message)!)
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
    func getUserAccInfo(accessToken:String) {
        self.view.activityStartAnimating()
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":accessToken,
        ]
        let loginURL = Constants.baseURL+Constants.AccountInfoURL
        
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
                    self.accInfoResponse = AccountInfoResponse(response)
                    print("self.accInfoResponse ",self.accInfoResponse!)
                    print("self.accInfoResponse ",self.accInfoResponse?.httpcode!)
                    print("self.accInfoResponse ",self.accInfoResponse?.accountInfoData?.businessInfo)
                    
                    
                    let statusCode = Int((self.accInfoResponse?.httpcode)!)
                    if statusCode == 200{
                        self.regionStatus = true
                        for item in 0..<self.countryID.count {
                            //print("txtBusCountry",self.countryID[item])
                            if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.country)!) == self.countryID[item]{
                                self.txtBusCountry.text = self.countryName[item]
                                self.selectedCountryID = self.countryID[item]
                            }
                        }
                        self.getRegion(countryID: String(self.selectedCountryID))
                        
                        
                        for item in 0..<self.categoryID.count {
                            //print("categoryID",self.categoryID[item])
                            if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.category)!) == self.categoryID[item]{
                                self.txtBusCategory.text = self.categoryName[item]
                                self.selectedCategoryID = self.categoryID[item]
                            }
                        }
                        
                        for item in 0..<self.dayID.count {
                            //print("dayID",self.dayID[item])
                            if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.offDays)!) == self.dayID[item]{
                                self.txtBusOffDay.text = self.dayName[item]
                                self.selectedDayID = self.dayID[item]
                            }
                        }
                        
                        for item in 0..<self.profitID.count {
                            //print("profitID",self.profitID[item])
                            if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.profitShare)!) == self.profitID[item]{
                                self.txtBusProfit.text = self.profitName[item]
                                self.selectedprofitID = self.profitID[item]
                            }
                        }
                        
                        for item in 0..<self.serviceTaxID.count {
                            //print("profitID",self.serviceTaxID[item])
                            if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.serviceTax)!) == self.serviceTaxID[item]{
                                self.txtBusServiceTax.text = self.serviceTaxName[item]
                                self.selectedserviceTaxID = self.serviceTaxID[item]
                            }
                        }
                        
                        for item in 0..<self.govTaxID.count {
                            //print("govTaxName",self.govTaxID[item])
                            //print("govTaxName",self.govTaxName[item])
                            if Int((self.accInfoResponse?.accountInfoData?.businessInfo?.governmentTax)!) == self.govTaxID[item]{
                                self.txtBusGovTax.text = self.govTaxName[item]
                                self.selectedgovTaxID = self.govTaxID[item]
                                //print("selectedgovTaxID",self.govTaxName[item])
                            }
                        }
                        
                        
                        let url = URL(string: (self.accInfoResponse?.accountInfoData?.businessInfo?.companyLogo)!)
                        
                        DispatchQueue.global().async {
                            if url != nil{
                                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    if data!.count>0{
                                        self.imgCompany.layer.cornerRadius = 10
                                        self.imgCompany.image = UIImage(data: data!)
                                        //self.imgCompany.setImage(UIImage(data: data!), for: .normal)
                                        
                                    }
                                    self.lblCompany.text = ""
                                }
                                
                            }
                        }
                        
                        let url1 = URL(string: (self.accInfoResponse?.accountInfoData?.businessInfo?.promoImage1)!)
                        
                        DispatchQueue.global().async {
                            if url1 != nil{
                                let data = try? Data(contentsOf: url1!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    //self.imageFromUrl((self.accInfoResponse?.accountInfoData?.businessInfo?.promoImage1)!)
                                    self.btnLogoF.setImage(UIImage(data: data!), for: .normal)
                                }
                            }
                            
                        }
                        
                        
                        let url2 = URL(string: (self.accInfoResponse?.accountInfoData?.businessInfo?.promoImage2)!)
                        if url2 != nil{
                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: url2!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    self.btnLogoS.setImage(UIImage(data: data!), for: .normal)
                                }
                            }
                            
                            
                        }
                        let url3 = URL(string: (self.accInfoResponse?.accountInfoData?.businessInfo?.promoImage2)!)
                        if url3 != nil{
                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: url3!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                                DispatchQueue.main.async {
                                    self.btnLogoT.setImage(UIImage(data: data!), for: .normal)
                                }
                            }
                            
                        }
                        
                        
                        self.txtBusName.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.businessName)!)
                        self.txtBusAddress.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.businessAddress)!)
                        //self.txtBusCountry.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.country)!)
                        //self.txtBusRegion.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.region)!)
                        //self.txtBusCategory.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.category)!)
                        self.txtBusContactNum.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.contactNumber)!)
                        
                        self.txtBusOpEndHr.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.operationStartTime)!)
                        self.txtBusOpStartHr.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.operationEndTime)!)
                        
                        self.txtBusOffDay.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.offDays)!)
                        //self.txtBusServiceTax.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.serviceTax)!)
                        //self.txtBusGovTax.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.governmentTax)!)
                        //self.txtBusProfit.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.profitShare)!)
                        self.txtBusSpecial.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.specialCondition)!)
                        self.txtBusCertificate.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.businessCertificate)!)
                        self.txtBusDirectorName.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.directorName)!)
                        self.txtBusICNum.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.directorIcnumber)!)
                        self.txtBusCName.text = String((self.accInfoResponse?.accountInfoData?.businessInfo?.personIncharge)!)
                        
                        
                        
                        
                        
                        
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.accInfoResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.accInfoResponse?.message)!)
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
    func imageFromUrl(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    if imageData != nil {
                        if let img = UIImage(data: imageData as! Data){
                            DispatchQueue.main.async {
                                //self.userAvatarButton.setImage(img, for: .normal)
                                self.btnLogoF.setImage(img, for: .normal)
                            }
                        }
                    } else {
                        print("error")
                    }
                }
            }
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
                        
                        if self.regionStatus == true {
                            self.regionStatus = false
                            for item in 0..<self.regionID.count {
                                print("regionID",self.regionID[item])
                                if Int((self.accountInfoDetailResponse?.accountInfoDetData?.businessInfoDat?.region)!) == self.regionID[item]{
                                    self.txtBusRegion.text = self.regionName[item]
                                    self.selectedRegionID = self.regionID[item]
                                }
                            }
                            
                        }
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
    /*
     func getCountry() {
     self.view.activityStartAnimating()
     
     
     let loginURL = Constants.baseURL+Constants.CountriesURL
     
     AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
     print("Response:***:",data.description)
     
     switch (data.result) {
     case .failure(let error) :
     self.view.activityStopAnimating()
     
     if error._code == NSURLErrorTimedOut {
     self.showToast(message: "Request timed out! Please try again!")
     }
     else if error._code == 4 {
     self.showToast(message: "Internal server error! Please try again!")
     }
     else if error._code == -1003 {
     self.showToast(message: "Server error! Please contact support!")
     }
     case .success :
     do {
     
     let response = JSON(data.data!)
     self.countryResponse = CountryResponse(response)
     print("self.loginResponse ",self.countryResponse!)
     print("self.loginResponse ",self.countryResponse?.httpcode!)
     print("self.loginResponse ",self.countryResponse?.countryData?.countryList)
     
     let statusCode = Int((self.countryResponse?.httpcode)!)
     if statusCode == 200{
     self.countryID.removeAll()
     self.countryName.removeAll()
     for item in (self.countryResponse?.countryData?.countryList)! {
     self.countryID.append(item.id!)
     self.countryName.append(item.name!)
     }
     }
     print("countryID ",self.countryID)
     print("countryName ",self.countryName)
     if statusCode == 400{
     
     }
     
     self.view.activityStopAnimating()
     
     }
     catch let err {
     print("Error::",err.localizedDescription)
     }
     }
     }
     }
     */
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
                            self.profitName.append(item.title!)
                        }
                    }
                    print("profitID ",self.profitID)
                    print("profitName ",self.profitName)
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.profitResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
                            self.showToast(message:(self.profitResponse?.message!)! )
                            
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
    func getBankInfo(accessToken:String) {
        self.view.activityStartAnimating()
        
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":accessToken,
        ]
        let loginURL = Constants.baseURL+Constants.BankInfoURL
        
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
                    self.bankInfoResponse = BankInfoResponse(response)
                    print("self.bankInfoResponse ",self.bankInfoResponse!)
                    print("self.bankInfoResponse ",self.bankInfoResponse?.httpcode!)
                    print("self.bankInfoResponse ",self.bankInfoResponse?.bankInfoData?.bankInfo)
                    
                    
                    let statusCode = Int((self.bankInfoResponse?.httpcode)!)
                    if statusCode == 200{
                        
                        
                        self.txtBankName.text = self.bankInfoResponse?.bankInfoData?.bankInfo?.bankName
                        self.txtswiftCode.text = self.bankInfoResponse?.bankInfoData?.bankInfo?.swiftCode
                        self.txtBranchAddress.text = self.bankInfoResponse?.bankInfoData?.bankInfo?.branchAddress
                        self.txtHolderName.text = self.bankInfoResponse?.bankInfoData?.bankInfo?.accountHolder
                        self.txtAccNum.text = self.bankInfoResponse?.bankInfoData?.bankInfo?.accountNumber
                        
                        
                        
                    }
                    if statusCode == 400{
                        
                        self.view.activityStopAnimating()
                        if let range3 = (self.bankInfoResponse?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                            self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.bankInfoResponse?.message)!)
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
    
    
    func compressImage(img:UIImage) -> UIImage {
        
        let oldImage = img
        var imageData =  Data(oldImage.pngData()! )
        print("***** Uncompressed Size \(imageData.description) **** ")
        
        imageData = oldImage.jpegData(compressionQuality: 0.025)!
        print("***** Compressed Size \(imageData.description) **** ")
        
        let image = UIImage(data: imageData)
        return image!
        
    }
    func imageIsNullOrNot(imageName : UIImage)-> Bool
    {
        
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    
    func accountUpdate() {
        
        if Reachability.isConnectedToNetwork() {
            if (txtLoginId.text!.count<=0)
            {
                if sharedData.getLanguage() == 1 {
                    self.showAlert(title: sharedData.getAppName(), message: loginEmptyValidationB)
                }
                else if sharedData.getLanguage() == 0 {
                    self.showAlert(title: sharedData.getAppName(), message: loginEmptyValidation)
                }
                
            }
            
            else if (txtEmail.text!.count<=0)
            {
                if sharedData.getLanguage() == 1 {
                    self.showAlert(title: sharedData.getAppName(), message: emailEmptyValidationB)
                }
                else if sharedData.getLanguage() == 0 {
                    self.showAlert(title: sharedData.getAppName(), message: emailEmptyValidation)
                }
               
            }
            else if (txtPin.text!.count<=0)
            {
                if sharedData.getLanguage() == 1 {
                    self.showAlert(title: sharedData.getAppName(), message: pinEmptyValidationB)
                }
                else if sharedData.getLanguage() == 0 {
                    self.showAlert(title: sharedData.getAppName(), message: pinEmptyValidation)
                }
                
            }
            else if (txtBusName.text!.count<=0)
            {
                if sharedData.getLanguage() == 1 {
                    self.showAlert(title: sharedData.getAppName(), message: bNameEmptyValidationB)
                }
                else if sharedData.getLanguage() == 0 {
                    self.showAlert(title: sharedData.getAppName(), message: Constants.BNameEmptyValidation)
                }
                
            }
            else if (txtBusOpStartHr.text!.count<=0)
            {
                if sharedData.getLanguage() == 1 {
                    self.showAlert(title: sharedData.getAppName(), message: bCNumEmptyValidationB)
                }
                else if sharedData.getLanguage() == 0 {
                    self.showAlert(title: sharedData.getAppName(), message: Constants.BCNumEmptyValidation)
                }
                
            }
            else if (txtBusContactNum.text!.count<7 || txtBusContactNum.text!.count>12)
            {
                
                if sharedData.getLanguage() == 1 {
                    self.showAlert(title: sharedData.getAppName(), message: bCNumEmptyValidationB)
                }
                else if sharedData.getLanguage() == 0 {
                    self.showAlert(title: sharedData.getAppName(), message: Constants.BCNumEmptyValidation)
                    
                }
            }
                
                
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.view.activityStartAnimating()
                }
                print("txtBusOpStartHr.text!",txtBusOpStartHr.text!)
                print("txtBusOpEndHr",txtBusOpEndHr.text!)
                let sharedData = SharedDefault()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // DispatchQueue.main.async {
                    
                    if (self.imageIsNullOrNot(imageName: self.imageFirst))
                    {
                        let resizedImage1:UIImage = self.compressImage(img: self.imageFirst)
                        self.firstImgData = self.convertImageToBase_64(image: resizedImage1.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                    }
                    if (self.imageIsNullOrNot(imageName: self.imageSeond))
                    {
                        let resizedImage2:UIImage = self.compressImage(img: self.imageSeond)
                        self.secondImgData = self.convertImageToBase_64(image: resizedImage2.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                    }
                    if (self.imageIsNullOrNot(imageName: self.imageThird))
                    {
                        let resizedImage3:UIImage = self.compressImage(img: self.imageThird)
                        self.thirdImgData = self.convertImageToBase_64(image: resizedImage3.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                    }
                    if (self.imageIsNullOrNot(imageName: self.imageCompanyFourth))
                    {
                        let resizedImage4:UIImage = self.compressImage(img: self.imageCompanyFourth)
                        self.companyImgData = self.convertImageToBase_64(image: resizedImage4.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                    }
                    
                    /*
                     if self.imageFirst == nil{
                     let resizedImage1:UIImage = self.compressImage(img: self.imageFirst)
                     self.firstImgData = self.convertImageToBase_64(image: resizedImage1.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                     }
                     
                     if self.imageSeond != nil{
                     let resizedImage2:UIImage = self.compressImage(img: self.imageSeond)
                     self.secondImgData = self.convertImageToBase_64(image: resizedImage2.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                     }
                     
                     if self.imageThird != nil{
                     let resizedImage3:UIImage = self.compressImage(img: self.imageThird)
                     self.thirdImgData = self.convertImageToBase_64(image: resizedImage3.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                     }
                     
                     if self.imageCompanyFourth != nil{
                     let resizedImage4:UIImage = self.compressImage(img: self.imageCompanyFourth)
                     self.companyImgData = self.convertImageToBase_64(image: resizedImage4.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
                     }
                     */
                    
                    
                    
                    var postDict = Dictionary<String,String>()
                    postDict = [
                        "access_token":sharedData.getAccessToken(),
                        "login_id":self.txtLoginId.text!,
                        "password":self.txtPassword.text!,
                        "email":self.txtEmail.text!,
                        "referal_id":self.txtDRSReferral.text!,
                        
                        "business_name":self.txtBusName.text!,
                        "business_address":self.txtBusAddress.text!,
                        "country":String(self.selectedCountryID),
                        "region":String(self.selectedRegionID),
                        "category":String(self.selectedCategoryID),
                        "business_contact_number":self.txtBusContactNum.text!,
                        "operation_start_time":self.txtBusOpStartHr.text!,
                        "operation_end_time":self.txtBusOpEndHr.text!,
                        "off_day":self.finalselectedID,
                        "service_tax":String(self.selectedserviceTaxID),
                        "government_tax":String(self.selectedgovTaxID),
                        "profit_share":String(self.selectedprofitID),
                        "special_condition":self.txtBusSpecial.text!,
                        "business_certificate":self.txtBusCertificate.text!,
                        "director_name":self.txtBusDirectorName.text!,
                        "director_icnumber":self.txtBusICNum.text!,
                        "person_incharge":self.txtBusCName.text!,
                        
                        "bank_name":self.txtBankName.text!,
                        "branch_address":self.txtBranchAddress.text!,
                        "swift_code":self.txtswiftCode.text!,
                        "account_holder":self.txtHolderName.text!,
                        "account_number":self.txtAccNum.text!,
                        "payment_pincode":self.txtPin.text!,
                        "company_logo":self.companyImgData,
                        "promo_image_1":self.firstImgData,
                        "promo_image_2":self.secondImgData,
                        "promo_image_3":self.thirdImgData,
                        "contact_number":self.txtPersonInPhone.text!,
                        "business_country_code":self.txtBusContactDialCode.text!,
                        "contact_country_code":self.txtPChargeDial.text!
                        
                        
                    ]
                    //"drs_userid":txtDRSUserId.text!,
                    //print("PostData: ",postDict)
                    let loginURL = Constants.baseURL+Constants.ProfileUpdateURL
                    
                    AF.request(loginURL, method: .post, parameters: postDict, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
                        //print("Response:***:",data.description)
                        
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
                                    let sharedDefault = SharedDefault()
                                    if sharedDefault.getLanguage() == 1
                                    {
                                        self.showAlert(title: sharedData.getAppName(), message:"အောင်မြင်စွာသိမ်းဆည်းပြီး")
                                    }
                                    else  if sharedDefault.getLanguage() == 0
                                    {
                                        self.showAlert(title: sharedData.getAppName(), message:(self.loginResponse?.message)!)
                                    }
                                    

                                    
                                    
                                    //let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                    //self.navigationController?.pushViewController(next, animated: true)
                                    /*self.btnLogoF.setTitle("Upload Image 1", for: .normal)
                                     self.btnLogoS.setTitle("Upload Image 2", for: .normal)
                                     self.btnLogoT.setTitle("Upload Image 3", for: .normal)*/
                                    self.companyImgData = ""
                                    self.thirdImgData = ""
                                    self.secondImgData = ""
                                    self.firstImgData = ""
                                    
                                    self.imageCompanyFourth = UIImage()
                                    self.imageFirst = UIImage()
                                    self.imageSeond = UIImage()
                                    self.imageThird = UIImage()
                                }
                                if statusCode == 400{
                                    
                                    self.view.activityStopAnimating()
                                    
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
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {let sharedDefault = SharedDefault()
                                            sharedDefault .setLoginStatus(loginStatus: false)
                                            sharedDefault.clearAccessToken()
                                            
                                            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                            let customViewControllersArray : NSArray = [newViewController]
                                            self.navigationController?.viewControllers = customViewControllersArray as! [UIViewController]
                                            self.navigationController?.popToRootViewController(animated: true)
                                        }
                                        
                                    }
                                        
//                                        else {
//                                        //self.showAlert(title: Constants.APP_ALERT_TITLE, message: (self.loginResponse?.message)!)
//                                        for index in 0..<self.accSettingsMsgE.count {
//                                            if let range3 = (self.loginResponse?.message)!.range(of: self.accSettingsMsgE[index], options: .caseInsensitive){
//                                                if self.sharedData.getLanguage() == 1 {
//                                                    //self.showToast(message: self.otpMessagesB[index])
//                                                    self.showAlert(title: self.sharedData.getAppName(), message: self.accSettingsMsgB[index])
//                                                } else if self.sharedData.getLanguage() == 0 {
//                                                    //self.showToast(message: self.otpMessagesE[index])
//                                                    self.showAlert(title: self.sharedData.getAppName(), message: self.accSettingsMsgE[index])
//                                                }
//                                            }
//                                        }
//                                    }
                                    
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
        
        
    }
    func imageDataUpload(imgData:String) {
        
        if Reachability.isConnectedToNetwork() {
            
            
            let sharedData = SharedDefault()
            
            self.view.activityStartAnimating()
            var postDict = Dictionary<String,String>()
            if companyImgData.count>0 {
                postDict = [
                    "access_token":sharedData.getAccessToken(),
                    
                    "company_logo":companyImgData,
                    "promo_image_1":"",
                    "promo_image_2":"",
                    "promo_image_3":""
                    
                ]
            } else if firstImgData.count>0 {
                postDict = [
                    "access_token":sharedData.getAccessToken(),
                    
                    "company_logo":"",
                    "promo_image_1":firstImgData,
                    "promo_image_2":"",
                    "promo_image_3":""
                    
                ]
            }else if secondImgData.count>0 {
                postDict = [
                    "access_token":sharedData.getAccessToken(),
                    
                    "company_logo":"",
                    "promo_image_1":"",
                    "promo_image_2":secondImgData,
                    "promo_image_3":""
                    
                ]
            } else if thirdImgData.count>0 {
                postDict = [
                    "access_token":sharedData.getAccessToken(),
                    
                    "company_logo":"",
                    "promo_image_1":"",
                    "promo_image_2":"",
                    "promo_image_3":thirdImgData
                    
                ]
            }
            
            //"drs_userid":txtDRSUserId.text!,
            //print("PostData: ",postDict)
            let loginURL = Constants.baseURL+Constants.ImageUpdateURL
            
            AF.request(loginURL, method: .post, parameters: postDict, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
                //print("Response:***:",data.description)
                
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
                        self.imageUpload = ImageUpload(response)
                        print("self.imageUpload ",self.imageUpload!)
                        print("self.imageUpload ",self.imageUpload?.httpcode!)
                        print("self.imageUpload ",self.imageUpload?.imageUploadData?.message)
                        let sharedDefault = SharedDefault()
                        let statusCode = Int((self.imageUpload?.httpcode)!)
                        if statusCode == 200{
                            self.showToast(message: (self.imageUpload?.message)!)
                            //let next = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            //self.navigationController?.pushViewController(next, animated: true)
                            /*self.btnLogoF.setTitle("Upload Image 1", for: .normal)
                             self.btnLogoS.setTitle("Upload Image 2", for: .normal)
                             self.btnLogoT.setTitle("Upload Image 3", for: .normal)*/
                            self.companyImgData = ""
                            self.thirdImgData = ""
                            self.secondImgData = ""
                            self.firstImgData = ""
                            self.showToast(message: (self.imageUpload?.imageUploadData?.message)!)
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
                                self.showAlert(title: sharedDefault.getAppName(), message: (self.loginResponse?.message)!)
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
    //This is the tap gesture added on my UIImageView.
    @IBAction func didTapOnImageView(sender: UITapGestureRecognizer) {
        //call Alert function
        self.showAlert()
        statusValue = 4
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Info ------->",info as Any)
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            print(asset?.value(forKey: "filename") as Any)
        }
        
        let pImage = info[UIImagePickerController.InfoKey.originalImage]
        if statusValue == 1 {
            //self.btnLogoF.setImage(UIImage(data: data!)?.withRenderingMode(.alwaysOriginal), for: .normal)
            self.btnLogoF.setImage(nil, for: .normal)
            btnLogoF .setBackgroundImage(pImage as? UIImage, for: .normal)
            //btnLogoF.setImage(pImage as? UIImage, for: .normal)
            btnLogoF.setTitle("", for: .normal)
            //firstImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            //let resizedImage = timage.resizedTo1MB()
            //firstImgData = convertImageToBase_64(image: resizedImage!.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            firstImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            //self.imageDataUpload(imgData: firstImgData)
            imageFirst = timage
        }
        else if statusValue == 2
        {
            self.btnLogoS.setImage(nil, for: .normal)
            btnLogoS .setBackgroundImage(pImage as? UIImage, for: .normal)
            btnLogoS.setTitle("", for: .normal)
            //secondImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            secondImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            //let resizedImage = timage.resizedTo1MB()
            // secondImgData = convertImageToBase_64(image: resizedImage!.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            //self.imageDataUpload(imgData: secondImgData)
            
            imageSeond = timage
        }
        else if statusValue == 3
        {
            self.btnLogoT.setImage(nil, for: .normal)
            btnLogoT .setBackgroundImage(pImage as? UIImage, for: .normal)
            btnLogoT.setTitle("", for: .normal)
            //thirdImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            let timage:UIImage = (pImage as? UIImage)!
            thirdImgData = convertImageToBase_64(image: timage.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            // let resizedImage = timage.resizedTo1MB()
            //thirdImgData = convertImageToBase_64(image: resizedImage!.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            //self.imageDataUpload(imgData: thirdImgData)
            
            imageThird = timage
        }
        else if statusValue == 4
        {
            imgCompany.image = pImage as? UIImage
            
            //imgCompany.image = pImage as? UIImage
            //updateDetails["avatar"] = convertImageToBase64(image: ((pImage as? UIImage)!))
            //UIImageJPEGRepresentation(pImage as! UIImage, 0.5)
            //let timage:UIImage = (pImage as? UIImage)!.jpeg(0.5)
            //let imageData: NSData = UIImagePNGRepresentation(timage) as! NSData
            
            companyImgData = convertImageToBase64(image: ((pImage as? UIImage)!))
            
            //let resizedImage = (pImage as? UIImage)!.resizedTo1MB()
            //companyImgData = convertImageToBase_64(image: resizedImage!.jpeg(UIImage.JPEGQuality(rawValue: 0.0)!)!)
            //print("companyImgData",companyImgData)
            lblCompany.text = ""
            //self.imageDataUpload(imgData: companyImgData)
            imageCompanyFourth = (pImage as? UIImage)!
        }
        statusValue = 0
        
        // btnProfilePic.setImage(pImage as? UIImage, for: .normal)
        //updateDetails["avatar"] = convertImageToBase64(image: ((pImage as? UIImage)!))
        dismiss(animated: true, completion: nil)
    }
    
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.modalPresentationStyle = .fullScreen
            
            genInfoSelected = true
            
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
