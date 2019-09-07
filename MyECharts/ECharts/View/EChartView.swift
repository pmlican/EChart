//
//  EChartView.swift
//  MyECharts
//
//  Created by wanghaiwei on 2019/9/6.
//  Copyright © 2019 Shenzhen Hupzon Energy Technology Co., Ltd. All rights reserved.
//

import UIKit
import WebKit

class EChartView: UIView {

    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.scrollView.isScrollEnabled = false
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {

        addSubview(webView)
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    func resizeContainer(size:CGSize) {
        let js = "resizeContainer(\(200),\(size.height))"
        evaluateJS(js)
    }
    func resize3() {
        let js = "resize2('height:300px;width:100px;')"
        evaluateJS(js)
    }
    
    func evaluateJS(_ js: String) {
        webView.evaluateJavaScript(js) { (result, error) in
            if let result = result {
                print(result)
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        webView.frame = bounds
    }
}
extension EChartView: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "调试", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        completionHandler()
    }
}
