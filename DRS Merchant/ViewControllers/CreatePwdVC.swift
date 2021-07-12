//
//  CreatePwdVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import SwiftyXMLParser

class CreatePwdVC: UIViewController {
    @IBOutlet var lblCreatePwd: UILabel!
    @IBOutlet var txtConfirmPwd: UITextField!
    var strTitle: String! = String()
    @IBOutlet var btnSubmitPwd: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var lblSubHead: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear CreatePwdVC ")
        
        self.navigationController?.navigationBar.isHidden = false
        //self.title = "Forgot Password"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        
        
        self.addBackButton()
        txtPassword.isSecureTextEntry = true
        txtConfirmPwd.isSecureTextEntry = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSubmitPwdAction(_ sender: Any) {
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
