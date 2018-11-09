//
//  TeamFormViewController.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/1/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import UIKit
import Eureka

class TeamFormViewController: FormViewController {
    let nameRow: TextRow = {
        let row = TextRow()
        row.title = "Name"
        row.placeholder = "Your team name"
        row.add(rule: RuleRequired())
        row.validationOptions = .validatesOnChange
        row.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        return row
    }()
    let githubRow: TextRow = {
        let row = TextRow()
        row.title = "Github User"
        row.placeholder = "Your team name"
        row.add(rule: RuleRequired())
        row.validationOptions = .validatesOnChange
        row.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        return row
    }()
    let repoRow: TextRow = {
        let row = TextRow()
        row.title = "Repo name"
        row.placeholder = "Your team name"
        row.add(rule: RuleRequired())
        row.validationOptions = .validatesOnChange
        row.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        return row
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Team"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onTapCancel(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:
            #selector(onTapSave(_:)))
        form +++ Section("Info")
            <<< nameRow
            <<< githubRow
            <<< repoRow
    }

    @objc func onTapCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    @objc func onTapSave(_ sender: Any) {
        createTeam()
    }

    func createTeam() {
        guard nameRow.isValid && githubRow.isValid && repoRow.isValid else { return }
        guard let name = self.nameRow.value, !name.isEmpty else { return }
        guard let github = self.githubRow.value, !github.isEmpty else { return }
        guard let repo = self.repoRow.value, !repo.isEmpty else { return }
        let team = Team(name: name, github: github, repo: repo, scores: [RubricScore]())
        let info = ["team": team]
        let notificationName = NotificationKeys.team(create: true).name
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: info as [AnyHashable: Any])
        self.navigationController?.popViewController(animated: false)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
