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
                    
                    if self.metalContentActive {
                        VStack {
                            HistoryChartView(isMetalShow: true, isWaterPHShow: false, isWaterTurbidityShow: false, isWaterDebitShow: false).environmentObject(dashboard)
                                .frame(height: 400)
                            
                        }
                    }
                    
                    if self.waterPHActive {
                        VStack {
                            HistoryChartView(isMetalShow: false, isWaterPHShow: true, isWaterTurbidityShow: false, isWaterDebitShow: false).environmentObject(dashboard)
                                .frame(height: 400)
                            
                        }
                    }
                    
                    if self.waterTurbidityActive {
                        VStack {
                            HistoryChartView(isMetalShow: false, isWaterPHShow: false, isWaterTurbidityShow: true, isWaterDebitShow: false).environmentObject(dashboard)
                                .frame(height: 400)
                            
                        }
                    }
                    
                    if self.waterDebitActive {
                        VStack {
                            HistoryChartView(isMetalShow: false, isWaterPHShow: false, isWaterTurbidityShow: false, isWaterDebitShow: true).environmentObject(dashboard)
                                .frame(height: 400)
                            
                        }
                    }
                    
                }
                .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            }
        })
    }
}
