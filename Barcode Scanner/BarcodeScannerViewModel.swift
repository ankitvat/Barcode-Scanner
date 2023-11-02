//
//  BarcodeScannerViewModel.swift
//  Barcode Scanner
//
//  Created by Ankit Vat on 12/10/23.
//

import SwiftUI

final class BarcodeScannerViewModel : ObservableObject {
    @Published var scannedCode =  ""
    @Published var alertItem : AlertItem?
    
    var StatusText: String {
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ?.red : .green
    }
}
