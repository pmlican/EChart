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
        
//        let test = Test(data: ["","",9.1,10])

    }
    @objc func clickBtn(_ sender: UIButton) {
        //rem  除以16
//        let js = "resizeContainer(200,300)"
//        let js1 = "resize2('height:200px;width:200px;')"
//        chartView.evaluateJS(js)
        
        
        var data = [Double]()
        for _ in 0..<100 {
            let y = Double.random(in: 0..<100)
            data.append(y)
        }
//        var op = EChartOptions()
//        let ser1 = Serie(data: data, name: "123")
//        op.series = [ser1]
        
        let test3 = "{\"title\":\"2018\"}"
        let test1 = "        \"title\": \"123\",\r\n        \"series\": [\r\n        {\r\n        \"data\": [1,5.0,4.8,10,18]\r\n        }\r\n        ]\r\n        }\r\n"
        let test2 = "{\"title\" : \"2018\", \"series\": [  {\"data\" : [      10,      0,      0,      11,      2,      6,      10,      7,      9,      8,      11,      10    ] } ]}"
        
        let test4 =
        """
        {
            "title": {
                left: 'center',
                "text": '量面积图',
            },
            "tooltip": {
                "trigger": "axis",
            },
            "xAxis": {
                "data": ["17年","18年","19年", "20年"]

            },
            "yAxis": {
            },
            "series": [{
                     "data": [100, 200, 90, 300],
                     "type": "line"
                     }]

        }
        """
        
//        let jsString = "updateData('\(test3)')"
        let jsString = "refresh(\(test4))"
        chartView.evaluateJS(jsString)
    }


}

