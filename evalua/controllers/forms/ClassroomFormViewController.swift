//
//  ClassroomFormViewController.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/1/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import UIKit
import Eureka

class ClassroomFormViewController: FormViewController {
    let nameRow: TextRow = {
        let row = TextRow()
        row.title = "Name"
        row.placeholder = "Your classroom name"
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
        title = "Create Classroom"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onTapCancel(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onTapSave(_:)))
        form +++ Section("Info")
            <<< nameRow
    }
    @objc func onTapSave(_ sender: Any) {
        createClassroom()
    }
    @objc func onTapCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    func createClassroom() {
        guard nameRow.isValid else { return }
        guard let name = self.nameRow.value, !name.isEmpty else { return }
        let classroom = Classroom(name: name)
        let info = ["classroom": classroom]
        let notificationName = NotificationKeys.classroom(create: true).name
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: info as [AnyHashable: Any])
        self.navigationController?.popViewController(animated: false)
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
