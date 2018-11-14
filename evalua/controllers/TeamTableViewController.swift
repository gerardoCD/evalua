//
//  TeamTableViewController.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    var classroomIndex: Int?
    let classrooms = ClassroomStorage.shared

    lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapAdd(_:)))

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAddTeam(_:)),
                                               name: NotificationKeys.team(create: true).name,
                                               object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let idx = classroomIndex {
            title = classrooms[idx].name
            addButton.isEnabled = true
        } else {
            title = "Teams"
            addButton.isEnabled = false
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let idx = classroomIndex else { return 0 }
        return classrooms[idx].teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)

        guard let idx = classroomIndex else { return cell }
        let team = classrooms[idx].teams[indexPath.row]
        cell.textLabel?.text = team.name
        cell.detailTextLabel?.text = team.repo
        team.githubImage { img in
            cell.imageView?.image = img
        }
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! TeamEvaluationViewController
                controller.team = classrooms[classroomIndex!].teams[indexPath.row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(72.0)
    }

    @objc func onTapAdd(_ sender: Any) {
        let viewController = TeamFormViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }

    @objc func didAddTeam(_ notification: Notification) {
        guard let idx = classroomIndex else { return }
        guard let userInfo = notification.userInfo else { return }
        let info = userInfo as! [String: Team]
        guard let team = info["team"] else { return }
        classrooms[idx].teams.insert(team, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
