//
//  ImagePickerControllerDelegate.swift
//  MemeMe 1.0
//
//  Created by Jeremy Spradlin on 10/5/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerControllerDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Delegate functions
    //Function for Image Picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePickerView.image = image
        print("Inside imagePickerController")
        dismiss(animated: true, completion: nil)
    }
}
