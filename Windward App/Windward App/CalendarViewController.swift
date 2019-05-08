//
//  CalendarViewController.swift
//  Windward App
//
//  Created by Jai on 5/7/19.
//  Copyright © 2019 Windward. All rights reserved.
//

import UIKit
import CalendarKit
import DateToolsSwift

enum SelectedStyle {
    case Dark
    case Light
}

struct ClassEvent {
    var title: String
    var date: Date
    var period: TimePeriod
}

class CalendarViewController: DayViewController, DatePickerControllerDelegate {
    
    var testData : [ClassEvent] = []
    
    var colors = [UIColor.blue, UIColor.yellow, UIColor.green, UIColor.red]
    
    var currentStyle = SelectedStyle.Dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load fake data
        testData.append(ClassEvent(title: "HEY MAN", date: Date(), period: TimePeriod(beginning: Date(), chunk: TimeChunk(seconds: 0, minutes: 10, hours: 1, days: 0, weeks: 0, months: 0, years: 0))))
        
        title = "Windward School"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dark", style: .done, target: self, action: #selector(CalendarViewController.changeStyle))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Change Date", style: .plain, target: self, action: #selector(CalendarViewController.presentDatePicker))
        navigationController?.navigationBar.isTranslucent = false
        dayView.autoScrollToFirstEvent = true
        
        reloadData()
    }
    
    @objc func changeStyle() {
        var title: String!
        var style: CalendarStyle!
        
        if currentStyle == .Dark {
            currentStyle = .Light
            title = "Dark"
            style = StyleGenerator.defaultStyle()
        } else {
            title = "Light"
            style = StyleGenerator.darkStyle()
            currentStyle = .Dark
        }
        
        updateStyle(style)
        
        navigationItem.rightBarButtonItem!.title = title
        navigationController?.navigationBar.barTintColor = style.header.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:style.header.swipeLabel.textColor]
        
        reloadData()
    }
    
    func replacePeriodCustom(period: Int) -> String {
        let periodName = "period" + "\(period)"
        let name = UserDefaults.standard.string(forKey: periodName)
        return name!
    }
    
    @objc func presentDatePicker() {
        let picker = DatePickerController()
        picker.date = dayView.state!.selectedDate
        picker.delegate = self
        let navC = UINavigationController(rootViewController: picker)
        navigationController?.present(navC, animated: true, completion: nil)
    }
    
    func datePicker(controller: DatePickerController, didSelect date: Date?) {
        if let date = date {
            dayView.state?.move(to: date)
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: EventDataSource
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {

        var events = [Event]()
        
        for i in 0..<testData.count {
            let event = Event()

            let datePeriod = testData[i].period
            event.startDate = datePeriod.beginning!
            event.endDate = datePeriod.end!

            var info = [testData[i].title]

            let timezone = TimeZone.ReferenceType.default
            info.append(datePeriod.beginning!.format(with: "dd.MM.YYYY", timeZone: timezone))
            info.append("\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))")
            event.text = info.reduce("", {$0 + $1 + "\n"})
            event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]

            if currentStyle == .Dark {
                event.textColor = textColorForEventInDarkTheme(baseColor: event.color)
                event.backgroundColor = event.color.withAlphaComponent(0.6)
            }
            
            events.append(event)
            event.userInfo = String(i)
        }
        
        return events
    }
    
    private func textColorForEventInDarkTheme(baseColor: UIColor) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        baseColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s * 0.3, brightness: b, alpha: a)
    }
    
    // MARK: DayViewDelegate
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
    
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        
        let alert = UIAlertController(title: "", message: descriptor.text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
    }
    
    override func dayView(dayView: DayView, willMoveTo date: Date) {
        print("DayView = \(dayView) will move to: \(date)")
    }
    
    override func dayView(dayView: DayView, didMoveTo date: Date) {
        print("DayView = \(dayView) did move to: \(date)")
    }
}

