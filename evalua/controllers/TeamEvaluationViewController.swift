//
//  TeamEvaluationViewController.swift
//  evalua
//
//  Created by Luis Ezcurdia on 11/8/18.
//  Copyright © 2018 iOSLab FI-UNAM. All rights reserved.
//

import UIKit
import SafariServices

class TeamEvaluationViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var teamLbl: UILabel!

    var team: Team?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTeamDetails()
    }

    func updateTeamDetails() {
        guard let team = self.team else { return }
        teamLbl.text = team.name
        team.githubImage { [weak self] img in
            self?.imageView.image = img
        }
    }

    @IBAction func didTapOnRepoUrl(_ sender: UIButton) {
        guard let team = self.team, let url = team.repoUrl else { return }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true, completion: nil)
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
