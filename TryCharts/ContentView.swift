//
//  ContentView.swift
//  TryCharts
//
//  Created by Marcus Wu on 2023/9/5.
//

import Charts
import SwiftUI

struct ContentView: View {
    
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
//                .annotation(spacing: 10) {
////                    Text(String(element.count))
//                    Color.blue.frame(width: 10, height: 10)
//
//                }
                
                if let selectedDate, element.dateRange.contains(selectedDate) {
                    RuleMark(
                        x: .value("Selected", selectedDate, unit: .hour)
                    )
                }
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 14 * 3600)
//        .scrollTargetBehavior(.paging)
//            .chartScrollPosition(x: ViewStore(store, observe: { $0 }).$scrollPosition)
        .chartXSelection(value: $selectedDate)
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour)) {
//                AxisGridLine()
//                AxisValueLabel(format: .dateTime.hour(), centered: true)
//                let date = $0.as(Date.self)
//                AxisValueLabel("Test")
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartYScale(domain: 0...3000)
        .padding()
    }
}

#Preview {
    ContentView()
}
