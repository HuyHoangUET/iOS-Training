import UIKit
import RxSwift

let subject = BehaviorSubject(value: "0")

let disposeBag = DisposeBag()

enum MyError: Error {
  case anError
}
