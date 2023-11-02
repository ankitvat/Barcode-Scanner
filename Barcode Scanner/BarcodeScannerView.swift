//
//  ContentView.swift
//  Barcode Scanner
//
//  Created by Ankit Vat on 11/10/23.
//

import SwiftUI



struct BarcodeScannerView: View {
    
    @StateObject var viewModel = BarcodeScannerViewModel()
    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $viewModel.scannedCode , 
                            alertItem: $viewModel.alertItem)
                    .frame(maxWidth : 250 , maxHeight : 250)
                    .cornerRadius(10, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Spacer().frame(height: 60)
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title3)
                    .padding()
                Text(viewModel.StatusText)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundColor(viewModel.statusTextColor)
                
               
            }
                .navigationTitle("Barcode Scanner")
                .alert(item: $viewModel.alertItem)
                { alertItem in
                    Alert(title: Text(alertItem.title), message : Text(alertItem.message) , dismissButton: alertItem.dismissBtn)
                }
        }
    }
}

#Preview {
    BarcodeScannerView().preferredColorScheme(.dark)
}
