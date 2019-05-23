//
//  YRSingleImageSelector.swift
//  YRSingleImageSelector
//
//  Created by Yogesh Rathore on 23/05/19.
//  Copyright © 2019 Yogesh Rathore. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

public class YRSingleImageSelector: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var imagePickerController : UIImagePickerController!
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red:0.31, green:0.35, blue:0.93, alpha:1.0)
        imageView.frame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: Int(self.frame.width))
        return imageView
    }()
    
    public lazy var addEditButton: UIButton = {
        let addEditButton = UIButton()
        addEditButton.frame = CGRect(x: 0, y: Int(self.frame.width), width: Int(self.frame.width), height: 30)
        addEditButton.setTitle("Add Photo", for: .normal)
        addEditButton.setTitleColor(.blue, for: .normal)
        addEditButton.backgroundColor = UIColor(red:0.73, green:0.73, blue:0.80, alpha:1.0)
        addEditButton.addTarget(self, action: #selector(addEditButtonTapped), for: .touchUpInside)
        return addEditButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    func viewSetup() {
        addSubview(imageView)
        addSubview(addEditButton)
    }
    
    @objc public func addEditButtonTapped() {
        var alert: UIAlertController?
        if imageView.image != nil {
            alert = UIAlertController(title: "Choose Action", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            alert?.addAction(UIAlertAction(title:
                "Delete Image", style: UIAlertAction.Style.default, handler: { action in self.setImageForImageView(image: nil)}))
            
            alert?.addAction(UIAlertAction(title:
                "Select from Camera", style: UIAlertAction.Style.default, handler: { action in self.openCameraPermission()}))
            
            alert?.addAction(UIAlertAction(title: "Select from Gallery", style: UIAlertAction.Style.default, handler: { action in self.openGalleryPermission()} ))
        } else {
            alert = UIAlertController(title: "Choose Image", message: "From", preferredStyle: UIAlertController.Style.actionSheet)
            alert?.addAction(UIAlertAction(title:
                "Camera", style: UIAlertAction.Style.default, handler: { action in self.openCameraPermission()}))
            
            alert?.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { action in self.openGalleryPermission()} ))
        }
        
        alert?.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        UIApplication.topViewController()!.present(alert!, animated: true, completion: nil)
    }
    
    //Mark:: Check Camera permission
    public func openCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:  // The user has previously granted access to the camera.
            self.captureImage()
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.captureImage()
                }
            }
            
        case .denied: // The user has previously denied access.
            print("Denied")
            self.presentCameraSettings()
            
            return
        case .restricted: // The user can't grant access due to restrictions.
            print("restricted")
            return
        }
    }
    
    //Mark:: Open Camera
    public func captureImage()
    {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        UIApplication.topViewController()!.present(imagePickerController, animated: true, completion: nil)
    }
    
    // Mark:: Open Camera Setting
    public func presentCameraSettings() {
        let alertController = UIAlertController(title: "Permissions needed",
                                                message: "Camera access is denied for this app. You can turn on Camera for this app in Settings.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                        // Handle
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        })
        
        UIApplication.topViewController()!.present(alertController, animated: true)
    }
    
    // Mark:: Open Gallery Permission
    public func openGalleryPermission(){
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:  // The user has previously granted access to the camera.
            self.openGallery()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.openGallery()
                }
            })
        case .denied: // The user has previously denied access.
            print("Denied")
            self.presentGallerySettings()
            
            return
        case .restricted: // The user can't grant access due to restrictions.
            print("restricted")
            return
            
        }
    }
    
    // Mark:: Open Gallery
    public func openGallery(){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        UIApplication.topViewController()!.present(image, animated: true) {}
    }
    
    // Mark:: Open Gallery Setting
    public func presentGallerySettings() {
        let alertController = UIAlertController(title: "Permissions needed",
                                                message: "Gallery access is denied for this app. You can turn on Photos for this app in Settings.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Later", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                        // Handle
                    })
                } else {
                    // Fallback on earlier versions
                }
            }
        })
        UIApplication.topViewController()!.present(alertController, animated: true)
    }
    
    // Mark:: Image didFinishPickingImage
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        setImageForImageView(image: image)
        UIApplication.topViewController()!.dismiss(animated: true, completion: nil)
    }
    
    // Mark:: Image didFinishPickingMediaWithInfo
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            setImageForImageView(image: image)
            UIApplication.topViewController()!.dismiss(animated: true, completion:  nil)
        }
        else{
            print("error")
        }
    }
    
    public func setImageForImageView(image: UIImage?) {
        imageView.image = image
        if imageView.image == nil {
            addEditButton.setTitle("Add Photo", for: .normal)
        } else {
            addEditButton.setTitle("Edit Photo", for: .normal)
        }
    }
    
    override public func layoutSubviews() {
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.imageView.frame.height + self.addEditButton.frame.height)
    }
}

extension UIApplication {
    static func topViewController() -> UIViewController? {
        guard var top = shared.keyWindow?.rootViewController else {
            return nil
        }
        while let next = top.presentedViewController {
            top = next
        }
        return top
    }
}

