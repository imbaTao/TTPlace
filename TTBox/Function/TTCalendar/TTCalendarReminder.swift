//
//  TTCalendarReminder.swift
//  TTNew
//
//  Created by Mr.hong on 2021/10/15.
//

import EventKit
import EventKitUI
import Foundation

class TTCalendarReminder: NSObject {
    static let shared = TTCalendarReminder()
    var eventStore = EKEventStore()
    weak var presentVC: UIViewController?
    let completePublish = PublishSubject<Void>()

    // 创建日历
    func creatEventCalendar(
        title: String, content: String, notes: String, startDate: Date, endDate: Date? = nil,
        cacheIdentifer: String, presentVC: UIViewController? = nil,
        complete: @escaping (_ result: TTCalendarReminderResult) -> Void
    ) {
        if eventStore.responds(to: #selector(EKEventStore.requestAccess(to:completion:))) {
            eventStore.requestAccess(to: .event) { [weak self] (power, error) in
                guard let self = self else { return }
                self.presentVC = presentVC
                self.cacheIdentifer = cacheIdentifer
                DispatchQueue.main.async {
                    
                    guard power else {
                        // 没有权限
                        complete(.powerError)
                        return
                    }

                    guard error == nil else {
                        // 其他报错
                        complete(.otherError)
                        return
                    }

                    // 创建事件
                    let event = EKEvent.init(eventStore: self.eventStore)
                    event.title = title
                    event.notes = notes
                    event.startDate = startDate
                    event.location = content

                    if let endDate = endDate {
                        event.endDate = endDate
                    } else {
                        event.endDate = startDate.adding(.minute, value: 1)
                    }
                    event.isAllDay = false
                    
                    
                    //EKCalendar.init(for: .reminder, eventStore: self.eventStore)

                    // 添加闹钟
                    let elarm = EKAlarm.init(relativeOffset: 0)
                    event.addAlarm(elarm)
                    event.calendar =
                        self.eventStore.defaultCalendarForNewEvents ?? self.fetchCalendar()
                    if self.eventStore.defaultCalendarForNewEvents?.title != AppName ||
                        self.eventStore.defaultCalendarForNewEvents == nil {
                        
                        if let calendar = self.eventStore.calendars(for: .event)
                            .filter({ calendar in
                                calendar.title == AppName
                                
                            }).first {
                            event.calendar = calendar
                        }else {
                            event.calendar = self.fetchCalendar()
                        }
                        
                    }

                    // 调出控制器
                    if presentVC != nil {
                        let addController = EKEventEditViewController(nibName: nil, bundle: nil)
                        addController.event = event
                        addController.eventStore = self.eventStore
                        addController.editViewDelegate = self
                        presentVC!.present(addController, animated: true)

                        // 完成信号,代理那里传过来
                        self.completePublish.subscribe(onNext: { [weak self] (_) in
                            guard let self = self else { return }
                            complete(.succuess)
                        }).disposed(by: event.rx.disposeBag)
                    } else {

                        var safeError: Error?
                        // 直接尝试添加事件
                        
                        do {
                            try self.eventStore.save(event, span: .thisEvent, commit: true)
                        } catch let catchError {
                            // 保存过程中报错了
                            complete(.saveError)
                            safeError = catchError
                        }

                        if safeError == nil {
                            self.saveEvent(event: event, cacheIdentifer: cacheIdentifer)
                            complete(.succuess)
                        }
                    }
                }
            }
        }
    }
    
    func updateRemind(
        title: String, content: String, notes: String, startDate: Date, endDate: Date? = nil,
        cacheIdentifer: String, presentVC: UIViewController? = nil,
        complete: @escaping (_ result: TTCalendarReminderResult) -> Void
    ) {
        guard checkEventIsExist(cacheIdentifer: cacheIdentifer) else {
            complete(.otherError)
            return
        }

        guard let eventIdentifer = UserDefaults.standard.object(forKey: cacheIdentifer) as? String
        else {
            complete(.otherError)
            return
        }

        guard let event = eventStore.event(withIdentifier: eventIdentifer) else {
            complete(.otherError)
            return
        }

        DispatchQueue.main.async(execute: { [self] in
            var catchErr: Error? = nil

            event.title = title
            event.notes = notes
            event.startDate = startDate
            if let endDate = endDate {
                event.endDate = endDate
            } else {
                event.endDate = startDate.adding(.minute, value: 1)
            }
            event.location = content
            event.isAllDay = false

            // 调出控制器
            if presentVC != nil {
                let addController = EKEventEditViewController(nibName: nil, bundle: nil)
                addController.event = event
                addController.eventStore = self.eventStore
                addController.editViewDelegate = self
                presentVC!.present(addController, animated: true)
                // 完成信号,代理那里传过来
                self.completePublish.subscribe(onNext: { [weak self] (_) in
                    guard let self = self else { return }
                    complete(.succuess)
                }).disposed(by: event.rx.disposeBag)
            } else {
                do {
                    try self.eventStore.save(event, span: .thisEvent, commit: true)
                } catch let err {
                    catchErr = err
                }

                if catchErr == nil {
                    UserDefaults.standard.removeObject(forKey: cacheIdentifer)
                    UserDefaults.standard.synchronize()
                    complete(.succuess)
                } else {
                    complete(.otherError)
                }
            }
        })
    }

