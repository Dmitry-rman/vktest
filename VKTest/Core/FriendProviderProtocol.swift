//
//  VKDataProviderProtocol.swift
//  VKTest
//
//  Created by Dmitry Kudryavtsev on 25/07/2018.
//  Copyright © 2018 RMan. All rights reserved.
//

import Foundation

protocol FriendProviderProtocol {
    func getFriendInfo(id: NSNumber,
                       onSuccess completionBlock : @escaping (VKFriendData?)->(),
                       onFail failBlock : @escaping (NSError)->() -> Void)
    func prepare(completion: @escaping () -> Void, fail: @escaping (_ failMessage: NSString) -> Void)
    var friends: NSArray {get}
    func reloadFriendList() -> Void
}
