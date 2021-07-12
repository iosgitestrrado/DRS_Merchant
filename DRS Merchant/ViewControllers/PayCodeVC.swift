//
//  PayCodeVC.swift
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

class PayCodeVC: UIViewController {
    let sharedDefault = SharedDefault()
    @IBOutlet weak var imgQR: UIImageView!
    var qrModel: QrModel?
    @IBOutlet weak var lblBusName: UILabel!
    var strName: String! = String()
    var strTitle: String! = String()
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear SettingsVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblBusName.text = strName
        // Do any additional setup after loading the view.
        
        if Reachability.isConnectedToNetwork() {
            self.getQR()
        } else {
            showToast(message: Constants.APP_NO_NETWORK)
        }
        
        self.changeLanguage()
        
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
                
                
                if let text = xml.resource.Home_page_Pay_Code.text {
                    strTitle = text
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
                if let text = xml.resource.Home_page_Pay_Code.text {
                    strTitle = text
                }
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    func getQR() {
        let sharedDefault = SharedDefault()
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        postDict = ["access_token":sharedDefault.getAccessToken()
        ]
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.QrURL
        
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
                    self.qrModel = QrModel(response)
                    let statusCode = Int((self.qrModel?.httpcode)!)
                    if statusCode == 200{
                        let downloadURL = NSURL(string: (self.qrModel?.qrModelData?.payQrcode)!)!
                        if downloadURL.absoluteString!.count>0 {
                            
                            self.imgQR.load(url: downloadURL as URL)
                        } else {
                            
                        }
                        print(self.qrModel?.qrModelData?.payQrcode)
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
