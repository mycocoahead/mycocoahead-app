//
//  EventDetailsViewController.swift
//  Meetapp
//
//  Created by Azuan on 14/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class EventDetailsViewController: UIViewController, EKEventEditViewDelegate {
    var event: Event!
  
    var initialLocation : CLLocation!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var back: UIButton!
  
    override func viewWillAppear(animated: Bool) {

    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = true
        
        title = "Event"
        name.text = event.name
        date.text = event.startTime.toString(format: .Custom("dd MMM yyyy h:mm a"))
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        back.addTarget(self, action: #selector(backToPrevious), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func backToPrevious() {
        navigationController?.popViewControllerAnimated(true)
    }
  
    @IBAction func addToCalendar(sender: AnyObject) {
      let eventController = EKEventEditViewController()
      let store = EKEventStore()
      eventController.eventStore = store
      
      eventController.editViewDelegate = self
      presentViewController(eventController, animated: true) {
        
      }
    }
    
    @IBAction func navigate(sender: AnyObject) {
      
      initialLocation = CLLocation(latitude: event.location!.latitude, longitude: event.location!.longitude)
      
      let alert = UIAlertController.init(title: "alert.title.how-do-you-want-to-go", message: "", preferredStyle: .ActionSheet)
      
      let cancel = UIAlertAction.init(title: "Cancel", style: .Cancel) { (UIAlertAction) -> Void in
        
      }
      
      alert.addAction(cancel)
      
      let action1 = UIAlertAction.init(title: "Google Maps", style: .Default) { (UIAlertAction) -> Void in
        
        let string = String(format: "comgooglemaps://?q=%f,%f&zoom=14&views=transit",self.initialLocation.coordinate.latitude,self.initialLocation.coordinate.longitude)
        
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
          UIApplication.sharedApplication().openURL(NSURL(string:
            string)!)
        } else {
          print("Can't use comgooglemaps://");
        }
        
        
        
      }
      alert.addAction(action1)
      
      let action2 = UIAlertAction.init(title: "Waze", style: .Default) { (UIAlertAction) -> Void in
        // !todo
      }
      alert.addAction(action2)
      
      let action3 = UIAlertAction.init(title: "Apple Maps", style: .Default) { (UIAlertAction) -> Void in
        // !todo
      }
      alert.addAction(action3)
      
      
      presentViewController(alert, animated: true) { () -> Void in}
    }
    
    //MARK - EKEventEditViewDelegate
    
    func eventEditViewController(controller: EKEventEditViewController,
                                 didCompleteWithAction action: EKEventEditViewAction){
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  
  @IBAction func saveFavorite(sender: AnyObject) {
    
    
    
  }
  
}
