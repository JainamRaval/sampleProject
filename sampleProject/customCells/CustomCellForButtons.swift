//
//  CustomCellForButtons.swift
//  sampleProject
//
//  Created by Jainam Raval on 05/06/22.
//

import UIKit

class CustomCellForButtons: UITableViewCell {
    
    let viewButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("VIEW", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        return button
    }()
    
    let submitButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        return button
    }()
    
    let usersButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("USERS", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewButton()
        setupSubmitButton()
        setupUserButton()
        
        submitButton.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        
        viewButton.addTarget(self, action: #selector(viewButtonTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        usersButton.addTarget(self, action: #selector(usersButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func viewButtonTapped(){
        let user = getDetailsOfUser()
        let vc = detailViewController()
        vc.userData = user
        navigationViewController.pushViewController(vc, animated: true)
    }
    
    @objc func submitButtonTapped(){
        let user = getDetailsOfUser()
        var allUsers = getDataFromPlist()
        allUsers.append(user)
        addDataIntoPlist(allUsers)
        let alert = UIAlertController(title: "Hello \(user.firstName)", message: "successfully submitted your details", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        navigationViewController.present(alert, animated: true, completion: {
            for cell in collectionOfCell{
                cell.textField.text = ""
            }
        })
    }
    
    @objc func usersButtonTapped(){
        navigationViewController.pushViewController(AllUsersViewController(), animated: true)
    }
    
    func setupViewButton(){
        self.addSubview(viewButton)
        
        viewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.28).isActive = true
    }
    
    func setupSubmitButton(){
        self.addSubview(submitButton)
        
        submitButton.leadingAnchor.constraint(equalTo: viewButton.trailingAnchor, constant: 20).isActive = true
        submitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupUserButton(){
        self.addSubview(usersButton)
        
        usersButton.leadingAnchor.constraint(equalTo: submitButton.trailingAnchor, constant: 20).isActive = true
        usersButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        usersButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        usersButton.widthAnchor.constraint(equalTo: viewButton.widthAnchor).isActive = true
    }
    
    func getDetailsOfUser() -> user{
        var details = [String]()
        for cell in collectionOfCell{
            details.append(cell.textField.text!)
        }
        var user = user()
        user.firstName = details[0]
        user.lastName = details[1]
        user.dateOfBirth = details[2]
        user.gender = details[3]
        user.email = details[4]
        user.hobby = details[5]
        return user
    }
    
}
