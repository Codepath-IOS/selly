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

    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var corouselView: AACarousel!
    var itemURLS: [String] = []
    var titleArray = [String]()
    
    var itemTitle: String?
    var itemDesc: String?
    var price: String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        corouselView.delegate = self
        corouselView.setCarouselData(paths: itemURLS,  describedTitle: titleArray, isAutoScroll: true, timer: 5.0, defaultImage: "selly.png")
        //optional methods
        corouselView.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: false)
        corouselView.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 5, pageIndicatorColor: nil, describedTitleColor: nil, layerColor: nil)
        itemDescription.layer.cornerRadius = 8
        itemDescription.clipsToBounds = true

        itemName.text = itemTitle
        itemDescription.text = itemDesc
        itemPrice.text = price
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleArray = [""]
        
    }
    
    

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
