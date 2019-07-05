//
//  HomeViewController.swift
//  ThingsToDoRealm
//
//  Created by Sunil Gurung on 3/7/19.
//  Copyright © 2019 Sunil Gurung. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    let realMInstance = try! Realm()
    let UserResult = try! Realm().objects(UserObject.self)
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 100;
        self.navigationItem.hidesBackButton = true
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false;
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func btnAdd(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let addVC = storyBoard.instantiateViewController(withIdentifier: "addVC") as! AddViewController
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell{
            //var user: UserObject
            let user = UserResult[indexPath.row] as UserObject
            //user = self.UserResult[indexPath.row] as UserObject
            DispatchQueue.main.async {
                cell.lblName.text = user.name
                cell.lblAddress.text = user.address
            }
            return cell

        } else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserResult.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let user = UserResult[indexPath.row]
            try! realMInstance.write {
                    realMInstance.delete(user)
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

