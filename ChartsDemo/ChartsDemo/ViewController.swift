//
//  ViewController.swift
//  ChartsDemo
//


import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var chartView: CombinedChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var lineData = [ChartDataEntry]()
        var lineData2 = [ChartDataEntry]()
        var barData = [BarChartDataEntry]()
        var barData2 = [BarChartDataEntry]()
        
        // グラフにいれるデータ
        for i in 0..<12 {
            lineData.append(BarChartDataEntry(x: Double(i), y: Double(i*300)))
            lineData2.append(BarChartDataEntry(x: Double(i), y: Double(i*1000)))
            barData.append(BarChartDataEntry(x: Double(i), y: Double(i*500)))
            barData2.append(BarChartDataEntry(x: Double(i), y: Double(i*1000)))
        }
        
        let lineDataSet = LineChartDataSet(values: lineData, label: "折れ線1本目")
        lineDataSet.drawCirclesEnabled = false
        lineDataSet.drawValuesEnabled = false
        lineDataSet.colors = [UIColor.red]
        lineDataSet.lineWidth = 5.0
        lineDataSet.axisDependency = .left
        
        let lineDataSet2 = LineChartDataSet(values: lineData2, label: "折れ線2本目")
        lineDataSet2.drawCirclesEnabled = true
        lineDataSet2.drawValuesEnabled = true
        lineDataSet2.colors = [UIColor.orange]
        lineDataSet2.lineWidth = 5.0
        lineDataSet2.axisDependency = .left
        
        let barDataSet = BarChartDataSet(values: barData, label: "棒グラフ1本目")
        barDataSet.drawValuesEnabled = false
        barDataSet.colors = [UIColor.blue]
        barDataSet.axisDependency = .left
        
        let barDataSet2 = BarChartDataSet(values: barData2, label: "棒グラフ2本目")
        barDataSet2.drawValuesEnabled = true
        barDataSet2.colors = [UIColor.purple]
        barDataSet2.axisDependency = .left
        
        let lineChartData = LineChartData(dataSets: [lineDataSet, lineDataSet2])
        
        let barChartData = BarChartData(dataSets: [barDataSet, barDataSet2])
        let groupSpace = 0.30
        let barSpace = 0.00
        let barWidth = 0.35
        
        barChartData.setDrawValues(false)
        barChartData.barWidth = barWidth
        barChartData.groupBars(fromX: -0.5, groupSpace: groupSpace, barSpace: barSpace)
        
        let combinedData = CombinedChartData()
        combinedData.lineData = lineChartData
        combinedData.barData = barChartData
        
        //legend
        let legend = chartView.legend
        legend.enabled = true
        
        chartView.data = combinedData
        chartView.backgroundColor = .white
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelCount = 12
        chartView.xAxis.spaceMin = 0.5
        chartView.xAxis.spaceMax = 0.5
        chartView.xAxis.yOffset = 0
        chartView.xAxis.labelTextColor = UIColor.black
        chartView.xAxis.axisLineColor = UIColor.white
        chartView.leftAxis.labelCount = 3
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.calculate(min: 0, max: combinedData.barData.yMax * 1.25)
        chartView.leftAxis.labelTextColor = UIColor.black
        chartView.leftAxis.axisLineColor = UIColor.white
        chartView.rightAxis.labelCount = 5
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.labelTextColor = UIColor.black
        chartView.rightAxis.axisLineColor = UIColor.white
        chartView.chartDescription?.text = ""
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.dragEnabled = false
        chartView.notifyDataSetChanged()
        chartView.highlightPerTapEnabled = false
        
        chartView.extraTopOffset = 0.0
        chartView.extraLeftOffset = 20.0
        chartView.extraRightOffset = 20.0
        
        chartView.leftAxis.valueFormatter = YAxisValueFormatter()
    }

}

class YAxisValueFormatter: NSObject, IAxisValueFormatter {
    let numFormatter: NumberFormatter
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.numberStyle = NumberFormatter.Style.decimal
        numFormatter.groupingSeparator = ","
        numFormatter.groupingSize = 3
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}
