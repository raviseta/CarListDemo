//
//  CarDetailViewController.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import UIKit
import WebKit

class CarDetailViewController: UIViewController {
    
    @IBOutlet var lblCarDescription: UILabel!
    
    var viewModel: CarDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webview = WKWebView()
        webview.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let url = URL.init(string: viewModel.carData?.image ?? "")
        let request = URLRequest(url: url!)
        webview.load(request)
        self.view.addSubview(webview)
    }
    
}
