//
//  APIManager.swift
//  Instagram
//
//  Created by LTT on 22/12/2020.
//

import Foundation
import RxSwift
import RxCocoa

let url = "https://pixabay.com/api/?key=13112092-54e8286568142add194090167&q=girl"

class APIManager {
    private let bag = DisposeBag()
    func getHit(url: String, completion: @escaping ([Hit]) -> Void) {
        let response = Observable<String>.of(url)
            .map { urlString -> URL in
                return URL(string: urlString)!
            }
            .map { url -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .share(replay: 1)
        response
            .filter { response, _ -> Bool in
            return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [Hit] in
                let decoder = JSONDecoder()
                let result = try? decoder.decode(HitResult.self, from: data)
                return result!.hits
            }
            .filter { objects in
                return !objects.isEmpty
            }
            .subscribe(onNext: { hits in
                completion(hits)
            })
            .disposed(by: bag)
    }
}
