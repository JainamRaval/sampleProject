//
//  CustomCell.swift
//  sampleProject
//
//  Created by Jainam Raval on 05/06/22.
//

import UIKit

class CustomCellForForm: UITableViewCell {
    
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField:UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setuplabel()
        setuptextfield()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setuplabel(){
        self.contentView.addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    func setuptextfield(){
        self.contentView.addSubview(textField)
        
        textField.leadingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
