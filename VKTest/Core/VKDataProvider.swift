//
//  VKDataProvider.swift
//  VKTest
//
//  Created by Dmitry Kudryavtsev on 25/07/2018.
//  Copyright © 2018 RMan. All rights reserved.
//

import Foundation
import VK_ios_sdk

let VK_APP_ID: NSString = "6631966"
let vkFriendFields: NSString = "id,first_name,last_name,city,country,photo_100,online,online_mobile,lists,contacts,connections,status,last_seen,common_count,relation,relatives,counters,sex"

@objc public class VKDataProvider: NSObject, FriendProviderProtocol, VKSdkDelegate {
    
    var _vkPrepareSuccessHandler: (()->Void)?
    var _vkPrepareFailHandler: ((_ failMessage: NSString)->Void)?
    var _friends: NSMutableArray
    var _vkSDK: VKSdk
    
    override init() {
        _friends = NSMutableArray()
        _vkSDK = VKSdk.initialize(withAppId:  VK_APP_ID as String?)

        super.init()
        _vkSDK.register(self)
    }
    
    func friendData(fromUser vkuser: VKUser) -> VKFriendData{
        var stats: NSMutableDictionary = NSMutableDictionary()
        if(vkuser.counters.friends != nil){
            stats.setObject(vkuser.counters.friends.stringValue,
                            forKey: NSLocalizedString("друзей", comment: "") as NSCopying)
        }
        if(vkuser.counters.mutual_friends != nil){
            stats.setObject(vkuser.counters.mutual_friends.stringValue,
                            forKey: NSLocalizedString("общих", comment: "") as NSCopying)
        }
        if(vkuser.counters.followers != nil){
            stats.setObject(vkuser.counters.followers.stringValue,
                            forKey: NSLocalizedString("подписчика", comment: "") as NSCopying)
        }
        if(vkuser.counters.user_photos != nil){
            stats.setObject(vkuser.counters.user_photos.stringValue,
                            forKey: NSLocalizedString("фото", comment: "") as NSCopying)
        }
        if(vkuser.counters.audios != nil){
            stats.setObject(vkuser.counters.audios.stringValue,
                            forKey: NSLocalizedString("аудио", comment: "") as NSCopying)
        }
        if(vkuser.counters.videos != nil){
            stats.setObject(vkuser.counters.videos.stringValue,
                            forKey: NSLocalizedString("видео", comment: "") as NSCopying)
        }
        
        
        let username = vkuser.first_name +
            (vkuser.last_name != nil ? " " : "") +
            (vkuser.last_name != nil ? vkuser.last_name : "")
        
        let infoData = VKFriendData.init(name: username,
                                         userID: vkuser.id.stringValue,
                                         isOnline: vkuser.online.boolValue,
                                         sex:  UserSex(rawValue: vkuser.sex!.intValue)!,
                                         vizited: vkuser.last_seen.time,
                                         info: vkuser.city.title,
                                         photoURLString: vkuser.photo_100,
                                         counters: stats,
                                         isYourFriend: true)
        return infoData
    }
    
    //MARK: FriendProviderProtocol
    
    public func getFriendInfo(id: NSNumber,
                       onSuccess completionBlock : @escaping (VKFriendData?)->(),
                       onFail failBlock : @escaping (_ error: NSError)->() -> Void){
        VKApi.users().get([ VK_API_FIELDS : vkFriendFields,
                            VK_API_USER_IDS: id.stringValue]).execute(resultBlock: { (response: VKResponse?) in
                                let user: VKUser? = (response?.parsedModel as! VKUsersArray?)!.firstObject()
                                var infoData: VKFriendData? = nil
                                if(user != nil){
                                    infoData = self.friendData(fromUser: user!)
                                }
                                completionBlock(infoData)
                            },
                                                                      errorBlock: { (error: NSError?) in
                                                                        failBlock(error! as NSError)()
                                                                        } as! (Error?) -> Void)
    }
    

    public func prepare(completion: @escaping () -> Void, fail: @escaping (_ failMessage: NSString) -> Void){
        let scope = [VK_PER_FRIENDS, VK_PER_STATUS]
        weak var weakself = self
        VKSdk.wakeUpSession(scope) { (state: VKAuthorizationState, error: Error?) in
            
            if(state == VKAuthorizationState.initialized){
                weakself?._vkPrepareSuccessHandler = completion
                weakself?._vkPrepareFailHandler = fail
            }
            else if (state == VKAuthorizationState.authorized){
                completion()
            }
            else{
                fail(NSLocalizedString("Error on VK authorization, Please, try later.", comment: "") as NSString)
            }
        }
    }
    
    public var friends: NSArray {
        get{
            return _friends
        }
    }
    
    public func reloadFriendList() -> Void{
        weak var weakself = self
        VKApi.friends().get([ VK_API_FIELDS : vkFriendFields]).execute(resultBlock: { (response: VKResponse?) in
            weakself?._friends.removeAllObjects()
            let array: VKUsersArray = response?.parsedModel as! VKUsersArray
            for i in 0..<array.count{
                let vkuser: VKUser = array[i]
                let infoData = weakself?.friendData(fromUser:  vkuser)
                self._friends.add(infoData as Any)
            }
            
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: kDataProviderChangedFriendsListNotification) , object: nil)
        },
                                                                       errorBlock: { (error: NSError?) in
                                                                        
                                                                        } as! (Error?) -> Void)
    }

    //MARK: VKSdkDelegate
    public func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if(result.token != nil){
            if(_vkPrepareSuccessHandler != nil){
                _vkPrepareSuccessHandler!()
            }
        }
        else if (result.error != nil){
            if(_vkPrepareFailHandler != nil){
                _vkPrepareFailHandler!(result.error.localizedDescription as NSString)
            }
        }
        
        self.clean()
    }
    
    public func vkSdkUserAuthorizationFailed() {
        if(_vkPrepareFailHandler != nil){
            _vkPrepareFailHandler!(NSLocalizedString("VK authorization error.", comment: "") as NSString)
        }
        self.clean()
    }
    
    //MARK: -
    func clean(){
        _vkPrepareSuccessHandler = nil
        _vkPrepareFailHandler = nil
    }
    
    deinit {
        self.clean()
    }
}
