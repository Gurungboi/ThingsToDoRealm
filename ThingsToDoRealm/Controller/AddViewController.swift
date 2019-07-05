//
//  AddViewController.swift
//  ThingsToDoRealm
//
//  Created by Sunil Gurung on 3/7/19.
//  Copyright © 2019 Sunil Gurung. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    let realMInstance = try! Realm()

    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func insertDetail(name:String,address:String) -> UserObject{
        let newUser = UserObject()
        newUser.name = name
        newUser.address = address
        return newUser
    }

    @IBAction func btnSave(_ sender: Any) {
        let name = lblName.text as! String
        let address = lblAddress.text as! String
        let result = [name,address] as NSArray
        if name.isEmpty{
            displayMyAlertMessage(title: "Error",userMessage: "Enter Your Name")
        } else if address.isEmpty{
            displayMyAlertMessage(title: "Error",userMessage: "Enter Your Address")
        } else {
            let newUser = self.insertDetail(name: name, address: address)
            try! realMInstance.write {
                realMInstance.add(newUser)
            }
            fetch()
            clear()
        }
    }
    func clear(){
        displayMyAlertMessage(title:"Saved",userMessage: "Done")
        lblName.text = ""
        lblAddress.text = ""
    }
    func displayMyAlertMessage(title: String, userMessage:String){
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func fetch(){
        let users = realMInstance.objects(UserObject.self)
        for user in users{
            print("Your Name is " + user.name)
            print("Your Address is " + user.address)

        }
    }
}
