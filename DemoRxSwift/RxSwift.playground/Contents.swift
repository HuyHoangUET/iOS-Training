import UIKit
import RxSwift

let bag = DisposeBag()
Observable<String>.create { observer -> Disposable in
    observer.onNext("1")
    
    observer.onNext("2")
    
    observer.onNext("3")
    
    observer.onNext("4")
    
    observer.onNext("5")
    
    observer.onCompleted()
    
    observer.onNext("6")
    
    return Disposables.create()
}.subscribe(
        onNext: { print($0) },
        onError: { print($0) },
        onCompleted: { print("Completed") },
        onDisposed: { print("Disposed") }
    ).disposed(by: bag)
let subject = PublishSubject<String>()

subject.onNext("Chào bạn")

let subscription1 = subject
    .subscribe(onNext: { value in
        print(value)
    })

subject.onNext("Chào bạn lần nữa")
subject.onNext("Chào bạn lần thứ 3")
subject.onNext("Mình đứng đây từ chiều")
