//
//  DidLikeImage.swift
//  HitsManager
//
//  Created by LTT on 17/11/2020.
//

import Foundation
import RealmSwift

class DidLikeImage: Object {
    @objc dynamic var id = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func addAnObject(id: Int) {
        do {
            let realm = try Realm()
            let didLikeImage = DidLikeImage()
            didLikeImage.id = id
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
            try realm.write {
                realm.delete(realm.objects(self).filter("id=%@", id))
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
    
    static func getListId(completion: @escaping ((Set<Int>) -> ())) {
        do {
            let realm = try Realm()
            let results = realm.objects(self)
            let didLikeImageArray = Array(results)
            var listDidLikeImageId: Set<Int> = []
            for didLikeImage in didLikeImageArray {
                let imageId = didLikeImage.id
                listDidLikeImageId.insert(imageId)
            }
            completion(listDidLikeImageId)
        } catch {
            print("")
        }
    }
}
