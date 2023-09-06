//
//  BadView.swift
//  TryCharts
//
//  Created by Marcus Wu on 2023/9/6.
//

import Charts
import SwiftUI

struct BadView: View {
    
    let hourData = [MyData].mock.flatMap { $0.hours }
    
    @State private var selectedDate: Date?
    
    @State private var isShowXLabel = true
    
    var body: some View {
        VStack {
            chartContent
            Toggle("X Label (Open with bad performance)", isOn: $isShowXLabel)
        }
    }
    
    private var chartContent: some View {
        Chart {
            ForEach(hourData) { element in
                BarMark(
                    x: .value("Day", element.dateRange.start, unit: .hour),
                    y: .value("Count", element.count),
                    width: .ratio(0.65)
                )
                .cornerRadius(7, style: .circular)
                .foregroundStyle(Color.red)
                
                if let selectedDate, element.dateRange.contains(selectedDate) {
                    RuleMark(
                        x: .value("Selected", selectedDate, unit: .hour)
                    )
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 14 * 3600)
        .chartXSelection(value: $selectedDate)
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour)) {
                if isShowXLabel {
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.hour(), centered: true)
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartYScale(domain: 0...3000)
        .padding()
    }
    
}
