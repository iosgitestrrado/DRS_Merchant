//
//  SharedDefault.swift
//  iDesigner
//
//  Created by Softnotions Technologies Pvt Ltd on 2/19/20.
//  Copyright © 2020 Softnotions Technologies Pvt Ltd. All rights reserved.
//

import UIKit

class SharedDefault: UIViewController {
    
    func setAppName(loginStatus:String)
    {
        UserDefaults.standard.set(loginStatus, forKey: "AppName")
        UserDefaults.standard.synchronize()
    }
    func getAppName() -> String {
        return UserDefaults.standard.string(forKey: "AppName")!
    }
    
    
    
    func setLanguage(language:Int)
    {
        UserDefaults.standard.set(language, forKey: "Language")
        UserDefaults.standard.synchronize()
    }
    
    func getLanguage()-> Int
    {
        return UserDefaults.standard.integer(forKey: "Language")
        
    }
    
    func setLoginStatus(loginStatus:Bool)
    {
        UserDefaults.standard.set(loginStatus, forKey: "LoginStatus")
        UserDefaults.standard.synchronize()
    }
    
    func getLoginStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "LoginStatus")
    }
    
    func setPhoneNumber(loginStatus:String)
    {
        UserDefaults.standard.set(loginStatus, forKey: "PhoneNumber")
        UserDefaults.standard.synchronize()
    }
    func getPhoneNumber()-> Any
    {
        return UserDefaults.standard.value(forKey: "PhoneNumber")!
        
    }
    
    func setAccessToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    func getAccessToken()-> String
    {
        return UserDefaults.standard.value(forKey: "access_token")! as! String
        
    }
    func clearAccessToken()
    {
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.synchronize()
    }
    
    func setNewFcmToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: "new_fcm_token")
        UserDefaults.standard.synchronize()
    }
    func getNewFcmToken()-> String
    {
        return UserDefaults.standard.value(forKey: "new_fcm_token")! as! String
        
    }
    
    func setFcmToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: "fcm_token")
        UserDefaults.standard.synchronize()
    }
    func getFcmToken()-> String
    {
        return UserDefaults.standard.value(forKey: "fcm_token")! as! String
        
    }
    func clearFcmToken()
    {
        UserDefaults.standard.removeObject(forKey: "fcm_token")
        UserDefaults.standard.synchronize()
    }
    
}
