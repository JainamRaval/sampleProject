//
//  detailViewController.swift
//  sampleProject
//
//  Created by Jainam Raval on 05/06/22.
//

import UIKit

class detailViewController: UIViewController {
    
    var userData:user!
    
    let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        //customizing navigation bar
        navigationItem.title = "Details of \(userData.firstName)"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCellForDetail.self, forCellReuseIdentifier: "detailCell")
        
        setupTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
}

extension detailViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? CustomCellForDetail else{
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.labelForTitle.text = "First Name:"
            cell.labelForDetail.text = userData.firstName
        case 1:
            cell.labelForTitle.text = "Last Name:"
            cell.labelForDetail.text = userData.lastName
        case 2:
            cell.labelForTitle.text = "Date of birth:"
            cell.labelForDetail.text = userData.dateOfBirth
        case 3:
            cell.labelForTitle.text = "Gender:"
            cell.labelForDetail.text = userData.gender
        case 4:
            cell.labelForTitle.text = "Email id:"
            cell.labelForDetail.text = userData.email
        case 5:
            cell.labelForTitle.text = "Hobbies:"
            cell.labelForDetail.text = userData.hobby
        default:
            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
