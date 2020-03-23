//
//  webViewController.swift
//  WorldTrotter
//
//  Created by Joachim Goennheimer on 23.03.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

//import Foundation

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.dhbw-stuttgart.de")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
    
