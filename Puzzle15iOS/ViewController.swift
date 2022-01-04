//
//  ViewController.swift
//  Puzzle15iOS
//
//  Created by Артём Любоженко on 01.01.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        container = AppDelegate.persistentContainer
        guard container != nil else {
            fatalError("This view needs NSPersistentContainer")
        }

        print("Loaded ViewController")
        
//        saveData()
//        showData()
    }

    func saveData(name: String, moves: Int, time: Int) {
        let context = container.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LeaderboardEntity", in: context)
        let newLeaderboardEntity = NSManagedObject(entity: entity!, insertInto: context)
        newLeaderboardEntity.setValue(name, forKey: "name")
        newLeaderboardEntity.setValue(moves, forKey: "moves")
        newLeaderboardEntity.setValue(time, forKey: "time")

        do {
            try context.save()
        } catch {
            print("Failed savinf into DB!")
        }
    }

    func showData() {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LeaderboardEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                print(data.value(forKey: "moves") as! Int32)
                print(data.value(forKey: "time") as! Int32)
            }
        } catch {

        }
    }
    
}

