//
//  MultiLineChartView.swift
//  metaring
//
//

import SwiftUI
import Charts

struct OneLineChartView : UIViewRepresentable {
    var entries1 : [ChartDataEntry]
    var labels: [String]
    var color: String

    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        return createChart(chart: chart)
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
        uiView.setNeedsDisplay()
        uiView.xAxis.valueFormatter = OneLineCustomChartFormatter(labels: labels) as any AxisValueFormatter
    }

    func createChart(chart: LineChartView) -> LineChartView{
        chart.chartDescription.enabled = false
        chart.xAxis.drawGridLinesEnabled = true
        chart.borderLineWidth = 1
        chart.xAxis.drawLabelsEnabled = true
        chart.xAxis.drawAxisLineEnabled = true
        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.labelPosition = .outsideChart
        chart.xAxis.labelRotationAngle = CGFloat(270)
        chart.rightAxis.enabled = false
        chart.drawBordersEnabled = true
        chart.drawMarkers = true
        chart.legend.form = .none
        chart.xAxis.labelCount = labels.count
        chart.xAxis.forceLabelsEnabled = true
        chart.xAxis.granularityEnabled = true
        chart.xAxis.granularity = 1.0
        chart.xAxis.valueFormatter = OneLineCustomChartFormatter(labels: labels) as any AxisValueFormatter
        chart.data = addData()
        return chart
    }

    func addData() -> LineChartData{
        var cColor = UIColor(MetaringAssets.metalContent)
        
        if self.color == "waterPH" {
            cColor = UIColor(MetaringAssets.WaterPH)
        }
        
        if self.color == "waterTurbidity" {
            cColor = UIColor(MetaringAssets.WaterTurbidity)
        }
        
        if self.color == "waterDebit" {
            cColor = UIColor(MetaringAssets.waterDebit)
        }
        
        let data = LineChartData(dataSets: [
            //Data Content
            generateLineChartDataSet(dataSetEntries: entries1, color: cColor, fillColor: UIColor.clear),
            
        ])
        return data
    }

    func generateLineChartDataSet(dataSetEntries: [ChartDataEntry], color: UIColor, fillColor: UIColor) -> LineChartDataSet{
        let dataSet = LineChartDataSet(entries: dataSetEntries, label: "")
        dataSet.colors = [color]
        dataSet.mode = .linear
        dataSet.circleRadius = 1
        dataSet.circleHoleColor = UIColor(Color(#colorLiteral(red: 0.003921568627, green: 0.231372549, blue: 0.431372549, alpha: 1)))
        dataSet.fill = ColorFill(color: fillColor)
        dataSet.drawFilledEnabled = false
        dataSet.setCircleColor(UIColor.clear)
        dataSet.lineWidth = 1.5
        dataSet.valueTextColor = color
        dataSet.valueFont = UIFont(name: UIFont.familyNames.first!, size: 12)!
        return dataSet
    }

}

class OneLineCustomChartFormatter: NSObject, AxisValueFormatter {
    var labels: [String]
    init(labels: [String]) {
        self.labels = labels
    }
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value - 1)]
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
