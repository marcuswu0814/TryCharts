//
//  TryChartsApp.swift
//  TryCharts
//
//  Created by Marcus Wu on 2023/9/5.
//

import SwiftUI

@main
struct TryChartsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                OkView()
                    .tabItem {
                        Text("Ok")
                    }
                BadView()
                    .tabItem {
                        Text("Bad")
                    }
            }
        }
    }
}
