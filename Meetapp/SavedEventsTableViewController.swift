//
//  SavedEventsTableViewController.swift
//  Meetapp
//
//  Created by Hijazi on 15/5/16.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

class SavedEventsTableViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

    
//      cell.time.text = event.startTime.toString(format: .Custom("dd MMM yyyy h:mm a"))
    
      return cell
    }
  
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return 65
    }
    
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    let controller = R.storyboard.main.eventDetails()!
//    controller.event = events[indexPath.row]
//    navigationController?.pushViewController(controller, animated: true)
  }
  
  
  
}
