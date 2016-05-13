//
//  EventDetailsViewController.swift
//  Meetapp
//
//  Created by Azuan on 14/05/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    var event: Event!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var back: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBottomBarWhenPushed = true
        
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
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func backToPrevious() {
        navigationController?.popViewControllerAnimated(true)
    }
}
