//
//  RegistrationVC.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 5/4/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import WebKit
import SwiftyXMLParser

class TermsVC: UIViewController,WKNavigationDelegate{
    var strTitle:String = String()
    
    @IBOutlet weak var webKitTerms: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear RegistrationVC ")
        self.navigationController?.navigationBar.isHidden = false
        self.title = strTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 91.0/255.0, green: 59.0/255.0, blue: 27.0/255.0, alpha: 1.0)]
        self.addBackButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        webKitTerms.isUserInteractionEnabled = true
        webKitTerms.navigationDelegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://drs-asia.com/privacy-policy/")
        //let url = URL(string: "https://en.wiktionary.org/wiki/Wiktionary:Main_Page")
        
        webKitTerms.load(URLRequest(url: url!))
        self.view.activityStartAnimating()
        self.changeLanguage()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.activityStopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.view.activityStartAnimating()
    }
    func changeLanguage() {
        let sharedDefault = SharedDefault()
         if sharedDefault.getLanguage() == 1 {
            print("changeLanguage")
            
            let path = Bundle.main.path(forResource: "Merchant_Burmese", ofType: "xml") // file path for file "data.txt"
            do {
                var strHead:String = ""
                var text = try String(contentsOfFile: path!)
                //print("text",text)
                let xml = try! XML.parse(text)
                if let text = xml.resource.Terms_Title.text {
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
                
                if let text = xml.resource.Terms_Title.text {
                    strTitle = text
                }
                
            }
            catch(_){print("error")}
            
            
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
