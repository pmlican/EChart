//
//  ViewController.swift
//  MyECharts
//
//  Created by wanghaiwei on 2019/9/6.
//  Copyright © 2019 Shenzhen Hupzon Energy Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let chartView = EChartView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chartView)
        
        let btn = UIButton(frame: CGRect(x:0, y:420, width: 100, height: 30))
        btn.setTitle("测试", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
        
    }
    @objc func clickBtn(_ sender: UIButton) {
        //rem  除以16
        let js = "resizeContainer(200,300)"
        let js1 = "resize2('height:200px;width:200px;')"
        chartView.evaluateJS(js)
    }


}

