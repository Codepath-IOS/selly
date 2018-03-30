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
    
    @IBOutlet weak var sellerImage: UIImageView!
    var null: NSNull!
    @IBOutlet weak var sellerEmail: UILabel!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet var gestureRecognizer: AnyObject!
    
    var itemID: [String] = [] // keeps keys of items
    var itemName: String = ""
    var itemCategory: String = ""
    var itemDescription: String = ""
    var itemPrice: String = ""
    var itemURLS: [String] = []
    
    
    @IBAction func rightButton(_ sender: Any) {
        performSegue(withIdentifier: "right", sender: self)
    }
    
    func getProduct() {
        databaseRef.child("items").queryOrderedByKey().observe(.value, with: { (snapshot) in
            if(snapshot.value as? NSDictionary == self.null) {
                return
            }
            for data in (snapshot.value as? NSDictionary)! {
                if(self.itemID.contains(data.key as! String)) {
                    continue
                } else {
                    let cc = data.value as! NSDictionary
                    let name = cc["itemName"] as? String ?? ""
                    let imageUrls = cc["itemPhotos"] as? [String]
                    let itemPirce = cc["itemPrice"] as? String!
                    let itemCategory = cc["itemCategory"] as? String!
                    let sellerName = cc["sellerName"] as? String!
                    let sellerEmail = cc["sellerEmail"] as? String!
                    let sellerImageURL = cc["sellerImageURL"] as? String!
                    
                    self.itemDescription = (cc["itemDescription"] as? String!)!
                    // storing itemID as key
                    self.itemID.append((cc["itemId"] as? String!)!)
                    self.itemURLS = imageUrls!
                    let url = URL(string: (imageUrls?[0])!)
                    let sellerUrl = URL(string: sellerImageURL!)

                    // set image, name, price, category
                    self.itemImageView.af_setImage(for: .normal, url: url!)
                    self.titleLabel.text = name
                    self.priceLabel.text = "$ " + itemPirce!
                    self.categoryLabel.text = itemCategory
                    self.sellerEmail.text = sellerEmail
                    self.sellerName.text = sellerName
                    self.sellerImage.af_setImage(withURL: sellerUrl!)
                    break
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProduct()
        // Attach panGestureREcognizer to a view
        itemImageView.imageView?.layer.cornerRadius = 7
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        itemImageView.isUserInteractionEnabled = true
        itemImageView.addGestureRecognizer(panGestureRecognizer)
        cardInitialCenter = itemImageView.center
        holdDefaultPosition = itemImageView.center
        
        sellerImage.layer.borderWidth = 1
        sellerImage.layer.masksToBounds = false
        sellerImage.layer.borderColor = UIColor.black.cgColor
        sellerImage.layer.cornerRadius = sellerImage.frame.height/2
        sellerImage.clipsToBounds = true
        // Do any additional setup after loading the view...
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        /* main card gestures logic will go here */
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Gesture began")
        }
        else if sender.state == .changed {
            itemImageView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 8) * (translation.x * 0.01))
            itemImageView.center.x = cardInitialCenter.x + translation.x
            itemImageView.center.y = cardInitialCenter.y + translation.y
            //print("Gesture changing")
        }
        else if sender.state == .ended {
            if translation.x > 100{
                print("swiped right")
                getProduct()
                UIView.animate(withDuration:1, animations: {
//                    self.itemImageView.imageView?.center = CGPoint(x: self.cardInitialCenter.x + translation.x, y: self.cardInitialCenter.y)
                    self.itemImageView.center.x = 1000
                    self.getProduct()
                })
                self.itemImageView.transform = CGAffineTransform.identity
                self.itemImageView.center.x = self.holdDefaultPosition.x
                self.itemImageView.center.y = self.holdDefaultPosition.y
            }
            else if translation.x < -100{
                print("swiped left")
                getProduct()
                UIView.animate(withDuration:1, animations: {
                    self.itemImageView.center.x = -1000
                    self.getProduct()
                })
                self.itemImageView.transform = CGAffineTransform.identity
                self.itemImageView.center.x = self.holdDefaultPosition.x
                self.itemImageView.center.y = self.holdDefaultPosition.y
            }
            else{
                // swipe staying in middle
                UIView.animate(withDuration:1, animations: {
                    self.itemImageView.transform = CGAffineTransform.identity
                    self.itemImageView.center.x = self.holdDefaultPosition.x
                    self.itemImageView.center.y = self.holdDefaultPosition.y
                })
            }
            print("Gesture has ended")
        }
        
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        getProduct()
    }
    
    
    @IBAction func dislikeButton(_ sender: Any) {
        getProduct()
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: false, completion: nil)
        }

    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail"){
            
            
            //let desViewController = segue.destination as? UINavigationController
            //let VC = desViewController?.viewControllers.first as? UploadViewController
            let VC = segue.destination as? DetailViewController
            //print(titleLabel.text)
            VC?.itemTitle = titleLabel.text
            VC?.price = priceLabel.text
            VC?.itemURLS = itemURLS
            VC?.itemDesc = itemDescription
            VC?.category = categoryLabel.text
            
        }
        
     }
    
    
}
