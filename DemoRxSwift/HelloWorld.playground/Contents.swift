import UIKit
import RxSwift

let bag = DisposeBag()
 
let hello = Observable.from(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])

hello
 .subscribe(onNext: { value in
     print(value)
 }, onError: { error in
     print(error)
 }, onCompleted: {
     print("Completed")
 }) {
     print("Disposed")
 }
 .disposed(by: bag)

hello
    .reduce("", accumulator: +)
    .subscribe(onNext: { value in
        print(value)
    }, onError: { error in
        print(error)
    }, onCompleted: {
        print("Completed")
    }) {
        print("Disposed")
    }
    .disposed(by: bag)

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
        .takeWhile { $0 < 4 }
        .subscribe(onNext: { (value) in
            print(value)
        })
        .disposed(by: bag)

