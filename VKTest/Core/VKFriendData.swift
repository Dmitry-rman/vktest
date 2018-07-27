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


@objc public class VKFriendData: NSObject {
    
    public var userID: String
    public var isOnline: Bool
    public var name: String
    public var vizitText: String
    public var infoText: String
    public var photoImageURL: URL
    public var isYourFriend: Bool
    public var statCounters: NSDictionary
    
    init(name: String,
                     userID: String,
                     isOnline: Bool,
                     sex: UserSex,
                     vizited: NSNumber?,
                     info: String,
                     photoURLString: String,
                     counters: NSDictionary,
                     isYourFriend: Bool) {
        self.userID = userID
        self.name = name
        self.isOnline = isOnline
        self.infoText = info
        self.isYourFriend = isYourFriend
        self.photoImageURL = URL.init(string:  photoURLString)!
        if(vizited != nil){
            let vizitDate = Date.init(timeIntervalSince1970:  vizited!.doubleValue)
            self.vizitText = NSLocalizedString("заходил", comment: "") + (sex == UserSex.woman ? "а" : "") + " " + NSDate.string(from: vizitDate)
        }
        else{
            self.vizitText = ""
        }
        self.statCounters = counters
    }
    
}
