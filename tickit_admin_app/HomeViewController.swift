//
//  HomeViewController.swift
//  tickit_admin_app
//
//  Created by Angadjot singh on 14/04/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var backGroundView: UIView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    var arr = ["Movies","Events","Sporting Event","Popular Events"]
    var defaults = UserDefaults.standard
    var db:Firestore?
    var dict = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 19/255, green: 47/255, blue: 170/255, alpha: 1/255)
      
                backGroundView.layer.shadowColor = UIColor.black.cgColor
        backGroundView.layer.shadowOpacity = 0.2
                backGroundView.layer.shadowOffset = .zero
                backGroundView.layer.shadowRadius = 5
                backGroundView.layer.cornerRadius = 10
        
        
        retrieveUserDetails()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

        cell.bgView.layer.shadowColor = UIColor.black.cgColor
        cell.bgView.layer.shadowOpacity = 0.2
        cell.bgView.layer.shadowOffset = .zero
        cell.bgView.layer.shadowRadius = 5
        cell.bgView.layer.cornerRadius = 10
               
        
        cell.labelName.text = arr[indexPath.row]
        
        if indexPath.row == 0{
            cell.img.image = UIImage(named: "movie")
        }else if indexPath.row == 1{
            cell.img.image = UIImage(named: "event")
        }else if indexPath.row == 2{
            cell.img.image = UIImage(named: "sports")
        }else if indexPath.row == 3{
            cell.img.image = UIImage(named: "popularEvents")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            self.performSegue(withIdentifier: "movie", sender: nil)
        }else if indexPath.row == 1{
            self.performSegue(withIdentifier: "events", sender: nil)
        }else if indexPath.row == 2{
            self.performSegue(withIdentifier: "sports", sender: nil)
        }else if indexPath.row == 3{
            self.performSegue(withIdentifier: "popular", sender: nil)
        }
    }
    
    
    func retrieveUserDetails(){
          let uid = self.defaults.string(forKey: "adminUid")
          print("uid is",uid!)
          db = Firestore.firestore()
          db?.collection("admin").document(uid!).getDocument(completion: { (snap, err) in
              
               if let err = err{
                  print("err is",err.localizedDescription)
               }else{
                  
                  if(snap?.data() != nil){
                    self.dict = (snap?.data() as? [String : AnyObject])!
                    print("dict is",self.dict)
                  }
                  
                  self.name.text = self.dict["name"] as? String
                  self.phone.text = self.dict["phone"] as? String
               }
          })
      }
    
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        
        do{
            try Auth.auth().signOut()
            self.defaults.set("", forKey: "adminUid")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let root = storyBoard.instantiateViewController(withIdentifier: "main")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = root
        }catch let err{
            print("error signing out",err.localizedDescription)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
