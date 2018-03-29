//
//  UploadViewController.swift
//  Selly
//
//  Created by NICK on 3/5/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import AACarousel
import Kingfisher

class UploadViewController: UIViewController, AACarouselDelegate{

    
    
    @IBOutlet weak var corouselView: AACarousel!
    
    var titleArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let pathArray = ["https://firebasestorage.googleapis.com/v0/b/selly-7d9c2.appspot.com/o/itemPhotos%2F6E73A2A0-8FD3-4FCA-85E2-D7E65AEA0CA7?alt=media&token=63df7934-4968-4907-9ae6-3ddea1ad8cfa",
                         "https://firebasestorage.googleapis.com/v0/b/selly-7d9c2.appspot.com/o/itemPhotos%2FBFF225AB-5A3C-47E3-86D1-2732A9B20BE9?alt=media&token=ea56710f-61ea-4d34-bd3f-66fd8c0e7600", "https://firebasestorage.googleapis.com/v0/b/selly-7d9c2.appspot.com/o/itemPhotos%2FEF0908F5-C411-4A29-9AD9-8C0310590035?alt=media&token=e5536263-275b-4c56-aff8-f1da726988ec"]
        titleArray = [""]
        corouselView.delegate = self
        corouselView.setCarouselData(paths: pathArray,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "selly.png")
        //optional methods
        corouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        corouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // * fetching a single item detail information from firebase *
//    func fecthingAnItemDetail(name: String, price: String, Description: String){
//    }
    //                databaseRef.child("items").queryOrderedByKey().observe(.value, with: { (snapshot) in
    //                    for data in (snapshot.value as? NSDictionary)! {
    //                        //print(data)
    //                        let cc = data.value as! NSDictionary
    //                        let name = cc["itemName"] as? String ?? ""
    //                        let imageUrls = cc["itemPhotos"] as? [String]
    //                        print(imageUrls)
    //                    }
    //                })
    
//    SellyClient.sharedInstance.uploadPhoto(itemPhotos: photos, success: { (photoURLs) in
//    SellyClient.sharedInstance.createItem(itemName: self.itemNameTextField.text!, itemPrice: self.itemPriceTextField.text!, itemCategory: "candy", itemDescription: self.itemDescriptionTextField.text!, uidSeller: Auth.auth().currentUser!.uid , itemPhotos: photoURLs, success: { (newItem) in
//    print(newItem.itemName)
//    }, failure: { (error) in
//    print(error.localizedDescription)
//    })
//    }) { (error) in
//    print(error.localizedDescription)
//    }
    
    
    
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.corouselView.images[index] = downloadImage!
        })
    }
    
    func didSelectCarouselView(_ view: AACarousel ,_ index: Int) {
        
        let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
        //startAutoScroll()
        //stopAutoScroll()
    }
    
    //optional method (show first image faster during downloading of all images)
    func callBackFirstDisplayView(_ imageView: UIImageView, _ url: [String], _ index: Int) {
        
        imageView.kf.setImage(with: URL(string: url[index]), placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        
    }
    
    func startAutoScroll() {
        //optional method
        corouselView.startScrollImageView()
        
    }
    
    func stopAutoScroll() {
        //optional method
        corouselView.stopScrollImageView()
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
