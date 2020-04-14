//
//  EventsViewController.swift
//  tickit_admin_app
//
//  Created by Angadjot singh on 14/04/20.
//  Copyright © 2020 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase


class EventsViewController: UIViewController {

    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDate: UITextField!
    @IBOutlet weak var eventRunningTime: UITextField!
    @IBOutlet weak var silverTicketCost: UITextField!
    @IBOutlet weak var goldTicketCost: UITextField!
    @IBOutlet weak var platinumTicketCost: UITextField!
    
    
    @IBOutlet weak var updateOutlet: UIButton!
    
    
    let defaults = UserDefaults.standard
    var indicator = UIActivityIndicatorView()
    var db:Firestore?
    var docId:String?
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        showPicker()
        
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
    
    
    func showPicker() {
        datePicker.datePickerMode = .date
       
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MoviesViewController.donedatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MoviesViewController.cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        
        eventDate.inputAccessoryView = toolbar
        eventDate.inputView = datePicker
        
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @objc func donedatePicker(){
        print("hollllllllaaaaaaaffnjnjnjnj")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        datePicker.minimumDate = Date()
        
        eventDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        
        
        self.indicator.startAnimating()
          db = Firestore.firestore()
          docId = (db?.collection("events").document().documentID)!

          let param = [
                 "eventId":docId!,
                  "totalTicketsToBeSold":200,
                  "eventNam":eventName.text!,
                  "eventDate":eventDate.text!,
                  "eventTotalTime":eventRunningTime.text! + "Hours",
                  "silverTicketCost":silverTicketCost.text!,
                  "goldTicketCost":goldTicketCost.text!,
                  "platinumTicketCost":platinumTicketCost.text!,
                  "imageUrl":"https://firebasestorage.googleapis.com/v0/b/tick-it-b97c1.appspot.com/o/the%20gentlemen.jpeg?alt=media&token=a0c23417-a409-4776-96b0-cbef945f85da",
                  
                    ] as [String : Any]
                
          
           db?.collection("events").document(docId!).setData(param as [String : Any]){
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
