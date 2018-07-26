//
//  VKFriendData.swift
//  VKTest
//
//  Created by Dmitry Kudryavtsev on 25/07/2018.
//  Copyright © 2018 RMan. All rights reserved.
//

import Foundation

enum UserSex: Int {
    case  unknowm = 0
    case man = 1
    case woman = 2
}


class VKFriendData: NSObject {
    
    var userID: String
    var isOnline: Bool
    var name: String
    var vizitText: String
    var infoText: String
    var photoImageURL: URL
    var isYourFriend: Bool
    var statCounters: NSDictionary
    
    init(name: String,
                     userID: String,
                     isOnline: Bool,
                     sex: UserSex,
                     vizited: NSNumber,
                     info: String,
                     photoURLString: String,
                     counters: NSDictionary,
                     isYourFriend: Bool) {
        self.userID = userID
        self.name = name
        self.isOnline = isOnline
        self.infoText = info
        self.isYourFriend = isYourFriend
        self.photoImageURL = URL.init(fileURLWithPath:  photoURLString)
        let vizitDate = Date.init(timeIntervalSince1970:  vizited.doubleValue)
        self.vizitText = NSLocalizedString("заходил", comment: "") + (sex == UserSex.woman ? "а" : "") + ""//vizitDate.string
        self.statCounters = counters
    }
    
}
