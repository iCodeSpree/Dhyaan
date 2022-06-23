//
//  StatsViewController.swift
//  Dhyaan
//
//  Created by Shreya Zala on 6/22/22.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var statsBtn: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalMinutesLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
        totalMinutesLblConfig()
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: "StatsTableViewCell")
    }
    
    func tabBarConfig() {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        //tabBar.barTintColor = .black
        tabBar.tintColor = #colorLiteral(red: 0.6857369542, green: 0.8708372712, blue: 0.2421270013, alpha: 1)
        tableView.dataSource = self
    }
    
    func totalMinutesLblConfig() {
        totalMinutesLbl.layer.borderColor = #colorLiteral(red: 0.6857369542, green: 0.8708372712, blue: 0.2421270013, alpha: 1)
        totalMinutesLbl.layer.borderWidth = 1
        totalMinutesLbl.layer.cornerRadius = 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath)
        return cell
    }

}
