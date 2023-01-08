//
//  HistoryViewModel.swift
//  metaring
//

import Foundation
import CoreData
import Charts

class HistoryViewModel: ObservableObject {
    @Published var sensor: [SensorModel] = []
    @Published var date: String = ""
    @Published var detailSelected = 0
    
    @Published var metalContentValue: Double = 0.0
    @Published var metalContentType: String = "Mg/L"
    
    @Published var waterPHValue: Double = 0.0
    @Published var waterPHType: String = "pH"
    
    @Published var waterTurbidityValue: Double = 0.0
    @Published var waterTurbidityType: String = "NTU"
    
    @Published var waterDebitValue: Double = 0.0
    @Published var waterDebitType: String = "m3/s"
    
    @Published var requestSensor: [RequestSensorModel] = []
    
    @Published var labelEntries: [String] = []
    @Published var metalContentEntries: [ChartDataEntry] = []
    @Published var waterPHEntries: [ChartDataEntry] = []
    @Published var waterTurbidityEntries: [ChartDataEntry] = []
    @Published var waterDebitEntries: [ChartDataEntry] = []
    
    @Published var isMetalShow: Bool
    @Published var isWaterPHShow: Bool
    @Published var isWaterTurbidityShow: Bool
    @Published var isWaterDebitShow: Bool
    
    init(isMetalShow: Bool = true,
         isWaterPHShow: Bool = true,
         isWaterTurbidityShow: Bool = true,
         isWaterDebitShow: Bool = true) {
        self.isMetalShow = isMetalShow
        self.isWaterPHShow = isWaterPHShow
        self.isWaterTurbidityShow = isWaterTurbidityShow
        self.isWaterDebitShow = isWaterDebitShow
        
        self.mappingData()
    }
    
    func mappingData() {
        var countData = 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YY HH:mm:ss" //dd-MM-YY HH:mm:ss
        
        self.sensor = MetaringCoreDataManager.shared.getLimOffsetData()
        
        self.labelEntries = []
        self.metalContentEntries = []
        self.waterPHEntries = []
        self.waterTurbidityEntries = []
        self.waterDebitEntries = []
        
        for sensorData in self.sensor {
            
            self.labelEntries.append(dateFormatter.string(from: sensorData.time))

            if self.isMetalShow {
                self.metalContentEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(sensorData.metalContent))
                )
            } else {
                self.metalContentEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(0))
                )
            }

            if self.isWaterPHShow {
                self.waterPHEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(sensorData.waterPH))
                )
            } else {
                self.waterPHEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(0))
                )

            }

            if self.isWaterTurbidityShow {
                self.waterTurbidityEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(sensorData.waterTurbidity))
                )
            } else {
                self.waterTurbidityEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(0))
                )
            }

            if self.isWaterDebitShow {
                self.waterDebitEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(sensorData.waterDebit))
                )
            } else {
                self.waterDebitEntries.append(
                    ChartDataEntry(x: Double(countData), y: Double(0))
                )
            }
            
            countData += 1

        }
    }
    
    func getLastDataSensor() {
        let requestModel: RequestSensorModel = AntaresSensorRequest.init(semaphore: DispatchSemaphore(value: 0)).getLastData()
        if  requestModel.status {
            self.create(model: requestModel)
        }
    }
    
    func create(model: RequestSensorModel) {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat =  "yyyymmdd'T'HHmmss"
        
        let newDate = dateFormmater.date(from: model.ct)
        
//        if MetaringCoreDataManager.shared.isDataByDateExists(date: newDate!) {
//            print("data exists")
//        } else {
//            let sensor = Sensor(context: MetaringCoreDataManager.shared.viewContext)
//            sensor.create_time = Date()
//            sensor.resource_id = model.ri
//
//            sensor.time = newDate
//
//            sensor.url = model.pi
//            sensor.metal_content = format_model_request_value(data: model.con["metal_content"] as Any)
//            sensor.water_turbidity = format_model_request_value(data: model.con["turbidity"] as Any)
//            sensor.water_ph = format_model_request_value(data: model.con["ph"] as Any)
//            sensor.water_debit = format_model_request_value(data:  model.con["debit"] as Any)
//            MetaringCoreDataManager.shared.save()
//        }
        
        let sensor = Sensor(context: MetaringCoreDataManager.shared.viewContext)
        sensor.create_time = Date()
        sensor.resource_id = model.ri

        sensor.time = newDate

        sensor.url = model.pi
        sensor.metal_content = format_model_request_value(data: model.con["metal_content"] as Any)
        sensor.water_turbidity = format_model_request_value(data: model.con["turbidity"] as Any)
        sensor.water_ph = format_model_request_value(data: model.con["ph"] as Any)
        sensor.water_debit = format_model_request_value(data:  model.con["debit"] as Any)
        MetaringCoreDataManager.shared.save()
        
        self.mappingData()
    }
    
    func format_model_request_value(data: Any) -> Double {
        var result: Double = 0
        guard let data_value = data as? String else {
            return 0
        }
        result = Double(data_value) ?? 0
        return result
    }
}
