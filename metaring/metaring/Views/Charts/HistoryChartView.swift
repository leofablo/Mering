//
//  HistoryChartView.swift
//  metaring
//
//

import SwiftUI
import Charts

struct HistoryChartView: View {
    @EnvironmentObject var historyViewModel: HistoryViewModel
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
                    entries1: historyViewModel.metalContentEntries,
                    labels: historyViewModel.labelEntries, color: "metalContent")
            }
        }
        
        if self.isWaterPHShow {
            VStack {
                OneLineChartView(
                    entries1: historyViewModel.waterPHEntries,
                    labels: historyViewModel.labelEntries, color: "waterPH")
            }
        }
        
        if self.isWaterDebitShow {
            VStack {
                OneLineChartView(
                    entries1: historyViewModel.waterDebitEntries,
                    labels: historyViewModel.labelEntries, color: "waterDebit")
            }
        }
        
        if self.isWaterTurbidityShow {
            VStack {
                OneLineChartView(
                    entries1: historyViewModel.waterTurbidityEntries,
                    labels: historyViewModel.labelEntries, color: "waterTurbidity")
            }
        }
    }
}

