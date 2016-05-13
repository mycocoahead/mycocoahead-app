//
//  ViewController.swift
//  Meetapp
//
//  Created by Azuan on 13/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit

class LatestEventsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let manager = CLLocationManager()
    var events = try! Realm().objects(Event)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        tableView.registerNib(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "Cell")

        EventsRequest().getAllEvents({
            self.events = try! Realm().objects(Event)
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        requestLocationPermission()
    }
    
    func requestLocationPermission() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
}

extension LatestEventsViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}


extension LatestEventsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        cell.title.text = event.name
        cell.time.text = event.startTime.toString(format: .Custom("dd MMM yyyy h:mm a"))
        
        return cell
    }
}

extension LatestEventsViewController: UITableViewDelegate {
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