//
//  OkView.swift
//  TryCharts
//
//  Created by Marcus Wu on 2023/9/6.
//

import Charts
import SwiftUI

struct OkView: View {
    
    let hourData = [MyData].mock.flatMap { $0.hours }
    
    @State private var selectedDate: Date?
    
    var body: some View {
        Chart {
            ForEach(hourData) { element in
                BarMark(
                    x: .value("Day", element.dateRange.start, unit: .hour),
                    y: .value("Count", element.count),
                    width: .ratio(0.65)
                )
                .cornerRadius(7, style: .circular)
                .foregroundStyle(Color.red)
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 14 * 3600)
        .chartXSelection(value: $selectedDate)
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour)) {}
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartYScale(domain: 0...3000)
        .padding()
    }
}
