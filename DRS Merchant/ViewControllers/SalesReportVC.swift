//
//  SalesReportVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Charts
import MobileCoreServices
import Alamofire
import SwiftyJSON
import SwiftyXMLParser

class SalesReportVC: UIViewController,UITextFieldDelegate {
    let sharedDefault = SharedDefault()
    var strTitle: String! = String()
    @IBOutlet weak var lblTotPay: UILabel!
    @IBOutlet weak var lblWallet: UILabel!
    @IBOutlet weak var lblCashPay: UILabel!
    var salesReportModel: SalesReportModel?
    
    @IBOutlet weak var lblDescriptionLevel: UILabel!
    @IBOutlet weak var lblWalletPayment: UILabel!
    @IBOutlet weak var lblCashReport: UILabel!
    @IBOutlet weak var lblStartDateWidth: NSLayoutConstraint!
    @IBOutlet weak var lblEndDateWidth: NSLayoutConstraint!
    @IBOutlet var progressCash: UIProgressView!
    @IBOutlet var progressWallet: UIProgressView!
    @IBOutlet var lblTotalReceived: UILabel!
    @IBOutlet var lblWalletData: UILabel!
    @IBOutlet var lblCashData: UILabel!
    @IBOutlet var viewPieChart: PieChartView!
    @IBOutlet var txtEndDate: UITextField!
    @IBOutlet var txtStartDate: UITextField!
    @IBOutlet var lblEndDate: UILabel!
    @IBOutlet var lblStDate: UILabel!
    @IBOutlet var viewSalesReport: UIView!
    var dateStatus:Bool = false
    
    //Uidate picker
    
    let datePicker = UIDatePicker()
    
