//
//  ViewControllerLeaderboards.swift
//  Puzzle15iOS
//
//  Created by Артём Любоженко on 01.01.2022.
//

import UIKit
import CoreData

class ViewControllerLeaderboards: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchController: NSFetchedResultsController<LeaderboardEntity>!
    
    var leaderBoardRepository: LeaderBoardRepository!
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = AppDelegate.persistentContainer
        
        // Do any additional setup after loading the view.
        
        let personFetchRequest = LeaderboardEntity.fetchRequest()
        personFetchRequest.sortDescriptors = [NSSortDescriptor(key: "moves", ascending: true)]
        
        fetchController = NSFetchedResultsController(
            fetchRequest: personFetchRequest, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil
        )
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchController.delegate = self
        
        try? fetchController.performFetch()
        
        leaderBoardRepository = LeaderBoardRepository(container: container)
    }
}

extension ViewControllerLeaderboards: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let person = fetchController.object(at: indexPath)
            print("try deleting \(person)")
            if (leaderBoardRepository != nil) {
                try? leaderBoardRepository.delete(leaderboardEntity: person)
            }
        }
    }}

extension ViewControllerLeaderboards: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = fetchController.object(at: indexPath)
        cell.selectionStyle = .none
        if(person.time < 60)
        {
            cell.textLabel?.text = "Name: \(person.name!) Time: \(person.time) Moves: \(person.moves)"
        } else {
            if (person.time % 59 < 10) {
                cell.textLabel?.text = "Name: \(person.name!) Time: \(((person.time) - person.time % 59) / 59):0\(person.time % 59) Moves: \(person.moves)"
            } else {
                cell.textLabel?.text = "Name: \(person.name!) Time: \(((person.time) - person.time % 59) / 59):\(person.time % 59) Moves: \(person.moves)"
            }
        }
        return cell
    }
}

extension ViewControllerLeaderboards: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            tableView.reloadData()
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        @unknown default:
            fatalError("Unknown NSFetchedResultsChangeType")
        }
    }
}
