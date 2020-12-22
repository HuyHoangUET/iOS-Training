//
//  DidLikeImage.swift
//  HitsManager
//
//  Created by LTT on 17/11/2020.
//

import Foundation
import RealmSwift

class DidLikeHit: Object {
    @objc dynamic var id = 0
    @objc dynamic var url = ""
    @objc dynamic var imageWidth: Float = 0
    @objc dynamic var imageHeight: Float = 0
    @objc dynamic var userImageUrl = ""
    @objc dynamic var username = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func addAnObject(id: Int, url: String, imageWidth: Float, imageHeight: Float, userImageUrl: String, username: String) {
        do {
            let realm = try Realm()
            let didLikeImage = DidLikeHit()
            didLikeImage.id = id
            didLikeImage.url = url
            didLikeImage.imageWidth = imageWidth
            didLikeImage.imageHeight = imageHeight
            didLikeImage.userImageUrl = userImageUrl
            didLikeImage.username = username
            try realm.write {
                realm.add(didLikeImage)
            }
        } catch {
            print("Add new object fail.")
        }
    }
    
    static func deleteAnObject(id: Int) {
        do {
            let realm = try Realm()
            guard let didLikeImage = realm.object(ofType: self, forPrimaryKey: id) else { return }
            
            try realm.write {
                realm.delete(didLikeImage)
            }
        } catch {
            print("Delete object fail.")
        }
    }
    
    static func deleteAll() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(self))
            }
        } catch {
            print("")
        }
    }
    
    static func getListId() -> Set<Int> {
        do {
            let realm = try Realm()
            let results = realm.objects(self)
            let didLikeHits = Array(results)
            var listDidLikeImageId: Set<Int> = []
            for didLikeImage in didLikeHits {
                let imageId = didLikeImage.id
                listDidLikeImageId.insert(imageId)
            }
            return listDidLikeImageId
        } catch {
            return []
        }
    }
    
    static func getListDidLikeHit() -> [DidLikeHit] {
        do {
            let realm = try Realm()
            let results = realm.objects(self)
            let didLikeHits = Array(results)
            return didLikeHits
        } catch {
            return []
        }
    }
}
