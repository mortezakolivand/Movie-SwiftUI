//
//  ContentView.swift
//  Movie SwiftUI
//
//  Created by Morteza Kolivand on 14.06.2022.
//

import SwiftUI

struct ContentView: View {
        
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationView {
           
        VStack {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: "lock.fill")
                }
                TextField("Username", text: $loginVM.username)
                SecureField("Password", text: $loginVM.password)
               
                HStack {
                    Spacer()
                    NavigationLink(destination:  MovieView(), isActive: $loginVM.isAuthenticated) {
                        Text("")
                    }
                    Button("Login") {
                        loginVM.login()
                    }
                  
                    Spacer()
                }
            }.buttonStyle(PlainButtonStyle()) 
            
        } .onAppear(perform: {
           
        })
        .navigationBarTitle("Login", displayMode: .inline)
         
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
