//
//  DetailViewController.swift
//  Selly
//
//  Created by NICK on 3/5/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!

    @IBOutlet weak var image5: UIImageView!
    
    @IBOutlet weak var image6: UIImageView!
    
    @IBOutlet weak var addImage1: UIImageView!
    @IBOutlet weak var addImage2: UIImageView!
    
    @IBOutlet weak var addImage3: UIImageView!
    
    @IBOutlet weak var addImage4: UIImageView!
    
    @IBOutlet weak var addImage6: UIImageView!
    @IBOutlet weak var addImage5: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    
    @IBOutlet weak var itemDescriptionTextField: UITextView!
    
    
    weak var selectedImageView: UIImageView!
    weak var addImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageView.image = image
            addImageView.image = nil
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImage1(_ sender: Any) {
        print("clicked1")
        selectedImageView = image1
        addImageView = addImage1
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func uploadImage2(_ sender: Any) {
        print("clicked2")
        selectedImageView = image2
        addImageView = addImage2
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func uploadImage3(_ sender: Any) {
        print("clicked3")
        selectedImageView = image3
        addImageView = addImage3
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func uploadImage4(_ sender: Any) {
        print("clicked4")
        selectedImageView = image4
        addImageView = addImage4
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func uploadImage5(_ sender: Any) {
        print("clicked5")
        selectedImageView = image5
        addImageView = addImage5
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func uploadImage6(_ sender: Any) {
        print("clicked6")
        selectedImageView = image6
        addImageView = addImage6
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onPost(_ sender: Any) {
        var photos: [UIImage] = []
        
        if image1.image != nil {
            photos.append(image1.image!)
        }
        if image2.image != nil {
            photos.append(image2.image!)
        }
        if image3.image != nil {
            photos.append(image4.image!)
        }
        if image4.image != nil {
            photos.append(image4.image!)
        }
        if image5.image != nil {
            photos.append(image5.image!)
        }
        if image6.image != nil {
            photos.append(image6.image!)
        }
        if photos.count == 0{
            return
        }
        
        SellyClient.sharedInstance.uploadPhoto(itemPhotos: photos, success: { (photoURLs) in
            SellyClient.sharedInstance.createItem(itemName: self.itemNameTextField.text!, itemPrice: self.itemPriceTextField.text!, itemCategory: "candy", itemDescription: self.itemDescriptionTextField.text!, uidSeller: Auth.auth().currentUser!.uid , itemPhotos: photoURLs, success: { (newItem) in
                print(newItem.itemName)
            }, failure: { (error) in
                print(error.localizedDescription)
            })
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
