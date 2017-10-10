//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Jeremy Spradlin on 10/4/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import AVFoundation
import Photos


class MemeEditorViewController: MemeTextAtrributes, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: Outlet declaration
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let textFieldDelegate = MemeTextFieldDelegate()
    
    //var memedImage = generateMemedImage()
    
    
    //MARK:  Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        topTextField.text = "TOP"
        topTextField.borderStyle = UITextBorderStyle.none
        topTextField.backgroundColor = UIColor.clear
        topTextField.delegate = textFieldDelegate

        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.borderStyle = UITextBorderStyle.none
        bottomTextField.backgroundColor = UIColor.clear
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = .center
        bottomTextField.delegate = textFieldDelegate
        
        
        imagePickerView.contentMode = .scaleAspectFit
        


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = imagePickerView.image != nil
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    
    //MARK:  Keyboard Functions for subscribing to keyboard notifications and shifting the view whenever the keyboard is brought in
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue  // of CGRect?
        print(keyboardSize)
        print(keyboardSize.cgRectValue.height)
        return keyboardSize.cgRectValue.height
    }
    
    
    
    
    //MARK: Action functionsUser selects to pick an image from the album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    //User selects to take a picture with the camera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func activityButton(_ sender: Any) {
        let meme = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
//        activityController.completionWithItemsHandler = { activity, success, items, error in
//
//            if(success) {
//                self.save()
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
        save()
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        shareButton.isEnabled = false
    }
    
    
    
    
    //MARK: Delegate functions
    //Function for Image Picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePickerView.image = image
        print("Inside imagePickerController")
        dismiss(animated: true, completion: nil)
    }


    //MARK: Generate the meme image function
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    
    //MARK: Save function for saving the meme
    func save() {
        _ = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        print("Inside save function")
    }
}

