//
//  WebViewController.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 25/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import WebKit

class WebViewController: UIViewController {
    static let ID = "WebViewController"
    var stringURL = ""
    var name = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - LoadingView
    let spinner = UIActivityIndicatorView()
    
    init(loadURL: String, name: String) {
        super.init(nibName: WebViewController.ID, bundle: nil)
        self.stringURL = loadURL
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = name
        if let loadURL = URL(string: stringURL) {
            webView.isHidden = false
            let request = URLRequest(url: loadURL)
            webView.load(request)
        } else {
            webView.isHidden = true
            addBackgroundLabel()
        }
    }
    
    func configureView() {
        let size = CGFloat(60)
        spinner.frame = CGRect(x: (UIScreen.main.bounds.width - size) / 2,
                               y: (UIScreen.main.bounds.height - size - CGFloat(self.navigationController?.navigationBar.frame.height ?? 0.0)) / 2,
                               width: size,
                               height: size)
        spinner.style = .large
        spinner.color = .gray
        DispatchQueue.main.async {
            self.webView.addSubview(self.spinner)
        }
    }
    
    func addBackgroundLabel() {
        let label = UILabel()
        label.frame = CGRect(x: 12, y: (UIScreen.main.bounds.height - 40) / 2, width: (UIScreen.main.bounds.width - 24), height: 30)
        label.textAlignment = .center
        label.text = "Some problems loading url: \(stringURL)"
        DispatchQueue.main.async {
            self.view.addSubview(label)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
}
