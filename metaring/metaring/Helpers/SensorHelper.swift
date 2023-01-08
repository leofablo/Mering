//
//  SensorHelper.swift
//  metaring
//
//  Created by Rinaldi on 22/05/22.
//

import Foundation
import CoreData

extension MetaringCoreDataManager {
    func delete(data: Sensor) {
        viewContext.delete(data)
        save()
    }
    func getAllDataSensor() -> [SensorModel] {
        let request: NSFetchRequest<Sensor> = Sensor.fetchRequest()
        do {
            return try viewContext.fetch(request).map(SensorModel.init).sorted { $0.createTime < $1.createTime }
        } catch {
            return []
        }
    }
    func getDataSensorById(id: NSManagedObjectID) -> Sensor? {
        do {
            return try viewContext.existingObject(with: id) as? Sensor
        } catch {
            return nil
        }
    }
    
    func groupByDay() -> [SensorModel] {
        let request: NSFetchRequest<Sensor> = Sensor.fetchRequest()
        do {
            let res = try viewContext.fetch(request).map(SensorModel.init).sorted { $0.createTime < $1.createTime }
            return res
        } catch {
            return []
        }
    }
    
    func getLimOffsetData(limit: Int = 10, offset: Int = 10) -> [SensorModel] {
        let request: NSFetchRequest<Sensor> = Sensor.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Sensor.time), ascending: false)
        
        request.sortDescriptors = [sort]
        request.fetchLimit = limit
        request.fetchOffset = limit
        
        do {
            return try viewContext.fetch(request).map(SensorModel.init).sorted { $0.time < $1.time }
        } catch {
            return []
        }
    }
    
    func isDataByDateExists(date: Date) -> Bool {
        let request: NSFetchRequest<Sensor> = Sensor.fetchRequest()
        
        do {
            let sensorDatas = try viewContext.fetch(request).map(SensorModel.init)
            
            for sensorData in sensorDatas {
                if sensorData.time == date {
                    return true
                }
            }
            
            return false
        } catch {
            return false
        }
    }
}
