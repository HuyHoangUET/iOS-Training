//
//  ViewController.swift
//  SimpleNetworking
//
//  Created by LTT on 10/30/20.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    var hits = [Hit]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let apiUrl = URL(string: "https://pixabay.com/api/?key=13112092-54e8286568142add194090167&q=girl") else {
            return
        }
        
        AF.request(apiUrl).responseJSON {
            responds in
            guard let result = responds.data else {return}
            print(String(data: result, encoding: .utf8)!)
            do {
                let result = try JSONDecoder().decode(Result.self, from: result)
                self.hits = result.hits
                print(self.hits)
            } catch let error as Error {
                print(error.localizedDescription)
            }
        }
    }
}

