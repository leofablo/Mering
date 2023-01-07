//
//  HistoryChartView.swift
//  metaring
//
//  Created by Raja Azian on 07/01/23.
//

import SwiftUI
import Charts

struct HistoryChartView: View {
    @EnvironmentObject var dashboard: DashboardViewModel
    var isMetalShow: Bool
    var isWaterPHShow: Bool
    var isWaterTurbidityShow: Bool
    var isWaterDebitShow: Bool
    
    init(isMetalShow: Bool, isWaterPHShow: Bool, isWaterTurbidityShow: Bool, isWaterDebitShow: Bool) {
        self.isMetalShow = isMetalShow
        self.isWaterPHShow = isWaterPHShow
        self.isWaterTurbidityShow = isWaterTurbidityShow
        self.isWaterDebitShow = isWaterDebitShow
    }
    
    var body: some View {
        if self.isMetalShow {
            VStack {
                OneLineChartView(
                    entries1: dashboard.metalContentEntries,
                    labels: dashboard.labelEntries, color: "metalContent")
            }
        }
        
        if self.isWaterPHShow {
            VStack {
                OneLineChartView(
                    entries1: dashboard.waterPHEntries,
                    labels: dashboard.labelEntries, color: "waterPH")
            }
        }
        
        if self.isWaterDebitShow {
            VStack {
                OneLineChartView(
                    entries1: dashboard.waterDebitEntries,
                    labels: dashboard.labelEntries, color: "waterDebit")
            }
        }
        
        if self.isWaterTurbidityShow {
            VStack {
                OneLineChartView(
                    entries1: dashboard.waterTurbidityEntries,
                    labels: dashboard.labelEntries, color: "waterTurbidity")
            }
        }
    }
}

