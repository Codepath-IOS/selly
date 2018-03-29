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

class BrowseViewController: UIViewController {
    var databaseRef = Database.database().reference()
    var cardInitialCenter: CGPoint!
    var holdDefaultPosition: CGPoint!
    
    // connect these
    @IBOutlet weak var itemImageView: UIButton!
    //@IBOutlet weak var userImageView: UIButton!
    @IBOutlet var gestureRecognizer: AnyObject!
    
    @IBAction func rightButton(_ sender: Any) {
        performSegue(withIdentifier: "right", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Attach panGestureREcognizer to a view
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
                UIView.animate(withDuration:1, animations: {
                    // This causes first view to fade in and second view to fade out
                    self.itemImageView.center.x = 1000
                })
                databaseRef.child("items").queryOrderedByKey().observe(.value, with: { (snapshot) in
                    for data in (snapshot.value as? NSDictionary)! {
                        //print(data)
                        let cc = data.value as! NSDictionary
                        let name = cc["itemName"] as? String ?? ""
                        let imageUrls = cc["itemPhotos"] as? [String]
                        print(imageUrls)
                    }
                })
            }
            else if translation.x < -100{
                print("swiped left")
                UIView.animate(withDuration:1, animations: {
                    self.itemImageView.center.x = -1000
                })
            }
            else{
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
