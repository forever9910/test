//
//  WebViewController.swift
//  test
//
//  Created by niu on 2021/9/11.
//  Copyright © 2021 niu. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
	
	
	@IBOutlet weak var webView: WKWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let url=URL(string: "https://www.youtube.com/embed/wrYF0HX7Kzc"){
		let urlRequest = URLRequest(url:url)
		webView.load(urlRequest)
		}

        // Do any additional setup after loading the view.
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
