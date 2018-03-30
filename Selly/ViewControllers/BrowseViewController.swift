//
//  BrowseViewController.swift
//  Selly
//
//  Created by NICK on 3/5/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import AlamofireImage

class BrowseViewController: UIViewController {
    var databaseRef = Database.database().reference()
    var cardInitialCenter: CGPoint!
    var holdDefaultPosition: CGPoint!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    // connect these
    @IBOutlet weak var itemImageView: UIButton!
    //@IBOutlet weak var userImageView: UIButton!
    @IBOutlet var gestureRecognizer: AnyObject!
    
    var itemID: [String] = [] // keeps keys of items
    
    @IBAction func rightButton(_ sender: Any) {
        performSegue(withIdentifier: "right", sender: self)
    }
    
    func getProduct() {
        databaseRef.child("items").queryOrderedByKey().observe(.value, with: { (snapshot) in
            for data in (snapshot.value as? NSDictionary)! {
                if(self.itemID.contains(data.key as! String)) {
                    continue
                } else {
                    let cc = data.value as! NSDictionary
                    let name = cc["itemName"] as? String ?? ""
                    let imageUrls = cc["itemPhotos"] as? [String]
                    let itemPirce = cc["itemPrice"] as? String!
                    let itemCategory = cc["itemCategory"] as? String!

                    // storing itemID as key
                    self.itemID.append((cc["itemId"] as? String!)!)
                    let url = URL(string: (imageUrls?[0])!)
//                    print(url)
                    
                    // set image, name, price, category
                    self.itemImageView.af_setImage(for: .normal, url: url!)
                    self.titleLabel.text = name
                    self.priceLabel.text = itemPirce
                    self.categoryLabel.text = itemCategory
                    break
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Attach panGestureREcognizer to a view
        itemImageView.imageView?.layer.cornerRadius = 7
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        itemImageView.isUserInteractionEnabled = true
        itemImageView.addGestureRecognizer(panGestureRecognizer)
        cardInitialCenter = itemImageView.center
        holdDefaultPosition = itemImageView.center
        // Do any additional setup after loading the view...
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        /* main card gestures logic will go here */
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Gesture began")
            
        } else if sender.state == .changed {
            itemImageView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 8) * (translation.x * 0.01))
            itemImageView.center.x = cardInitialCenter.x + translation.x
            itemImageView.center.y = cardInitialCenter.y + translation.y
            //print("Gesture changing")
        } else if sender.state == .ended {
            if translation.x > 100{
                print("swiped right")
                 getProduct()
                UIView.animate(withDuration:1, animations: {
                    // This causes first view to fade in and second view to fade out
                    self.itemImageView.center = CGPoint(x: self.cardInitialCenter.x + translation.x, y: self.cardInitialCenter.y)
                    self.itemImageView.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI / 560))
                })
                
            }
            else if translation.x < -100{
                print("swiped left")
                UIView.animate(withDuration:1, animations: {
                    self.itemImageView.center.x = -1000
                })
                getProduct()
            }
            else{
                UIView.animate(withDuration:1, animations: {
                    self.itemImageView.transform = CGAffineTransform.identity
                    self.itemImageView.center.x = self.holdDefaultPosition.x
                    self.itemImageView.center.y = self.holdDefaultPosition.y
                })
             }
            /*
            let location = sender.location(in: view)
            if sender.state == .began {
                cardInitialCenter = itemImageView.center
                print("Gesture began")
             } else if sender.state == .changed {
                if (location.y < itemImageView.frame.height/2)
                { itemImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                    itemImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double(translation.x) * M_PI / 560))
                }
                else {
                    itemImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
                    itemImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-1.0 * Double(translation.x) * M_PI / 560))
                }
                
                if(translation.x > 175 || translation.x < -175) {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.itemImageView.alpha = 0
                    })
                }
                print("Gesture is changing")
             } else if sender.state == .ended {
                itemImageView.center = CGPoint(x: cardInitialCenter.x, y: cardInitialCenter.y)
                itemImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
                print("Gesture ended")
            }
            print("Gesture has ended")
            */
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        getProduct()
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
