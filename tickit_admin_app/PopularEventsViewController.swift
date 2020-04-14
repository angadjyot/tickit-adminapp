//
//  PopularEventsViewController.swift
//  tickit_admin_app
//
//  Created by Angadjot singh on 14/04/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase

class PopularEventsViewController: UIViewController {

    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeAddress: UITextField!
    @IBOutlet weak var childTicketCost: UITextField!
    @IBOutlet weak var adultTicketCost: UITextField!
    @IBOutlet weak var seniorTicketCost: UITextField!
    
    
    @IBOutlet weak var updateOutlet: UIButton!
    
    let defaults = UserDefaults.standard
    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    var docId:String?
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator()
       
              
        self.navigationController?.navigationBar.tintColor = UIColor.white
                     
        self.updateOutlet.layer.cornerRadius = 10.0
        self.updateOutlet.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func activityIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
        indicator.style = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    
    @IBAction func updateAction(_ sender: UIButton) {
        self.indicator.startAnimating()
        db = Firestore.firestore()
        docId = (db?.collection("popularVisits").document().documentID)!

           let param = [
                       "popularId": docId!,
                        "totalTicketsToBeSold": 200,
                        "placeName": placeName.text!,
                        "placeAddress": placeAddress.text!,
                        "childTicket": childTicketCost.text!,
                        "adultTicket": adultTicketCost.text!,
                        "seniorTicket": seniorTicketCost.text!,
                       "placeImage":"https://firebasestorage.googleapis.com/v0/b/tick-it-b97c1.appspot.com/o/the%20gentlemen.jpeg?alt=media&token=a0c23417-a409-4776-96b0-cbef945f85da",
                       
                    ] as [String : Any]
                     
               
            db?.collection("popularVisits").document(docId!).setData(param as [String : Any]){
                    err in
                    
                    if let err = err{
                        print("err",err.localizedDescription)
                        self.indicator.stopAnimating()
                    }else{
                        print("successfully added")
                       self.indicator.stopAnimating()
                        //self.performSegue(withIdentifier: "homeVC", sender: nil)
                     
                       let alert:UIAlertController = UIAlertController(title: "Message", message: "Successfully Added", preferredStyle: .alert)
                     let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                     })
                     alert.addAction(alertAction)
                     self.present(alert, animated: true, completion: nil)
                     
                    }
                    
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
