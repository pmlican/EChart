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

    var webView: WKWebView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        addSubview(webView)
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.scrollView.isScrollEnabled = false
    }
    func resizeContainer(size:CGSize) {
        let js = "resizeContainer(\(size.width),\(size.height))"
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
    func resize3() {
        let js1 = "resize2('height:300px;width:375px;')"
        webView.evaluateJavaScript(js1, completionHandler: nil)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        webView.frame = bounds
//        resizeContainer(size: bounds.size)
//        webView.evaluateJavaScript("test()", completionHandler: nil)
        let js1 = "resize2('height:\(bounds.size.height)px;width:\(bounds.size.width)px;')"
        webView.evaluateJavaScript(js1, completionHandler: nil)

    }
}
