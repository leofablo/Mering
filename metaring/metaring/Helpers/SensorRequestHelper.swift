//
//  SensorRequestHelper.swift
//  metaring
//
//  Created by Rinaldi on 22/05/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AntaresSensorRequest {
    var semaphore = DispatchSemaphore (value: 0)
    
    var domainUrl = "https://platform.antares.id"
    var port = "8443"
    var cseId = "antares-cse"
    var cseName = "antares-id"
//    var applicationName = "SmartIdea"
    var applicationName = "SeiJagoWaterQuality"
//    var deviceName = "SensorTest"
    var deviceName = "waterQualitySensor"
    
//    var accessId = "6cd5e5cc78bbed06"
//    var accessPassword = "faefeda74389bcb0"
    var accessId = "f184b703e2d42c12"
    var accessPassword = "9e0852ac7001c2c8"
    
    func setupGetRequest() {
        
    }
    
    func setupFormatResult(stringData: String) -> NSDictionary {
        var result = NSDictionary()
        var dictonary: NSDictionary?
        if let dataJson = stringData.data(using: String.Encoding.utf8) {
            do {
                dictonary = try JSONSerialization.jsonObject(with: dataJson, options: [.allowFragments]) as? [String:AnyObject] as NSDictionary?
                if let dataJsonDictionary = dictonary {
                    result = (dataJsonDictionary["m2m:cin"]! as AnyObject) as! NSDictionary
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return result
    }
    
    func setupFormatSensorResult(sensorData: AnyObject) -> NSDictionary {
        var result = NSDictionary()
        var dictonary: NSDictionary?
        if let dataJson = sensorData.data(using: String.Encoding.utf8.rawValue) {
            do {
                dictonary = try JSONSerialization.jsonObject(with: dataJson, options: [.allowFragments]) as? [String:AnyObject] as NSDictionary?
                if let dataJsonDictionary = dictonary {
                    result = dataJsonDictionary
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return result
    }
    //https://platform.antares.id:8443/~/antares-cse/CAEe9ADXdO2S6mJfvh5
//f184b703e2d42c12:9e0852ac7001c2c8 \(accessId):\(accessPassword)
//    "\(domainUrl):\(port)/~/\(cseId)/\(cseName)/\(applicationName)/\(deviceName)/la"
    func getLastData() -> RequestSensorModel {
        var request = URLRequest(url: URL(string: "\(domainUrl):\(port)/~/\(cseId)/\(cseName)/\(applicationName)/\(deviceName)/la")!, timeoutInterval: Double.infinity)
        request.addValue("\(accessId):\(accessPassword)", forHTTPHeaderField: "X-M2M-Origin")
        request.addValue("application/json;ty=4", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        var requestSensor = RequestSensorModel()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                semaphore.signal()
                return
            }
            let stringData = String(data: data, encoding: .utf8)!
            let formatResult = setupFormatResult(stringData: stringData)
            let formatSensorResult = setupFormatSensorResult(sensorData: formatResult["con"]! as AnyObject)
            requestSensor.con = formatSensorResult as! [String : Any]
            requestSensor.ct = formatResult["ct"] as! String
            requestSensor.lt = formatResult["lt"] as! String
            requestSensor.pi = formatResult["pi"] as! String
            requestSensor.ri = formatResult["ri"] as! String
            requestSensor.st = formatResult["st"] as! Int
            requestSensor.ty = formatResult["ty"] as! Int
            requestSensor.status = true
            
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
//        print(requestSensor)
        
        return requestSensor
    }
}
