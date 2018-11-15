//
//  SettingsSplitViewController.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/14/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import UIKit

class SettingsSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
