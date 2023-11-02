//
//  ScannerView.swift
//  Barcode Scanner
//
//  Created by Ankit Vat on 11/10/23.
//

import UIKit
import AVFoundation


enum CameraError : String {
    case invalidDeviceInput 
    case invalidScannedValue
    case genericError
}
protocol ScannerVCDelegate : AnyObject {
    func didFind(barcode : String)
    func didSurface(error : CameraError)
}
final class ScannerViewController : UIViewController {
    let captureSession  = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?
    
    init(scannerDelegate : ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not enabled")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .genericError)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .genericError)
            return
        }
        let videoInput : AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch {
            scannerDelegate?.didSurface(error: .genericError)
            return
        }
        
        if(captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        }else {
            scannerDelegate?.didSurface(error: .genericError)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if(captureSession.canAddOutput(metaDataOutput)) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8 , .ean13 , .qr ]
        }else {
            scannerDelegate?.didSurface(error: .genericError)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}

extension ScannerViewController:AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object  = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .genericError)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
        guard let barCode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }

        scannerDelegate?.didFind(barcode: barCode)
    }
}

