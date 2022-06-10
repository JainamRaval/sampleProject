//
//  structureOfUserViewController.swift
//  sampleProject
//
//  Created by Jainam Raval on 05/06/22.
//


// Here i have defined all the global properties.

import UIKit

var navigationViewController:UINavigationController!

var collectionOfCell = [CustomCellForForm]()

var safeArea:UILayoutGuide!

let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let fileurl = url.appendingPathComponent("allUsersDetails.plist")

func getDataFromPlist() -> [user] {
    print(url)
    guard let data = try? Data(contentsOf: fileurl) else{
        print("failed to get data from plist")
        return []
    }
    let decoder = PropertyListDecoder()
    guard let allUser = try? decoder.decode([user].self, from: data) else{
        print("failed to decode the data")
        return []
    }
    return allUser
}

func addDataIntoPlist(_ allUsers:[user]){
    let encoder = PropertyListEncoder()
    guard let encodedData = try? encoder.encode(allUsers) else{
        print("failed to encode the data")
        return
    }
    do{
        try encodedData.write(to: fileurl)
    }catch {
        print("failed to write data in plist file")
        print("error is: \(error.localizedDescription)")
    }
}


struct user:Codable {
    var firstName:String = ""
    var lastName:String = ""
    var dateOfBirth:String = ""
    var gender:String = ""
    var email:String = ""
    var hobby:String = ""
    var isPassed:Bool = false
}
