//
//  AllUsersViewController.swift
//  sampleProject
//
//  Created by Jainam Raval on 06/06/22.
//

import UIKit

class AllUsersViewController: UIViewController {

    var allUser = [user]()
    
    let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        navigationItem.title = "SAVED USERS"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCellForAllUser.self, forCellReuseIdentifier: "allUsersCell")
        setupTableView()
        
        allUser = getDataFromPlist()
    }

    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    @objc func switchToggled(sender: UISwitch){
        allUser[sender.tag].isPassed = sender.isOn
        addDataIntoPlist(allUser)
    }
    
    func configurCell(cell: CustomCellForAllUser,row: Int){
        let user = allUser[row]
        cell.nameLabel.text = user.firstName + " " + user.lastName
        cell.dobLabel.text = "Date of birth: " + user.dateOfBirth
        cell.genderLabel.text = "Gender: " + user.gender
        cell.emailLabel.text = "Email id: " + user.email
        cell.hobbyLabel.text = "Hobby: " + user.hobby
        cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.isPassedSwitch.isOn = user.isPassed
        cell.isPassedSwitch.addTarget(self, action: #selector(switchToggled(sender:)), for: .valueChanged)
        cell.isPassedSwitch.tag = row
        cell.selectionStyle = .none
    }
}

extension AllUsersViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allUsersCell", for: indexPath) as? CustomCellForAllUser else{
            return UITableViewCell()
        }
        configurCell(cell: cell, row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
