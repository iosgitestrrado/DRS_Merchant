//
//  AppDelegate.swift
//  DRS Merchant
//
//  Created by Softnotions Technologies Pvt Ltd on 4/21/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIViewController, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?
    var versionModel: VersionModel?
    let sharedDefault = SharedDefault()
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        Messaging.messaging().delegate = self
        
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                //self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
            }
        }
        
        
        self.getVersion()
        
        var initialPage = UIViewController()
        
        let sharedDefault = SharedDefault()
        
        if sharedDefault.getLoginStatus() == true {
            initialPage = mainStoryboard.instantiateViewController(withIdentifier: "MerchantHomeVC") as! MerchantHomeVC
        } else {
            initialPage = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        }
        
        let navigationController = UINavigationController(rootViewController: initialPage)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    func updateApp() {
        
    }
    func getVersion() {
        self.view.activityStartAnimating()
        var postDict = Dictionary<String,String>()
        
        
        print("PostData: ",postDict)
        let loginURL = Constants.baseURL+Constants.versionURL
        
        AF.request(loginURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
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
                    self.versionModel = VersionModel(response)
                    print("self.versionModel ",self.versionModel!)
                    print("self.versionModel ",self.versionModel?.httpcode!)
                    //print("self.loginResponse ",self.forgotPwdResponse?.forgotPwdData.)
                    let iosInitial:String = (self.versionModel?.versionModelData?.iosInitialUpdate!)!
                    let statusCode = Int((self.versionModel?.httpcode)!)
                    if statusCode == 200{
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                            let serviceAppVersion = self.versionModel?.versionModelData?.version!
                            
                            print("currentAppVersion === = ",NumberFormatter().number(from: currentAppVersion!)!.doubleValue)
                            print("serviceAppVersion === = ",NumberFormatter().number(from: serviceAppVersion!)!.doubleValue)
                            if Int(iosInitial) != 1
                            {
                                if NumberFormatter().number(from: serviceAppVersion!)!.doubleValue <
                                    NumberFormatter().number(from: currentAppVersion!)!.doubleValue {
                                    let alertController = UIAlertController (title: Constants.APP_NAME, message: "A new vesion of DRS Merchant app is available in app store. Please update", preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
                                        if let url = URL(string: "https://apps.apple.com/us/app/id1514558880") {
                                            UIApplication.shared.open(url)
                                        }
                                    }))
                                    
                                    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                                    alertWindow.rootViewController = UIViewController()
                                    alertWindow.windowLevel = UIWindow.Level.alert + 1;
                                    alertWindow.makeKeyAndVisible()
                                    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
                                    
                                }
                            }
                            
                            
                            
                        }
                    }
                    if statusCode == 400{
                        self.view.activityStopAnimating()
                    }
                    self.view.activityStopAnimating()
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0,*)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0,*)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        sharedDefault.setNewFcmToken(token: fcmToken)
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: "fcm_token"){
            print("savedValue fcm_token ----- ",savedValue)
        } else {
            sharedDefault.setFcmToken(token: fcmToken)
        }
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print(error.localizedDescription)
        print("Not registered notification")
    }
    
    func showAlertFromAppDelegates(){
        var msg:String = String()
        var btnTitle:String = String()
        if sharedDefault.getLanguage() == 0 {
            msg = "New version of DRS Merchant is available.Click to update"
            btnTitle = "Update"
        } else if sharedDefault.getLanguage() == 1 {
            msg = "DRS Merchant ၏မူကွဲအသစ်ကိုရနိုင်သည်။ Update လုပ်ရန်နှိပ်ပါ"
            btnTitle = "နောက်ဆုံးသတင်း"
        }
        let alertVC = UIAlertController(title: Constants.APP_NAME , message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: btnTitle, style: UIAlertAction.Style.cancel) { (alert) in
            // Your code here
            
            if let url = URL(string: "https://apps.apple.com/us/app/id1514558880") {
                UIApplication.shared.open(url)
            }
        }
        alertVC.addAction(okAction)
        DispatchQueue.main.async {
            var presentVC = self.window?.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alertVC, animated: true, completion: nil)
        }
        
    }
    func version() {
        print("123456789")
        let loginURL = Constants.baseURL+Constants.VersionURL
        print(loginURL)
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
                    self.versionModel = VersionModel(response)
                    print("self.loginResponse ",self.versionModel!)
                    print("self.loginResponse ",self.versionModel?.httpcode!)
                    print("self.loginResponse ",self.versionModel?.versionModelData)
                    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    
                    let statusCode = Int((self.versionModel?.httpcode)!)
                    let versionCode = String((self.versionModel?.versionModelData?.version!)!)
                    
                    if statusCode == 200{
                        let serviceAppVersion = self.versionModel?.versionModelData?.version!
                        let iosInitial:String = (self.versionModel?.versionModelData?.iosInitialUpdate!)!
                        
                        if Int(iosInitial) != 0
                        {
                            if appVersion != versionCode{
                                self.showAlertFromAppDelegates()
                                print("versionCode ----- ",versionCode)
                                print("appVersion ----- ",appVersion!)
                            }
                        }
                        
                    }
                    if statusCode == 400{
                        
                    }
                    
                }
                catch let err {
                    print("Error::",err.localizedDescription)
                }
            }
        }
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        /*
         if let messageID = userInfo[gcmMessageIDKey] {
         print("Message ID: \(messageID)")
         }
         */
        // Print full message.
        //print("userInfo",userInfo)
        
        
        //let userInfo = notification.request.content.userInfo
        /*
         print("userInfo  qwqwqq",userInfo[AnyHashable("gcm.notification.data")])
         let json = JSON(response.notification.request.content.userInfo)
         guard let gcmNotificationPayload = json["gcm.notification.data"].string else { return }
         let payload = JSON.init(parseJSON: gcmNotificationPayload)
         print("json \(json)")
         print("payload \(payload)")
         print("notify_type   ",payload["notify_type"])
         print("type_id   ",payload["type_id"])
         print("time   ",payload["time"])
         let notifyType:String = payload["notify_type"].string!
         let typeId:String = payload["type_id"].string!
         
         
         
         if notifyType == "news_event" {
         print("news_event")
         let next = self.storyboard?.instantiateViewController(withIdentifier: "NewsEventsVC") as! NewsEventsVC
         next.newsID = typeId
         self.navigationController?.pushViewController(next, animated: true)
         
         }
         else if notifyType == "wallet_withdraw" {
         print("wallet_withdraw")
         //let next = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalHistoryVC") as! WithdrawalHistoryVC
         // self.navigationController?.pushViewController(next, animated: true)
         
         let presentViewController = mainStoryboard.instantiateViewController(withIdentifier: "WithdrawalHistoryVC") as! WithdrawalHistoryVC
         
         
         self.present(presentViewController, animated: true, completion: nil)
         
         }
         else if notifyType == "transaction" {
         print("transaction")
         let next = self.storyboard?.instantiateViewController(withIdentifier: "TransDetailVC") as! TransDetailVC
         next.strTransId = typeId
         self.navigationController?.pushViewController(next, animated: true)
         }
         
         else if notifyType == "support" {
         print("support")
         let next = self.storyboard?.instantiateViewController(withIdentifier: "MsgDetailListVC") as! MsgDetailListVC
         next.chatIDData = typeId
         self.navigationController?.pushViewController(next, animated: true)
         }
         else {
         print("others")
         }
         */
        
        //let presentViewController = mainStoryboard.instantiateViewController(withIdentifier: "WithdrawalHistoryVC") as! WithdrawalHistoryVC
        
        //presentViewController.yourDict = userInfo //pass userInfo data to viewController
        //self.window?.rootViewController = presentViewController
        // presentViewController.present(presentViewController, animated: true, completion: nil)
        
        completionHandler()
    }
    
    
}

