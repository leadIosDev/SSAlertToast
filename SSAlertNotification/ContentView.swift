//
//  ContentView.swift
//  SSAlertNotification
//
//  Created by shashank on 12/03/21.
//

import SwiftUI

struct ContentView: View {
    @State var showToast: Bool = false
    var successAlert = SSAlertData(style: .success, message: "Success Toast", position: .bottom, toastTime: 3)
    
    var failureAlert = SSAlertData(style: .error, message: "You have an Error!", position: .top, toastTime: 0)
    
    var infoAlert = SSAlertData(style: .info, message: "Here is some info for you!", position: .bottom, toastTime: 3)
    
    var warningAlert = SSAlertData(style: .warning, message: "Something not working fine", position: .top, toastTime: 3)
    
    var customAlert = SSAlertData(style: .custom(Image(systemName: "hand.thumbsdown.fill"), .purple, .white), message: "Its Custom alert", position: .bottom, toastTime: 3)
    
    @State var selectedAlert: SSAlertData = SSAlertData(message: "")
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.selectedAlert = successAlert
                    self.showToast = true
                }, label: {
                    Capsule()
                        .fill(Color.red)
                        .overlay(
                            Text("Success Toast")
                                .foregroundColor(.white)
                                .padding()
                        )
                })
                .frame(height: 50)
                
                Button(action: {
                    self.selectedAlert = failureAlert
                    self.showToast = true
                }, label: {
                    Capsule()
                        .fill(Color.red)
                        .overlay(
                            Text("Error Toast")
                                .foregroundColor(.white)
                                .padding()
                        )
                   
                })
                .frame(height: 50)
                
            }
            
            HStack {
                Button(action: {
                    self.selectedAlert = infoAlert
                    self.showToast = true
                }, label: {
                    Capsule()
                        .fill(Color.red)
                        .overlay(
                            Text("Info Toast")
                                .foregroundColor(.white)
                                .padding()
                        )
                })
                .frame(height: 50)
                
                Button(action: {
                    self.selectedAlert = warningAlert
                    self.showToast = true
                }, label: {
                    Capsule()
                        .fill(Color.red)
                        .overlay(
                            Text("Warning Toast")
                                .foregroundColor(.white)
                                .padding()
                        )
                   
                })
                .frame(height: 50)
                
            }
            
            Button(action: {
                self.selectedAlert = customAlert
                self.showToast = true
            }, label: {
                Capsule()
                    .fill(Color.red)
                    .overlay(
                        Text("Custom Toast")
                            .foregroundColor(.white)
                            .padding()
                    )
               
            })
            .frame(height: 50)
        }
        .padding()
        .showToast(show: $showToast, data: selectedAlert)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
