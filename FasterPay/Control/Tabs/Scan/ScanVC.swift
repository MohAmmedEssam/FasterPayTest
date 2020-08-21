//
//  ScanVC.swift
//  FasterPay
//
//  Created by Mohammed Essam on 8/20/20.
//  Copyright © 2020 Elhayes. All rights reserved.
//

import UIKit
import AVFoundation

class ScanVC: UIViewController {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = AVCaptureDevice.default(for: .video) else {
            handleScanningIsNotSupported()
            return
        }

        initCaptureSession()
        setupVideoInput()
        setupMetadataOutput()
        setupPreviewLayer()
        startCaptureSession()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if previewLayer != nil {
            previewLayer.frame = view.layer.bounds
        }
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

//MARK: - Setup
extension ScanVC{
    private func initCaptureSession() {
        captureSession = AVCaptureSession()
    }
    private func setupVideoInput() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            handleScanningIsNotSupported()
            return
        }
    }
    private func setupMetadataOutput() {
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            handleScanningIsNotSupported()
            return
        }
    }
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    private func startCaptureSession() {
        captureSession.startRunning()
    }
    private func handleScanningIsNotSupported() {
        alert(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.")
        captureSession = nil
    }
    
}
//MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScanVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            DidFoundCode(code: stringValue)
        }

//        dismiss(animated: true)
    }

    func DidFoundCode(code: String) {
        print(code)
        let data = code.data(using: .utf8)
        CodableFuncs(data:data).Decode{ (_ payment:Payment?) in
            guard let payment = payment else{
                self.alertAction(title: "Scanning Problem",message: "Something went wrong!"){
                    self.startCaptureSession()
                }
                return
            }
            self.moveToPaymentVC(payment)
        }
    }
    func moveToPaymentVC(_ payment:Payment){
        let storyBoard = UIStoryboard(name: "Tabs", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vc.model = payment
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
