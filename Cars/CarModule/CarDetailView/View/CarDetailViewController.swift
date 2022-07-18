//
//  CarDetailViewController.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import UIKit
import WebKit
import IHProgressHUD

class CarDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var webView: WKWebView!
    
    // MARK: - Variables
    
    var viewModel: CarDetailViewModelProtocol!
    
    // MARK: - Initialization
    
    init?(coder: NSCoder, viewModel: CarDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        webView.navigationDelegate = self
        IHProgressHUD.show()
        if let request = self.viewModel.loadImageInWebView() {
            webView.load(request)
        }
    }
}

// MARK: - Webkit Navigation delegates

extension CarDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        IHProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        IHProgressHUD.dismiss()
    }
    
}
