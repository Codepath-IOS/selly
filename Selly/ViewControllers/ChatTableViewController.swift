//
//  ChatTableViewController.swift
//  Selly
//
//  Created by siddhant on 3/30/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage

class ChatTableViewController: UITableViewController {
    var likedProductName : [String]! = []
    var likedProductSellerName : [String]! = []
    var productURL: [URL]! = []
    var refresh: UIRefreshControl!
    //var databaseRef = Database.database().reference()
    var userRef = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(getter: ChatTableViewController.refresh), for: .valueChanged)
        
        tableView.insertSubview(refresh!, at: 0)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(getLikedProducts), userInfo: nil, repeats: false)
        
        
    }
    
    
    
    
    func getLikedProducts() {
        //likedProductName = []
        userRef.child("likedProducts").queryOrderedByKey().observe(.value, with: { (snapshot) in
            for data in (snapshot.value as? NSDictionary)! {
                let cc = data.value as! NSDictionary
                //print(cc)
                let name = cc["productName"] as? String!
                let seller = cc["sellerName"] as? String!
                let url = URL(string: (cc["photoURL"] as? String!)!)
                
                self.likedProductName.append(name!)
                self.likedProductSellerName.append(seller!)
                self.productURL.append(url!)
                //print(cc["productName"] as? String ?? "")
                
            }
            self.tableView.reloadData()
            self.refresh?.endRefreshing()
        })
        //print(likedProductName)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(likedProductName.count)
        return likedProductName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as! ChatTableViewCell
        cell.productNameLabel.text = likedProductName[indexPath.row]
        cell.sellerNameLabel.text = likedProductSellerName[indexPath.row]
        cell.sellerImage.af_setImage(withURL: productURL[indexPath.row])
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
