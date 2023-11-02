//
//  Alert.swift
//  Barcode Scanner
//
//  Created by Ankit Vat on 12/10/23.
//
import SwiftUI

struct AlertItem : Identifiable {
    let id = UUID()
    let title : String
    let message : String
    let dismissBtn :Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput  = AlertItem(title: "Invalid Device Input",
                                              message : "Invalid device input.Please fix",
                                              dismissBtn: .default(Text("Ok")))
    static let invalidScannedType = AlertItem(title: "Invalid Scanned Type",
                                               message : "Invalid Scanner code",
                                               dismissBtn: .default(Text("OK")))
    
    static let genericError = AlertItem(title: "Generic",
                                        message :"Something went wrong. Please try again",
                                        dismissBtn: .default(Text("OK")))
    
}
