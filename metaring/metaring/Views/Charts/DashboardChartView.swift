//
//  DashboardChartView.swift
//  metaring
//
//  Created by Rinaldi on 21/05/22.
//

import SwiftUI
import Charts

struct DashboardChartView: View {
    @EnvironmentObject var dashboard: DashboardViewModel
    let labels = ["06.00", "07.00", "08.00", "09.00", "10.00", "11.00", "12.00", "15.00"]
    let entries1: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 0.22),
        ChartDataEntry(x: 2, y: 0.23),
        ChartDataEntry(x: 3, y: 0.23),
        ChartDataEntry(x: 4, y: 0.22),
        ChartDataEntry(x: 5, y: 0.24),
        ChartDataEntry(x: 6, y: 0.23),
        ChartDataEntry(x: 7, y: 0.24),
        ChartDataEntry(x: 8, y: 0.24),
    ]
    let entries2: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 7.94),
        ChartDataEntry(x: 2, y: 7.98),
        ChartDataEntry(x: 3, y: 7.97),
        ChartDataEntry(x: 4, y: 7.90),
        ChartDataEntry(x: 5, y: 7.94),
        ChartDataEntry(x: 6, y: 7.96),
        ChartDataEntry(x: 7, y: 7.99),
        ChartDataEntry(x: 8, y: 7.94),
    ]
    let entries3: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 4.12),
        ChartDataEntry(x: 2, y: 4.14),
        ChartDataEntry(x: 3, y: 3.89),
        ChartDataEntry(x: 4, y: 3.98),
        ChartDataEntry(x: 5, y: 3.83),
        ChartDataEntry(x: 6, y: 4.16),
        ChartDataEntry(x: 7, y: 4.07),
        ChartDataEntry(x: 8, y: 4.18),
        
    ]
    let entries4: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: -106),
        ChartDataEntry(x: 2, y: -105),
        ChartDataEntry(x: 3, y: -100),
        ChartDataEntry(x: 4, y: -103),
        ChartDataEntry(x: 5, y: -106),
        ChartDataEntry(x: 6, y: -106),
        ChartDataEntry(x: 7, y: -99),
        ChartDataEntry(x: 8, y: -105),
    ]
    
    var body: some View {
        VStack {
            MultiLineChartView(
                
                entries1: dashboard.metalContentEntries,
                entries2: dashboard.waterPHEntries,
                entries3: dashboard.waterTurbidityEntries,
                entries4: dashboard.waterDebitEntries,
//                entries1: entries1,
//                entries2: entries2,
//                entries3: entries3,
//                entries4: entries4,
                labels: dashboard.labelEntries)
        }
    }
}

struct DashboardChartView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardChartView()
    }
}
