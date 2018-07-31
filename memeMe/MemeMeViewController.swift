//
//  ViewController.swift
//  memeMe
//
//  Created by Andres Yepes on 7/31/18.
//  Copyright © 2018 Andres Yepes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var takePictureBtn: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0
    ]
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.takePictureBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.imageView.contentMode = .scaleAspectFit
        self.topText.defaultTextAttributes = memeTextAttributes
        self.topText.textAlignment = .center
        self.topText.delegate = self
        self.bottomText.defaultTextAttributes = memeTextAttributes
        self.bottomText.textAlignment = .center
        self.bottomText.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        self.topText.text = "TOP"
        self.bottomText.text = "BOTTOM"
        self.imageView.image = nil
    }
    
    @IBAction func share(_ sender: Any) {
        if let image = self.imageView.image{
            let meme = Meme(topText: self.topText.text!, bottomText: self.bottomText.text!, image: image, memeImage: generateMemedImage())
            let activityView = UIActivityViewController(activityItems: [meme.memeImage], applicationActivities: nil)
            activityView.completionWithItemsHandler = { (type,completed,items,error) in
                print("activity completionWithItemsHandler executed.")
                UIImageWriteToSavedPhotosAlbum(meme.memeImage, nil, nil, nil)
            }
            present(activityView, animated: true, completion: nil)
        }
        else {
            print("No image selected when trying to share.")
        }
    }
    
    @IBAction func album(_ sender: Any) {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            print("text Should begin Editing with text: \(text)")
            if text == "TOP" || text == "BOTTOM"{
                textField.text = ""
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") { return true }
        
        if self.topText.isFirstResponder {
            textField.text = "TOP"
        }
        else {
            textField.text = "BOTTOM"
        }
        return true
    }
    
    // MARK: - Keyboard
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("keyboard will show notification")
        print(notification)
        if self.bottomText.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        print("keyboard will Hide notification")
        view.frame.origin.y = 0
    }
    
    // MARK: - Methods
    
    func generateMemedImage() -> UIImage {
        self.navBar.isHidden = true
        self.toolBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navBar.isHidden = false
        self.toolBar.isHidden = false
        return memedImage
    }
}

