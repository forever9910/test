//
//  NoticeViewController.swift
//  test
//
//  Created by niu on 2021/10/8.
//  Copyright © 2021 niu. All rights reserved.
//

import UIKit
import UserNotifications

class NoticeViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//createNotification()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func notice(_ sender: Any) {
		let content = createNotification()
		print("已預約")
		
	}
	
	func createNotification() {
			
			let content = UNMutableNotificationContent()
			
			content.title = "Notice"
			content.subtitle = "test"
			content.body = "how are you"
			content.badge = 0
			content.sound = UNNotificationSound.default
			content.categoryIdentifier = "alarmMessage"
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
		let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
				
		UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
	}
	

	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
