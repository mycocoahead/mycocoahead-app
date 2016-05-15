//
//  CalenderViewController.swift
//  Meetapp
//
//  Created by Azuan on 14/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import CVCalendar
import RealmSwift

class CalenderViewController: UIViewController {
    @IBOutlet weak var calendarMenu: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDate = NSDate()

    var events = try! Realm().objects(Event)
    var selectedDayEvents = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = try! Realm().objects(Event)
        
        tableView.registerNib(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "Cell")

        calendarMenu.delegate = self
        calendarView.delegate = self
        
        navigationItem.title = NSDate().monthToString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        calendarMenu.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
        calendarView.redrawViewIfNecessarry()
    }
}

extension CalenderViewController: CVCalendarMenuViewDelegate {}
extension CalenderViewController: CVCalendarViewDelegate {
    @objc func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    @objc func firstWeekday() -> Weekday {
        return .Monday
    }
    
    @objc func didSelectDayView(dayView: DayView, animationDidFinish: Bool) {
        selectedDate = dayView.date.convertedDate()!
        selectedDayEvents.removeAll()
        
        for event in events {
            if event.startTime.isEqualToDateIgnoringTime(selectedDate) {
                selectedDayEvents.append(event)
            }
        }
        tableView.reloadData()
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        for event in events {
            if event.startTime.isEqualToDateIgnoringTime(dayView.date.convertedDate()!) {
                return true
            }
        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        return [UIColor.redColor()]
    }
    
    func didShowNextMonthView(date: NSDate) {
        navigationItem.title = date.monthToString()
        calendarView.contentController.refreshPresentedMonth()
    }

    func didShowPreviousMonthView(date: NSDate) {
        navigationItem.title = date.monthToString()
        calendarView.contentController.refreshPresentedMonth()
    }
}

extension CalenderViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDayEvents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        
        let event = selectedDayEvents[indexPath.row]
        cell.title.text = event.name
        cell.time.text = event.startTime.toString(format: .Custom("h:mm a"))
        
        return cell
    }
    

}

extension CalenderViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let controller = R.storyboard.main.eventDetails()!
        controller.event = events[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CVCalendarView {
    
    public func redrawViewIfNecessarry() {
        let contentViewSize = contentController.bounds.size
        let selfSize = bounds.size
        if selfSize.width != contentViewSize.width {
            let width = selfSize.width
            let height: CGFloat
            let countOfWeeks = CGFloat(6)
            
            let vSpace = appearance.spaceBetweenWeekViews!
            let hSpace = appearance.spaceBetweenDayViews!
            
            if let mode = calendarMode {
                switch mode {
                case .WeekView:
                    height = selfSize.height
                case .MonthView :
                    height = (selfSize.height / countOfWeeks) - (vSpace * countOfWeeks)
                }
                
                // If no height constraint found we set it manually.
                var found = false
                for constraint in constraints {
                    if constraint.firstAttribute == .Height {
                        found = true
                    }
                }
                
                if !found {
                    addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: frame.height))
                }
                
                weekViewSize = CGSizeMake(width, height)
                dayViewSize = CGSizeMake((width / 7.0) - hSpace, height)
                
                contentController.updateFrames(selfSize != contentViewSize ? bounds : CGRectZero)
            }
        }
    }
    
}