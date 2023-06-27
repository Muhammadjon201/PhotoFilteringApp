import UIKit
import RxSwift

//let observable4 = Observable.from([1,2,3,4,5])
//
//observable4.subscribe { event in
//    //print(event)
//    if let element = event.element {
//        print(element)
//    }
//}

                                // IndexAt operator

/*
let strikes = PublishSubject<String>()

let disposeBag = DisposeBag()

strikes.element(at: 2)
    .subscribe(onNext: { _ in
        print("You are out!")
    }).disposed(by: disposeBag)

strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("Z")
*/

                                // Filter operator
/*
let disposeBag = DisposeBag()

Observable.of(1,2,3,4,5,6,7)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: diposeBag)
*/

                                // Skip operator

/*
let diposeBag = DisposeBag()

Observable.of(1,2,3,4,5,6,7,8)
    .skip(4)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: diposeBag)
// prints: 5,6,7,8

 */

                                // SkipWhile

/*
let disposeBag = DisposeBag()

Observable.of(2,2,3,4,4)
    .skip(while: { $0 % 2 == 0 })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

// prints: 3,4,5

*/

                                // SkipUntill

/*
 let disposeBag = DisposeBag()
 
 let subject = PublishSubject<Int>()
 let trigger = PublishSubject<Int>()
 
 subject.skip(until: trigger)
 .subscribe(onNext: { val in
 print(val)
 }).disposed(by: disposeBag)
 
 subject.onNext(3)
 subject.onNext(5)
 subject.onNext(7)
 subject.onNext(9)
 subject.onNext(10)
 
 trigger.onNext(12)
 
 subject.onNext(44)
 subject.onNext(50)
 
        prints only values after trigger..
 */


                                // Take()

/*
let disposeBag = DisposeBag()

Observable.of(1,2,3,4,5,6,7)
    .take(4)
    .subscribe(onNext: { value in
        print(value)
    }).disposed(by: disposeBag)

 prints: depend on value that take() operator holds
 
*/

                                // TakeUntil()

/*
let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.take(until: trigger)
.subscribe(onNext: { val in
print(val)
}).disposed(by: disposeBag)

subject.onNext(3)
subject.onNext(5)
subject.onNext(7)
subject.onNext(9)
subject.onNext(10)

trigger.onNext(12)

subject.onNext(44)
subject.onNext(50)

// prints: 3,5,7,9,10
only values before trigger

*/
