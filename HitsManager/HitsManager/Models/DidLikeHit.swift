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
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func addAnObject(id: Int, url: String) {
        do {
            let realm = try Realm()
            let didLikeImage = DidLikeHit()
            didLikeImage.id = id
            didLikeImage.url = url
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
            let didLikeImageArray = Array(results)
            var listDidLikeImageId: Set<Int> = []
            for didLikeImage in didLikeImageArray {
                let imageId = didLikeImage.id
                listDidLikeImageId.insert(imageId)
            }
            return listDidLikeImageId
        } catch {
            return []
        }
    }
    
    static func getListUrl() -> [String] {
        do {
            let realm = try Realm()
            let results = realm.objects(self)
            let didLikeImageArray = Array(results)
            var listUrl: [String] = []
            for didLikeImage in didLikeImageArray {
                let url = didLikeImage.url
                listUrl.append(url)
            }
            return listUrl
        } catch {
            return []
        }
    }
}
