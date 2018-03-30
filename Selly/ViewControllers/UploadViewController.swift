//
//  UploadViewController.swift
//  Selly
//
//  Created by NICK on 3/5/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import AACarousel
import Firebase
import FirebaseDatabase
import Kingfisher

class UploadViewController: UIViewController, AACarouselDelegate{

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
      let databaseRef = Database.database().reference()

    
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var corouselView: AACarousel!

    var itemURLS: [String] = []
    var titleArray = [String]()
    
    var itemTitle: String?
    var itemDesc: String?
    var price: String?
    var category: String?
    
    @IBOutlet weak var lineLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        corouselView.delegate = self
        corouselView.setCarouselData(paths: itemURLS,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "selly.png")
        //optional methods
        //corouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        //corouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
        itemDescription.clipsToBounds = true
        itemDescription.sizeToFit()
        itemName.text = itemTitle
        itemDescription.text = itemDesc
        itemPrice.text = price
        categoryLabel.text = category
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        titleArray = [""]
        
    }
    
//    func getItemImages() {
//        databaseRef.child("items").queryOrderedByKey().observe(.value, with: { (snapshot) in
//            for data in (snapshot.value as? NSDictionary)! {
//                if(self.itemID.contains(data.key as! String)) {
//                    continue
//                } else {
//                    let cc = data.value as! NSDictionary
//                    let name = cc["itemName"] as? String ?? ""
//                    let imageUrls = cc["itemPhotos"] as? [String]
//                    let itemPirce = cc["itemPrice"] as? String!
//                    let itemCategory = cc["itemCategory"] as? String!
//
//                    // storing itemID as key
//                    self.itemID.append((cc["itemId"] as? String!)!)
//                    let url = URL(string: (imageUrls?[0])!)
//                    print(url)
//
//                    // set image, name, price, category
//
//                    self.titleLabel.text = name
//                    self.priceLabel.text = itemPirce
//                    self.categoryLabel.text = itemCategory
//                    break
//                }
//            }
//        })
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func downloadImages(_ url: String, _ index: Int) {
        
        //here is download images area
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url)!, placeholder: UIImage.init(named: "defaultImage"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: { (downloadImage, error, cacheType, url) in
            self.corouselView.images[index] = downloadImage!
        })
    }
    
    func didSelectCarouselView(_ view: AACarousel ,_ index: Int) {
        
        //let alert = UIAlertView.init(title:"Alert" , message: titleArray[index], delegate: self, cancelButtonTitle: "OK")
        //alert.show()
        
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
