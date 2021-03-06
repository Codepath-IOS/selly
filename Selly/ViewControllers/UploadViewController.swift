
//
//  UploadViewController.swift
//  Selly
//
//  Created by NICK on 3/5/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import Firebase

/*extension UIImage {
 enum JPEGQuality: CGFloat {
 case lowest  = 0
 case low     = 0.25
 case medium  = 0.5
 case high    = 0.75
 case highest = 1
 }
 
 /// Returns the data for the specified image in JPEG format.
 /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
 /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
 func jpeg(_ quality: JPEGQuality) -> Data? {
 return UIImageJPEGRepresentation(self, quality.rawValue)
 }
 }*/
extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var charCountLabel: UILabel!
    
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
    @IBOutlet weak var itemCategoryTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextView!
    
    var charCount = 0;
    weak var selectedImageView: UIImageView!
    weak var addImageView: UIImageView!
    
    let categoryList = ["Electronics",  "Clothing & accessories",  "Home & Garden", "Entertainment", "Housing", "Other"]
    var pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let logo = UIImage(named: "selly.png") //SET IMAGE OF THE NAV BAR TITLE
        //let imageView = UIImageView(image:logo)
        //imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 30)
        //self.navigationItem.titleView = imageView
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        itemCategoryTextField.inputView = pickerView
        itemCategoryTextField.textAlignment = .center
        itemCategoryTextField.placeholder = "Select Category"
        
        itemDescriptionTextField.layer.cornerRadius = 8
        itemDescriptionTextField.clipsToBounds = true
        itemDescriptionTextField.delegate = self
        
        
        resizeImages(image: image1)
        resizeImages(image: image2)
        resizeImages(image: image3)
        resizeImages(image: image4)
        resizeImages(image: image5)
        resizeImages(image: image6)
        
    }
    
    // Picker View : Dropdown Caetegory
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemCategoryTextField.text = categoryList[row]
        itemCategoryTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print(itemCategoryTextField.text ?? "")
    }
    
    func resizeImages(image: UIImageView) {
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.layer.borderWidth = 1.5
        image.layer.borderColor = UIColor.black.cgColor
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return charCount < 140 || text == ""
    }
    func textViewDidChange(_ textView: UITextView) {
        charCount = itemDescriptionTextField.text.characters.count
        charCountLabel.text = "\(charCount)"
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            var img: UIImage!
            img = image.resizeWithWidth(width: 700)!
            //if let imageData = image.jpeg(.lowest) {
            if let compressData = UIImageJPEGRepresentation(img, 0.5) {
                //print(imageData.count)
                let image = UIImage(data: compressData)
                selectedImageView.image = image
            }
            
            //selectedImageView.image = image
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
        UIApplication.shared.beginIgnoringInteractionEvents()
        if(itemNameTextField.text?.isEmpty)!{
            itemNameTextField.layer.borderWidth = 1.5
            itemNameTextField.layer.borderColor = UIColor.red.cgColor
            return
        }else if(itemPriceTextField.text?.isEmpty)! {
            itemPriceTextField.layer.borderWidth = 1.5
            itemPriceTextField.layer.borderColor = UIColor.red.cgColor
            itemNameTextField.layer.borderWidth = 0
            itemNameTextField.layer.borderColor = nil
            return
        }else {
            itemPriceTextField.layer.borderWidth = 0
            itemPriceTextField.layer.borderColor = nil
        }
        var photos: [UIImage] = []
        
        if image1.image != nil {
            photos.append(image1.image!)
        }
        if image2.image != nil {
            photos.append(image2.image!)
        }
        if image3.image != nil {
            photos.append(image3.image!)
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
            SellyClient.sharedInstance.createItem(itemName: self.itemNameTextField.text!, itemPrice: self.itemPriceTextField.text!, itemCategory: self.itemCategoryTextField.text!, itemDescription: self.itemDescriptionTextField.text!, uidSeller: Auth.auth().currentUser!.uid , itemPhotos: photoURLs, success: { (newItem) in
                UIApplication.shared.endIgnoringInteractionEvents()
                let successAlert = UIAlertController(title: "Yay", message: "Uploaded!", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    successAlert.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(successAlert, animated: true, completion: nil)
            }, failure: { (error) in
                print(error.localizedDescription)
                UIApplication.shared.endIgnoringInteractionEvents()
            })
        }) { (error) in
            print(error.localizedDescription)
            UIApplication.shared.endIgnoringInteractionEvents()
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
//
//  UploadViewController.swift
//  Selly
//
//  Created by NICK on 3/5/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

