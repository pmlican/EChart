//
//  EChartOptions.swift
//  MyECharts
//
//  Created by Can Lee on 2019/9/8.
//  Copyright © 2019 Shenzhen Hupzon Energy Technology Co., Ltd. All rights reserved.
//

import Foundation

struct EChartOptions {
    var tooltip: ToolTip?
    var series: [Serie]?
    var xAxis : XAxis?
    var yAxis: YAxis?
}

struct XAxis {

}
struct YAxis {

}
struct ToolTip {

}
struct Serie: Codable {
    var data: [Any]?
    var name: String?
    func encode(to encoder: Encoder) throws {
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try container.decode(Double.self)
    }
}

