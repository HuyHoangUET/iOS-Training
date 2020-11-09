//
//  ViewModel.swift
//  HitsManager
//
//  Created by LTT on 11/6/20.
//

import Foundation
import UIKit

class ViewModel {
    private let dataManager = DataManager()
    var results = [Result]()
    private var hits = [Hit]()
    func getHitsFromApi(url: String, completion: @escaping ([Hit]) -> ()) {
        var hits = [Hit]()
            dataManager.get(url: url) { (data) in
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                hits = result.hits
                completion(hits)
            } catch {
                print("get hits failed!")
            }
        }
    }
    
    func getResults(page: Int, url: String) {
        var curantPage = page
        dataManager.get(url: url + "&page=\(curantPage)") { (data) in
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                print("got result from page \(curantPage)")
                print(result)
                self.results.append(result)
                print(self.results.count)
                if curantPage < 15 {
                    curantPage += 1
                    self.getResults(page: curantPage, url: url)
                }
            } catch {
                print("get result fail!")
            }
        }
    }
    
    func getHitsInPage(page: Int, url: String, completion: @escaping ([Hit]) -> ()) {
        var hits = [Hit]()
            dataManager.get(url: url + "&page=\(page)") { (data) in
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    hits = result.hits
                    completion(hits)
                } catch {
                    print("get hits failed!")
                }
            }
    }
}
