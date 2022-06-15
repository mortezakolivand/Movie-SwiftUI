//
//  LoginViewModel.swift
//  Movie SwiftUI
//
//  Created by Morteza Kolivand on 14.06.2022.
//

import Foundation

class LoginViewModel:ObservableObject{
    
    
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
  
    
    func login() {
         
        Webservice().login(username: username, password: password) { (result) in
            switch result {
            case .success(let account):
                print("***")
                print(account.token)
                print("***")
                UserDefaults.standard.set(account.token, forKey: "Token")
                UserDefaults.standard.set(account.validTo, forKey: "ValidTo")
                if account.token != nil{
                    self.isAuthenticated = true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                self.isAuthenticated = false
            }
        } 
    }
    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
        
    }
    
}
