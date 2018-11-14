//
//  ClassroomViewController.swift
//  evalua
//
//  Created by Luis Ezcurdia on 10/30/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import UIKit

class ClassroomViewController: UITableViewController {
    var detailViewController: TeamTableViewController!
    let classrooms = ClassroomStorage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCreatedClassroom(_:)),
                                               name: NotificationKeys.classroom(create: true).name,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEditClassroom(_:)),
                                               name: NotificationKeys.classroom(create: false).name,
                                               object: nil)
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapAdd(_:)))
        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc func onTapAdd(_ sender: Any) {
        let viewController = ClassroomFormViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTeams" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! TeamTableViewController
                controller.classroomIndex = indexPath.row
            }
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classrooms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classroomCell", for: indexPath)

        let classroom = classrooms[indexPath.row]
        cell.textLabel?.text = classroom.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            classrooms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(72.0)
    }

    @objc func didCreatedClassroom(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let info = userInfo as! [String: Classroom]
        guard let classroom = info["classroom"] else { return }
        classrooms[0] = classroom
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @objc func didEditClassroom(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let info = userInfo as! [String: String]
        print(info)
    }
}
