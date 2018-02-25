//
//  CoreDataHelp.swift
//  PokeHunter
//
//  Created by Juan Tenezaca on 2/21/18.
//  Copyright © 2018 Juan Tenezaca. All rights reserved.
//

import UIKit
import CoreData
import Foundation

func addAllSupplies(){
    
    createSupplies(name: "Crossbow", imageName: "crossbow")
    createSupplies(name: "Matches", imageName: "matches")

    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func createSupplies(name :String, imageName: String){
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let supplies = Supplies(context: context)
    
    supplies.name = name
    supplies.imageName = imageName
}


func getAllSupplies() -> [Supplies]{ // get all stuff out of core data
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        let supplieses = try context.fetch(Supplies.fetchRequest()) as! [Supplies]
        
        if supplieses.count == 2 {
            addAllSupplies()
            return getAllSupplies()
        }
        return supplieses
    } catch {}
    return []
}


func getAllSalvagedSupplies() -> [Supplies] {
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Supplies.fetchRequest() as NSFetchRequest<Supplies>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
    do{
        let supplieses = try context.fetch(fetchRequest) as [Supplies]
        return supplieses
    } catch{}
    return[]
}

func getAllMissingSupplies() -> [Supplies] {
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Supplies.fetchRequest() as NSFetchRequest<Supplies>
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg) // salvaged  = ?
    
    do{
        let supplieses = try context.fetch(fetchRequest) as [Supplies]
        return supplieses
    } catch{}
    return[]
}
