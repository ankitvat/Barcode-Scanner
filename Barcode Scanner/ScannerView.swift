//
//  ScannerView.swift
//  Barcode Scanner
//
//  Created by Ankit Vat on 11/10/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
   
    @Binding var scannedCode : String
    @Binding var alertItem :AlertItem?
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView : self)
    }
    
    final class Coordinator :NSObject , ScannerVCDelegate {
        private let scannerView: ScannerView
       
        init (scannerView : ScannerView) {
            self.scannerView = scannerView
        }
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .genericError:
                scannerView.alertItem = AlertContext.genericError
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScannedValue:
                scannerView.alertItem  = AlertContext.invalidScannedType
                
            }
            
        }
        
        
    }
    
  
}