    // 移除结果
    func removeRemind(cacheIdentifer: String, complete: @escaping (_ result: Bool) -> Void) {
        guard checkEventIsExist(cacheIdentifer: cacheIdentifer) else {
            complete(false)
            return
        }

        guard let eventIdentifer = UserDefaults.standard.object(forKey: cacheIdentifer) as? String
        else {
            return
        }

        let event = eventStore.event(withIdentifier: eventIdentifer)
        DispatchQueue.main.async(execute: { [self] in
            var catchErr: Error? = nil
            do {
                if let event = event {
                    try self.eventStore.remove(event, span: .thisEvent, commit: true)
                }
            } catch let err {
                catchErr = err
            }

            if catchErr == nil {
                UserDefaults.standard.removeObject(forKey: cacheIdentifer)
                UserDefaults.standard.synchronize()
                complete(true)
            } else {
                complete(false)
            }
        })
    }

    // mark 检查事件是否存在
    func checkEventIsExist(cacheIdentifer: String) -> Bool {
        if let eventStr = UserDefaults.standard.object(forKey: cacheIdentifer) as? String,
            eventStr.count > 0
        {
            return true
        } else {
            return false
        }
    }

    // 根据标识符保存到本地
    var cacheIdentifer = ""
    @objc private func saveEvent(event: EKEvent, cacheIdentifer: String) {
        // 添加成功
        let eventIdentifier = event.eventIdentifier

        // 保存到偏好设置
        UserDefaults.standard.setValue(eventIdentifier, forKey: cacheIdentifer)
        UserDefaults.standard.synchronize()

        completePublish.onNext(())
    }

    func fetchCalendar() -> EKCalendar {
        var calendar: EKCalendar!
        var needAdd = true

        for ekCalendar in eventStore.calendars(for: .event) {
            if ekCalendar.title == "My Calendar Q" {
                needAdd = false
                calendar = ekCalendar
            }
        }

        if needAdd {
            var localSource: EKSource?

            // iCloud是否存在
            for source in eventStore.sources {
                if source.sourceType == .calDAV, source.title == "iCloud" {
                    localSource = source
                    break
                }
            }

            // 本地是否存在
            if localSource == nil {
                for source in eventStore.sources {
                    if source.sourceType == .local {
                        localSource = source
                        break
                    }
                }
            }

            if let _ = localSource {
                calendar = EKCalendar.init(for: .event, eventStore: eventStore)
                calendar.source = localSource
                calendar.title = AppName
                //                var error: Error?
                do {
                    try eventStore.saveCalendar(calendar, commit: true)
                } catch _ {

                }

            }
        }

        return calendar
    }
}

extension TTCalendarReminder: EKEventEditViewDelegate {

    func eventEditViewController(
        _ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction
    ) {
        if action == .canceled {
            // 取消编辑不做任何操作
        }

        if action == .saved, let event = controller.event {
            saveEvent(event: event, cacheIdentifer: cacheIdentifer)
        }

        controller.dismiss(animated: true, completion: nil)
    }

    //    func eventEditViewControllerDefaultCalendar(forNewEvents controller: EKEventEditViewController) -> EKCalendar {
    //        return eventStore.defaultCalendarForNewEvents ?? .init(for: .event, eventStore: eventStore)
    //    }
    //

}

enum TTCalendarReminderResult: Int {
    case powerError  // 权限报错
    case otherError  // 其他报错
    case saveError  // 保存报错
    case succuess  // 成功
}
