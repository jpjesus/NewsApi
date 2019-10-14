//
//  ArticleViewController.swift
//  TheNews
//
//  Created by Jesus Parada on 10/14/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var fullNewsView: UIView!
    @IBOutlet weak var newProgressView: UIProgressView! {
        didSet {
            newProgressView.tintColor = .red
        }
    }
    
    private let fullArticleWebView: WKWebView
    private let disposeBag = DisposeBag()
    private weak var estimatedProgress: Observable<Double>?
    private let estimatedTime = "estimatedProgress"
    private let url: URL?
    
    init(url: URL?) {

        self.url = url
        fullArticleWebView = WKWebView()
        super.init(nibName: String(describing: ArticleViewController.self), bundle: nil)
        fullArticleWebView.navigationDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
}

//MARK: - private methods
extension ArticleViewController {
    
    private func setupWebView() {
        guard let url = self.url else {
            return
        }
        fullNewsView.addSubview(fullArticleWebView)
        fullArticleWebView.bindFrameToSuperviewBounds()
        fullArticleWebView.load(URLRequest(url: url))
        fullArticleWebView.rx
            .observe(Double.self, estimatedTime)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] progress in
                if let progress = progress {
                    self?.newProgressView.setProgress(Float(progress), animated: true)
                    self?.newProgressView.isHidden = progress == 1
                }
            }).disposed(by: disposeBag)
    }
    
    private func setNavigation() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = UIColor.charcoal()
    }
}

//MARK: - WKNavigationDelegate

extension ArticleViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        if (navigationAction.navigationType == .formSubmitted) {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
