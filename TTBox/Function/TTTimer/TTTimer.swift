//
//  TTTimer.swift
//  EatWhat
//
//  Created by Mr.hong on 2021/5/31.
//

import Foundation
import RxSwift

class TTTimer: NSObject {
    static let shared = TTTimer()
    lazy var oneSecondsTimer: Observable<Int> = {
        let oneSecondsTimer = Observable<Int>.timer(
            RxTimeInterval.seconds(0), period: RxTimeInterval.seconds(1),
            scheduler: MainScheduler.instance)
        return oneSecondsTimer.share()
    }()

    lazy var displayTimer: PublishSubject<()> = {
        var displayTimer = PublishSubject<()>.init()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.startDisplayTimer()
        }
        return displayTimer
    }()

    private lazy var displayLink: CADisplayLink = {
        let displayTimer: CADisplayLink = CADisplayLink(
            target: self, selector: #selector(displayTimerAction))
        //        displayTimer.preferredFramesPerSecond = 1
        displayTimer.add(to: .current, forMode: .common)
        return displayTimer
    }()

    private func startDisplayTimer() {
        self.displayLink.isPaused = false
    }

    @objc private func displayTimerAction() {
        self.displayTimer.onNext(())
    }

    // 自定义timer
    var customTimer: Observable<Int>!
    func creatCustomTimer(milliseconds: Int) -> Observable<Int> {
        customTimer = Observable<Int>.timer(
            RxTimeInterval.seconds(0), period: RxTimeInterval.milliseconds(milliseconds),
            scheduler: MainScheduler.instance)
        return customTimer
    }

}
