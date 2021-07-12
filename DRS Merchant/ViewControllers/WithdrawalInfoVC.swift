//
//  WithdrawalInfoVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SwiftyXMLParser

class WithdrawalInfoVC: UIViewController {
    @IBOutlet weak var imgTransaction: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var lblVPData: UILabel!
    @IBOutlet weak var lblRefData: UILabel!
    var strTitle: String! = String()
    @IBOutlet weak var lblRef: UILabel!
    @IBOutlet weak var lblVPoints: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    var withDrawStatus:Bool!
    var strBalance:String = String()
    var strRefNo:String = String()
    var strMessage:String = String()
    
    @IBOutlet weak var lblFailMsg: UILabel!
    
    
    @IBOutlet weak var viewFailed: UIView!
    func changeLanguage() {
         let sharedDefault = SharedDefault()
        if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
           
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
            var text = try String(contentsOfFile: path!)
            //print("text",text)
            let xml = try! XML.parse(text)
            
            if let text = xml.resource.Withdrawal_Information_Withdrawal_Inf.text {
                strTitle = text
                self.title = strTitle
            }
            if let text = xml.resource.Withdrawal_Information_Withdrawal_Req.text {
                lblHeader.text = text
                
            }
            if let text = xml.resource.Withdrawal_Information_transferred_money_from_merchant_wallet_to_ur_bank_account.text {
               lblSubHeader.text = text
                
            }
            if let text = xml.resource.Withdrawal_Information_Wallet_bal.text {
                lblVPoints.text = text
                
            }
            
            if let text = xml.resource.Withdrawal_Information_Ref_no.text {
               
                lblRef.text = text
            }
                if let text = xml.resource.Withdrawal_Request_Fail_MSG.text {
                   
                    lblFailMsg.text = text
                }
                
                
                
            }
            catch(_){print("error")}
        } else if sharedDefault.getLanguage() == 0 {
           
            let path = Bundle.main.path(forResource: "Merchant_English", ofType: "xml") // file path for file "data.txt"
            do {
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                
                if let text = xml.resource.Withdrawal_Information_Withdrawal_Inf.text {
                    strTitle = text
                    self.title = strTitle
                }
                if let text = xml.resource.Withdrawal_Information_Withdrawal_Req.text {
                    lblHeader.text = text
                    
                }
                if let text = xml.resource.Withdrawal_Information_transferred_money_from_merchant_wallet_to_ur_bank_account.text {
                   lblSubHeader.text = text
                    
                }
                if let text = xml.resource.Withdrawal_Information_Wallet_bal.text {
                    lblVPoints.text = text
                    
                }
                
                if let text = xml.resource.Withdrawal_Information_Ref_no.text {
                   
                    lblRef.text = text
                }
                
                if let text = xml.resource.Withdrawal_Request_Fail_MSG.text {
                   
                    lblFailMsg.text = text
                }
                
                
            }
            catch(_){print("error")}
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear WithdrawalInfoVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addCustomNavigationBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.changeLanguage()
        
        viewDetails.layer.cornerRadius = 15
        
        lblVPData.text = strBalance
        lblRefData.text = strRefNo
        
        if withDrawStatus == true {
             viewFailed.isHidden = false
            viewFailed.layer.cornerRadius = 15
                       viewFailed.clipsToBounds = true
            lblFailMsg.text = strMessage
            
            lblHeader.isHidden = true
            imgTransaction.isHidden = true
            lblSubHeader.isHidden = true
            viewDetails.isHidden = true
        } else {
            imgTransaction.isHidden = false
            lblHeader.isHidden = false
            lblSubHeader.isHidden = false
            viewDetails.isHidden = false
             viewFailed.isHidden = true
        }
        
        self.changeLanguage()
        
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
