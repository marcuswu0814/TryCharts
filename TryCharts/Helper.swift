//
//  Helper.swift
//  TryCharts
//
//  Created by Marcus Wu on 2023/9/6.
//

import Foundation

extension Date {
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
}

extension DateRange {
    
    func contains(_ date: Date) -> Bool {
        (start...end).contains(date)
    }
    
}

struct DateRange: Hashable {
    
    let start: Date
    
    let end: Date
    
    func toArray() -> [Date] {
        [start, end]
    }
    
}

extension DateRange {
    
    /// Make a date range with given date's `startOfDay` and how many date in the range.
    /// - Parameters:
    ///   - start: The day used to be start of day
    ///   - day: How many days of the range, includ start date
    init(start: Date, toDays day: Int) {
        self.start = start.startOfDay
        self.end = Calendar.current.date(byAdding: DateComponents(day: day - 1), to: start)!.endOfDay
    }
    
}


extension DateRange {
    
    static var nearlyMonthDays: DateRange {
        nearlyDays(30)
    }
    
    static func nearlyDays(_ day: Int) -> DateRange {
        let date = Date().startOfDay
        
        return .init(
            start: Calendar.current.date(byAdding: DateComponents(day: -day), to: date)!,
            end: date.endOfDay
        )
    }
    
    func allDateRanges() -> [DateRange] {
        let calendar = Calendar.current
        let components = DateComponents(hour: 0, minute: 0, second: 0)
        var result = [start]

        calendar.enumerateDates(
            startingAfter: start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if date! >= end {
                stop = true
                return
            }
            
            result.append(date!)
        }
        
        return result.map {
            DateRange(start: $0.startOfDay, end: $0.endOfDay)
        }
    }
    
}

private func date(year: Int, month: Int, day: Int = 1, hour: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour)) ?? Date()
}

private func dateRangeByHour(_ dateComponents: DateComponents, hour: Int) -> DateRange {
    .init(
        start: date(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!, hour: hour),
        end: date(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!, hour: hour + 1)
    )
}

private func make(by dateComponents: DateComponents) -> [MyData.HourData] {
    var data: [MyData.HourData] = []
    
    for hour in 0...23 {
        
        if (0...4).contains(hour) || (17...23).contains(hour) {
            data.append(
                .init(dateRange: dateRangeByHour(dateComponents, hour: hour))
            )
        } else {
            data.append(
                .init(dateRange: dateRangeByHour(dateComponents, hour: hour))
            )
        }
    }
    
    return data
}

struct MyData: Identifiable {
    
    struct HourData: Identifiable {
        
        let id = UUID()
        
        let count: Int = (1000...3000).randomElement()!
        
        let dateRange: DateRange
        
    }
    
    let id = UUID()
    
    let count: Int = (1000...3000).randomElement()!
    
    let dateRange: DateRange
    
    let hours: [HourData]
    
}

private extension Date {
    
    func toDateComponents() -> DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    }
    
}

extension [MyData] {
    
    static var mock: [MyData] {
        DateRange.nearlyDays(120).allDateRanges().map {
            .init(dateRange: $0, hours: make(by: $0.start.toDateComponents()))
        }
    }
    
}
