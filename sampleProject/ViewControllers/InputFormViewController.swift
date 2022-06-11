//
//  ViewController.swift
//  sampleProject
//  Created by Jainam Raval on 05/06/22.

import UIKit


class InputFormViewController: UIViewController {

    let inputTitle:[String] = ["First Name:","Last Name:","Date of birth:","Gender:","Email id:","Hobbies:"]
    
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ENTER THE USER DETAILS"
        return label
    }()
    
    let tableView:UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.rowHeight = 70
        return tableview
    }()
    
    
    //it's good practice to remove all the observers while deinitialization
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForPlist()
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        //inserting gesture onto view to help us with dismissing keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hidekeyboard))
        view.addGestureRecognizer(tap)
        
        //adjustment of tableview, when keyboard comes
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTableView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustTableView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //customizing navigation bar
        navigationItem.title = "FORM"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemFill
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCellForForm.self, forCellReuseIdentifier: "formCell")
        tableView.register(CustomCellForButtons.self, forCellReuseIdentifier: "buttonCell")
        
        setupLabel()
        setupTableView()
    }
    
    //checks for plist, if plist does not exist then this function just creates it and adds default information of myself
    func checkForPlist(){
        if !FileManager.default.fileExists(atPath: fileurl.path){
            FileManager.default.createFile(atPath: fileurl.path, contents: nil, attributes: nil)
            let user = user(firstName: "Jainam", lastName: "Raval", dateOfBirth: "24/01/2001", gender: "male", email: "jainamraval2001@gmail.com", hobby: "love to code", isPassed: false)
            addDataIntoPlist([user])
        }
    }
    
    func setupLabel(){
        view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    @objc func hidekeyboard(){
        view.endEditing(true)
    }
    
    
    //adjusts table view, when keyboard shows notification and when keyboard hides notification
    @objc func adjustTableView(notification: Notification){
        if notification.name == UIResponder.keyboardWillShowNotification{
            guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            tableView.contentInset.bottom = keyboardScreenEndFrame.height
        }
        else{
            tableView.contentInset.bottom = .zero
        }
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}

extension InputFormViewController: UITableViewDataSource,UITableViewDelegate {
    
    //returns number of rows in one section of table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputTitle.count + 1
    }
    
    //returns custom table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == inputTitle.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? CustomCellForButtons else{
                return UITableViewCell()
            }
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "formCell", for: indexPath) as? CustomCellForForm else{
            return UITableViewCell()
        }
        cell.label.text = inputTitle[indexPath.row]
        if inputTitle[indexPath.row] == "Date of birth:"{
            cell.textField.placeholder = "dd/mm/yyyy"
        }
        else if inputTitle[indexPath.row] == "Gender"{
            cell.textField.placeholder = "male/female/other"
        }
        else{
            cell.textField.placeholder = "Enter your \(inputTitle[indexPath.row].prefix(inputTitle[indexPath.row].count - 1))"
        }
        cell.selectionStyle = .none
        collectionOfCell.append(cell)
        return cell
    }
    
}
