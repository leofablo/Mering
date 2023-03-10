//
//  RequestAllSensorData.swift
//  metaring
//
//  Created by Raja Azian on 07/01/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import CoreData

struct RequestAllSensorData {
    var semaphore = DispatchSemaphore (value: 6)
    
    var domainUrl = "https://platform.antares.id"
    var port = "8443"
    var cseId = "antares-cse"
    var cseName = "antares-id"
    var applicationName = "SeiJagoWaterQuality"
    var deviceName = "waterQualitySensor"
    
    var accessId = "f184b703e2d42c12"
    var accessPassword = "9e0852ac7001c2c8"
    
    func getData(urireq: String) {
        var request = URLRequest(url: URL(string: "\(domainUrl):\(port)/~\(urireq)")!, timeoutInterval: Double.infinity)
        request.addValue("\(accessId):\(accessPassword)", forHTTPHeaderField: "X-M2M-Origin")
        request.addValue("application/json;ty=4", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        
//        semaphore.wait()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: [String: Any]]
                
                let con = response["m2m:cin"]!["con"]
                let conData: [String: String] = self.reformatString(con: con as! String)
                
//                print(conData)
                
                let dateFormmater = DateFormatter()
                dateFormmater.dateFormat =  "yyyymmdd'T'HHmmss"
                let newDate = dateFormmater.date(from: response["m2m:cin"]!["ct"] as! String)
                
                //check if data with date exists
                if MetaringCoreDataManager.shared.isDataByDateExists(date: newDate!) {
                    print("data exists, skip data")
                } else {
                    print("data unexists, write data")
                    
                    let sensor = Sensor(context: MetaringCoreDataManager.shared.viewContext)
                    
                    sensor.create_time = Date()
                    sensor.resource_id = response["m2m:cin"]!["ri"] as? String
                    
                    
                    sensor.time = newDate
                    
                    sensor.url = response["m2m:cin"]!["pi"] as? String
                    sensor.metal_content = format_model_request_value(data: conData["al_content"] as Any)
                    sensor.water_turbidity = format_model_request_value(data: conData["turbidity"] as Any)
                    sensor.water_ph = format_model_request_value(data: conData["ph"] as Any)
                    sensor.water_debit = format_model_request_value(data: conData["lore_rssi"] as Any)
                    MetaringCoreDataManager.shared.save()
                    
                    //semaphore.signal()
                    
                    
                    // print(sensor)
                    
                }
                    
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
//        semaphore.signal()
    }
    
    func format_model_request_value(data: Any) -> Double {
        var result: Double = 0
        guard let data_value = data as? String else {
            return 0
        }
        result = Double(data_value) ?? 0
        return result
    }
    
    func reformatString(con: String) -> [String: String] {
        let a = con.replacingOccurrences(of: "\\", with: "")
        let b = a.replacingOccurrences(of: "\"", with: "")
        let c = b.replacingOccurrences(of: ",", with: ":")
        let d = c.replacingOccurrences(of: "{", with: "")
        let e = d.replacingOccurrences(of: "}", with: "")
        let f = e.components(separatedBy: ":")
        
        var current = 1
        var currentKey = "";
        var results: [String: String] = ["packet_no": ""]
        for i in f {
            if (current % 2 == 0) {
                results[currentKey] = i
            } else {
                currentKey = i
            }
            current += 1
            
        }
        
        return results;
    }
    
    func getAllData() {
        var request = URLRequest(url: URL(string: "\(domainUrl):\(port)/~/\(cseId)/\(cseName)/\(applicationName)/\(deviceName)?fu=1&ty=4&lim=99999&cra=20230101T000000")!, timeoutInterval: Double.infinity)
        request.addValue("\(accessId):\(accessPassword)", forHTTPHeaderField: "X-M2M-Origin")
        request.addValue("application/json;ty=4", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let queue = DispatchQueue(label: "local.store.sensor.data", qos: .background)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let responses = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: [String]]
                
                guard let urls: [String] = responses?["m2m:uril"] else { return }
                
                for url in urls {
                    queue.async {
                        semaphore.wait()
                        self.getData(urireq: url)
                        semaphore.signal()
                    }
                }
                
                print("done")
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}
