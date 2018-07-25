//
//  VKDataProviderProtocol.swift
//  VKTest
//
//  Created by Dmitry Kudryavtsev on 25/07/2018.
//  Copyright © 2018 RMan. All rights reserved.
//

import Foundation

protocol FriendProviderProtocol {
    func getFriendInfo(id: NSNumber, success : (_ error: NSError) -> Void) -> Void
    func prepare(completion: () -> Void, fail: (_ failMessage: String) -> Void)
    var friends: NSArray {get}
    func reloadFriendList() -> Void
}
