//
//  AllUsersViewController.swift
//  sampleProject
//
//  Created by Jainam Raval on 06/06/22.
//

import UIKit

class AllUsersViewController: UIViewController {

    var allUser = [user]()
    var collectionOfSwitches = [UISwitch]()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for Switch in collectionOfSwitches {
            Switch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        }
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    @objc func switchToggled(){
        for i in 0..<allUser.count{
            allUser[i].isPassed = collectionOfSwitches[i].isOn
        }
        addDataIntoPlist(allUser)
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
        let user = allUser[indexPath.row]
        cell.nameLabel.text = user.firstName + " " + user.lastName
        cell.dobLabel.text = "Date of birth: " + user.dateOfBirth
        cell.genderLabel.text = "Gender: " + user.gender
        cell.emailLabel.text = "Email id: " + user.email
        cell.hobbyLabel.text = "Hobby: " + user.hobby
        cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.isPassedSwitch.isOn = user.isPassed
        collectionOfSwitches.append(cell.isPassedSwitch)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
