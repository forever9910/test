//
//  AppDelegate.swift
//  test
//
//  Created by niu on 2021/8/2.
//  Copyright © 2021 niu. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

	var window: UIWindow?
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]){(granted,error) in
			if granted{
				print("Allowed")
			}
			else{
				print("Not Allowed")
			}
		}
		// Override point for customization after application launch.
		let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
				let dislikeAction = UNNotificationAction(identifier: "Stop", title: "Stop", options: [])
				let category = UNNotificationCategory(identifier: "alarmMessage", actions: [snoozeAction, dislikeAction], intentIdentifiers: [], options: [])
				UNUserNotificationCenter.current().setNotificationCategories([category])
				
				UNUserNotificationCenter.current().delegate = self
		
		return true
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

			completionHandler([.alert, .sound, .badge])
		}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

