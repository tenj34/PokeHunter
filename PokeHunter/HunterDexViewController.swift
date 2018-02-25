//
//  HunterDexViewController.swift
//  PokeHunter
//
//  Created by Juan Tenezaca on 2/21/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit

class HunterDexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var salvagedSupplies : [Supplies] = []
    var missingSupplies :[Supplies] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        salvagedSupplies = getAllSalvagedSupplies()
        missingSupplies = getAllMissingSupplies()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "SALVAGED"
        } else{
            return "MISSING"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return salvagedSupplies.count
        } else {
            return missingSupplies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let supplies : Supplies
        
        if indexPath.section == 0 {
            supplies = salvagedSupplies[indexPath.row]
        } else {
            supplies = missingSupplies[indexPath.row]
        }
        let cell = UITableViewCell()
        
        cell.textLabel?.text = supplies.name
        cell.imageView!.image = UIImage(named: supplies.imageName!)
        return cell
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion:  nil)
        // dismiss the VC
    }
}
