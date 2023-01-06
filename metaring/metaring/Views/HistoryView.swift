//
//  HistoryView.swift
//  metaring
//
//  Created by Rinaldi on 22/05/22.
//

import SwiftUI
import Charts

struct HistoryView: View {
    @State private var filterBy = 0
    @EnvironmentObject var dashboard: DashboardViewModel
    
    @Binding var metalContentActive: Bool
    @Binding var waterPHActive: Bool
    @Binding var waterTurbidityActive: Bool
    @Binding var waterDebitActive: Bool
    
    
    
    let labels = ["08.00", "09.00", "10.00", "11.00", "12.00", "13.00", "14.00", "15.00", "16.00", "17.00", "18.00", "19.00", "20.00", "21.00", "22.00", "23.00"]
    let entries1: [ChartDataEntry] = [
//        ChartDataEntry(x: 1, y: 1),
//        ChartDataEntry(x: 2, y: 2),
//        ChartDataEntry(x: 3, y: 3),
//        ChartDataEntry(x: 4, y: 5),
//        ChartDataEntry(x: 5, y: 2),
//        ChartDataEntry(x: 6, y: 1),
//        ChartDataEntry(x: 7, y: 3)
    ]
    let entries2: [ChartDataEntry] = [
//        ChartDataEntry(x: 1, y: 2),
//        ChartDataEntry(x: 2, y: 3),
//        ChartDataEntry(x: 3, y: 1),
//        ChartDataEntry(x: 4, y: 4),
//        ChartDataEntry(x: 5, y: 2),
//        ChartDataEntry(x: 6, y: 3),
//        ChartDataEntry(x: 7, y: 2)
    ]
    let entries3: [ChartDataEntry] = [
//        ChartDataEntry(x: 1, y: 2),
//        ChartDataEntry(x: 2, y: 3),
//        ChartDataEntry(x: 3, y: 2),
//        ChartDataEntry(x: 4, y: 4),
//        ChartDataEntry(x: 5, y: 5),
//        ChartDataEntry(x: 6, y: 3),
//        ChartDataEntry(x: 7, y: 1)
        
    ]
    let entries4: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 3),
        ChartDataEntry(x: 2, y: 1),
        ChartDataEntry(x: 3, y: 2),
        ChartDataEntry(x: 4, y: 1),
        ChartDataEntry(x: 5, y: 3),
        ChartDataEntry(x: 6, y: 2),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
        ChartDataEntry(x: 7, y: 1),
    ]
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView {
                VStack {
                    HStack {
                    }
                    .frame(width: geometry.self.size.width, height: 10)
                    .background(Color.clear)
                    
                    HStack {
                        DetailButtonView(
                            isActive: $metalContentActive,
                            name: "Metal Content",
                            nameIcon: MetaringAssets.metalContentIcon,
                            backgroundIcon: MetaringAssets.metalContentBackground,
                            nameColor: MetaringAssets.metalContent
                        ).onTapGesture {
                            self.metalContentActive = true
                            self.waterPHActive = false
                            self.waterTurbidityActive = false
                            self.waterDebitActive = false
                        }
                        
                        DetailButtonView(
                            isActive: $waterPHActive,
                            name: "Water pH",
                            nameIcon: MetaringAssets.waterPHIcon,
                            backgroundIcon: MetaringAssets.WaterPHBackground,
                            nameColor: MetaringAssets.WaterPH
                        ).onTapGesture {
                            self.metalContentActive = false
                            self.waterPHActive = true
                            self.waterTurbidityActive = false
                            self.waterDebitActive = false
                        }
                        
                        DetailButtonView(
                            isActive: $waterTurbidityActive,
                            name: "Water Turbidity",
                            nameIcon: MetaringAssets.waterTurbidityIcon,
                            backgroundIcon: MetaringAssets.WaterTurbidityBackground,
                            nameColor: MetaringAssets.WaterTurbidity
                        ).onTapGesture {
                            self.metalContentActive = false
                            self.waterPHActive = false
                            self.waterTurbidityActive = true
                            self.waterDebitActive = false
                        }
                        
                        DetailButtonView(
                            isActive: $waterDebitActive,
                            name: "Water Debit",
                            nameIcon: MetaringAssets.waterDebitIcon,
                            backgroundIcon: MetaringAssets.WaterDebitBackground,
                            nameColor: MetaringAssets.waterDebit
                        ).onTapGesture {
                            self.metalContentActive = false
                            self.waterPHActive = false
                            self.waterTurbidityActive = false
                            self.waterDebitActive = true
                        }
                    }
                    
                    HStack {
                    }
                    .frame(width: geometry.self.size.width, height: 10)
                    .background(Color.clear)
                    
                    VStack {
                        DashboardChartView().environmentObject(dashboard)
                            .frame(height: 400)
                        
                    }
                    
                }
                .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            }
        })
    }
}