    func changeLanguage() {
        let sharedDefault = SharedDefault()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                self.lblEndDateWidth.constant = 120.0
                
                if let text = xml.resource.Setting_Sales_Report.text {
                    strTitle = text
                    self.title = strTitle
                }
               
                if let text = xml.resource.Sales_Report_Start_Date.text {
                    lblStDate.text = text
                }
                if let text = xml.resource.Sales_Report_End_Date.text {
                    lblEndDate.text = text
                }
             if let text = xml.resource.Sales_Report_Cash_Payment.text {
                lblCashPay.text = text
                lblCashReport.text = text
             }
                if let text = xml.resource.Sales_Report_Wallet_Payment.text {
                 // btnSignOut.setTitle(text, for: .normal)
                    lblWallet.text = text
                    lblWalletPayment.text = text
                }
             if let text = xml.resource.Sales_Report_Total_Payment_Received.text {
                lblTotPay.text = text
            
             }
                
                if let text = xml.resource.Sales_Report_Description_level.text {
                   lblDescriptionLevel.text = text
               
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
                 self.lblEndDateWidth.constant = 85.0
               if let text = xml.resource.Setting_Sales_Report.text {
                   strTitle = text
                   self.title = strTitle
               }
                if let text = xml.resource.Sales_Report_Start_Date.text {
                    lblStDate.text = text
                }
                if let text = xml.resource.Sales_Report_End_Date.text {
                    lblEndDate.text = text
                }
             if let text = xml.resource.Sales_Report_Cash_Payment.text {
                lblCashPay.text = text
             }
                if let text = xml.resource.Sales_Report_Wallet_Payment.text {
                 // btnSignOut.setTitle(text, for: .normal)
                    lblWallet.text = text
                }
             if let text = xml.resource.Sales_Report_Total_Payment_Received.text {
                lblTotPay.text = text
             }
                if let text = xml.resource.Sales_Report_Description_level.text {
                   lblDescriptionLevel.text = text
               
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
        if sharedDefault.getLanguage() == 1
        {
            viewPieChart.noDataText = "သငျသညျဇယားများအတွက်ဒေတာများကိုလိုအပ်သည်။"
        }
        else if sharedDefault.getLanguage() == 0
        {
            viewPieChart.noDataText = "You need to provide data for the chart."

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLanguage()
        // Do any additional setup after loading the view.
        viewSalesReport.layer.cornerRadius = 10
        
        //let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jun"]
        //let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 16.0, 1.0]
        
        
        txtEndDate.delegate = self
        txtStartDate.delegate = self
        
        dateStatus = true
        
        
        
        
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        if dateStatus == true {
            txtStartDate.inputAccessoryView = toolbar
            txtStartDate.inputView = datePicker
        } else if dateStatus == false  {
            txtEndDate.inputAccessoryView = toolbar
            txtEndDate.inputView = datePicker
            
        }
        
        
        
        
    }
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
       
        
        if dateStatus == true {
            txtStartDate.text = formatter.string(from: datePicker.date)
            dateStatus = false
        } else if dateStatus == false  {
            txtEndDate.text = formatter.string(from: datePicker.date)
            dateStatus = false
            if txtStartDate.text!.count>=0 {
                self.getSalesReport(startDate: txtStartDate.text!, endDate: txtEndDate.text!)
            } else {
                self.showToast(message: "Select start date")
            }
            
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    //MARK: - TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //function to move view up
        
        if textField == txtStartDate {
            dateStatus = true
            self.showDatePicker()
            //dateStatus = false
        } else if textField == txtEndDate {
            dateStatus = false
            self.showDatePicker()
            
            
        } 
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //function to move view down
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
//            let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
//            let dataEntry1 = PieChartDataEntry(value: Double(i), label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)

            dataEntries.append(dataEntry)
        }
        //print(dataEntries[0].data)
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")

//        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        viewPieChart.data = pieChartData

        var colors: [UIColor] = []
        let color = UIColor(red: CGFloat(244.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0), alpha: 1)
        colors.append(color)
         let color1 = UIColor(red: CGFloat(71.0/255.0), green: CGFloat(198.0/255.0), blue: CGFloat(143.0/255.0), alpha: 1)
         colors.append(color1)
        /*
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        */
        pieChartDataSet.colors = colors
        
        pieChartDataSet.drawValuesEnabled = false
        
    }
    
    
    func getSalesReport(startDate:String,endDate:String) {
              self.view.activityStartAnimating()
              var postDict = Dictionary<String,String>()
        //11469118
        //15-06-2020
        //17-06-2020
        //"access_token":sharedData.getAccessToken(),
        postDict = ["access_token":sharedDefault.getAccessToken(),
                          "start_date":startDate,
                          "end_date":endDate
                  
              ]
              
              // print("PostData: ",postDict)
              let loginURL = Constants.baseURL+Constants.SalesReportURL
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
                        self.salesReportModel = SalesReportModel(response)
                        print("self.salesReportModel ",self.salesReportModel!)
                        print("self.salesReportModel ",self.salesReportModel?.httpcode!)
                        // print("self.topupPaymentModel ",self.validateMobileModelResponse?.validateMobileModelData)
                        //let sharedDefault = SharedDefault()
                        let statusCode = Int((self.salesReportModel?.httpcode)!)
                        print("statusCode ",statusCode!)
                        if statusCode == 200{
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
//                                var months = ["", ""]
                                //let unitsSold = [10000.0, 4.0]
                                
                                var months = [String]()
                                var unitsSold = [Double]()
                                
                                let cashPay = self.salesReportModel!.salesReportModelData?.salesReport?.cashPayment!
                                let totalPay = self.salesReportModel!.salesReportModelData?.salesReport?.totalPayment!
                                var ctotal = (cashPay!/totalPay!) * 100
                                print("ctotal",ctotal)
                                //let doubValue = Double(ctotal)
                                unitsSold.append(ctotal)

                                let walletPay = self.salesReportModel!.salesReportModelData?.salesReport?.walletPayment!
                                
                                var wtotal = (walletPay!/totalPay!) * 100
                                unitsSold.append(wtotal)

                                //print("wtotal",wtotal)
                               // print("cashPayment ",self.salesReportModel!.salesReportModelData?.salesReport?.cashPayment!)
                               // print("wallet_payment ",self.salesReportModel!.salesReportModelData?.salesReport?.walletPayment!)
                                
                               // print("total_payment ",self.salesReportModel!.salesReportModelData?.salesReport?.totalPayment!)
                                
                               
                                
                                let customView = UIView(frame: CGRect(x: 0, y: self.viewPieChart.frame.size.height-20, width: 200, height: 50))
                                customView.backgroundColor = .white
                                self.viewPieChart.addSubview(customView)
                                var a: Int = Int((self.salesReportModel!.salesReportModelData?.salesReport?.cashPayment!)!)
                                months.append(String(a))

                                var b: String = String(a) + " " + (self.salesReportModel!.salesReportModelData?.salesReport?.currency!)!
                                //let strCash = String(a)
                                self.lblCashData.text = b
                                ctotal = (cashPay!/totalPay!) * 1
                                if Float(ctotal)>0 {
                                    self.progressCash.setProgress(Float(ctotal), animated: true)
                                }
                                a = Int((self.salesReportModel!.salesReportModelData?.salesReport?.walletPayment!)!)
                                months.append(String(a))

                                b =  String(a) + " " + (self.salesReportModel!.salesReportModelData?.salesReport?.currency!)!
                                
                                self.lblWalletData.text = b
                                
                                wtotal = (walletPay!/totalPay!) * 1
                                if Float(wtotal)>0 {
                                    self.progressWallet.setProgress(Float(wtotal), animated: true)
                                }
                                a = Int((self.salesReportModel!.salesReportModelData?.salesReport?.totalPayment!)!)

                                
                                b =  String(a) + " " + (self.salesReportModel!.salesReportModelData?.salesReport?.currency!)!
                                
                                self.lblTotalReceived.text = b
                                print("ctotal f",ctotal)
                                print("wtotal f",wtotal)
                                
                                self.setChart(dataPoints: months, values: unitsSold)
                                self.viewPieChart.isUserInteractionEnabled = false
                                //lblWalletData.text = self.salesReportModel!.salesReportModelData?.salesReport?.walletPayment!
                                
                                /*if (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!.count>0{
                                 self.sectionDetail.removeAll()
                                 self.sectionDetail = (self.withdrawalHistoryModel!.withdrawalHistoryModelData?.referralWithdrawalHistory)!
                                 print("sectionDetail ",self.sectionDetail.count)
                                 
                                 self.collectionWithdrawHistory.reloadData()
                                 }
                                 */
                            }
                        }
                        if statusCode == 400{
                            
                            
                            self.view.activityStopAnimating()
                            if let range3 = (self.salesReportModel?.message)!.range(of: "Invalid access token", options: .caseInsensitive){
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
                                self.showAlert(title: self.sharedDefault.getAppName(), message: (self.salesReportModel?.message)!)
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
