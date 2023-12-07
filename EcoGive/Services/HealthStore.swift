//
//  StepCountManager.swift
//  EcoGive
//
//  Created by Mahmoud Gharbi on 29/11/2023.
//

import HealthKit
import SwiftUI
import Observation

enum HealthError: Error {
    case healthDataNotAvailable
}
class HealthStore: ObservableObject {
    
    @Published var stepData: StepData
    @Published var statData = DataModel.generateData
    
    @Published var goalPercentage: CGFloat = 0.0
    @Published var dailyStepCount: Int = 0
    @Published var weeklyStepCount: Int = 0
    
    var healthStore: HKHealthStore?
    var lastError: Error?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            lastError = HealthError.healthDataNotAvailable
        }
        
        // Load total step count from UserDefaults
        let totalSteps = UserDefaults.standard.integer(forKey: "totalSteps")
        stepData = StepData(count: totalSteps, goal: 6000)
    }
    
    func requestAuthorization() async {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        guard let healthStore = self.healthStore else { return }
        
        do {
            try await healthStore.requestAuthorization(toShare: [], read: [stepType])
        } catch {
            lastError = error
        }
    }
    
    func updateData() {
        
            //updateStepCount()
        updateDailyStepCount()
        
    }
    
    
        private func updateStepCount() {
            guard let healthStore = healthStore else { return }
    
            // Query HealthKit for the latest step count
            guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
    
            let query = HKStatisticsQuery(
                quantityType: stepCountType,
                quantitySamplePredicate: nil,
                options: .cumulativeSum
            ) { _, result, _ in
                if let sum = result?.sumQuantity() {
                    let steps = Int(sum.doubleValue(for: .count()))
    
                    // Update total step count
                    self.stepData.count = steps
                    //print(steps)
                    UserDefaults.standard.set(steps, forKey: "totalSteps")
    
                    // Update UI or perform additional actions as needed
                    self.calculateStats()
                }
            }
    
            healthStore.execute(query)
        }

    func updateDailyStepCount() {
        guard let healthStore = healthStore else { return }

        // Use a predicate to get samples from the beginning of the current day until now
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        // Query HealthKit for the latest step count
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        // Create a query to fetch the step count
        let query = HKStatisticsQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            if let sum = result?.sumQuantity() {
                let steps = Int(sum.doubleValue(for: .count()))

                // Update daily step count
                self.stepData.count = steps
                self.dailyStepCount = steps
                self.calculateStats()
                UserDefaults.standard.set(steps, forKey: "totalSteps")
                //print(self.dailyStepCount)
            }
        }

        // Execute the query
        healthStore.execute(query)
    }
    
        private func calculateStats() {
            stepData.mileCount = CGFloat(stepData.count) * 0.00029
            stepData.caloryCount = Int(CGFloat(stepData.count) * 0.036)
            stepData.minuteCount = Int(CGFloat(stepData.count) * 0.0075)
    
            goalPercentage = CGFloat(stepData.count) / CGFloat(stepData.goal)
    
            statData[0].value = String(format: "%.2f", stepData.mileCount)
            statData[1].value = "\(stepData.caloryCount)"
            statData[2].value = "\(stepData.minuteCount)\u{1D0D}"
        }
    
}
















//    private func updateStepCount() {
//        guard let healthStore = healthStore else { return }
//
//        // Query HealthKit for the latest step count
//        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
//
//        let query = HKStatisticsQuery(
//            quantityType: stepCountType,
//            quantitySamplePredicate: nil,
//            options: .cumulativeSum
//        ) { _, result, _ in
//            if let sum = result?.sumQuantity() {
//                let steps = Int(sum.doubleValue(for: .count()))
//
//                // Update total step count
//                self.stepData.count = steps
//                print(steps)
//                UserDefaults.standard.set(steps, forKey: "totalSteps")
//
//                // Update UI or perform additional actions as needed
//                self.calculateStats()
//            }
//        }
//
//        healthStore.execute(query)
//    }
//
//    private func calculateStats() {
//        stepData.mileCount = CGFloat(stepData.count) * 0.00029
//        stepData.caloryCount = Int(CGFloat(stepData.count) * 0.036)
//        stepData.minuteCount = Int(CGFloat(stepData.count) * 0.0075)
//
//        goalPercentage = CGFloat(stepData.count) / CGFloat(stepData.goal)
//
//        statData[0].value = String(format: "%.2f", stepData.mileCount)
//        statData[1].value = "\(stepData.caloryCount)"
//        statData[2].value = "\(stepData.minuteCount)\u{1D0D}"
//    }
//    func calculateSteps() async throws {
//        
//        guard let healthStore = self.healthStore else { return }
//        
//        let calendar = Calendar(identifier: .gregorian)
//        let startDate = calendar.date(byAdding: .day, value: -7, to: Date())
//        let endDate = Date()
//        
//        let stepType = HKQuantityType(.stepCount)
//        let everyDay = DateComponents(day:1)
//        let thisWeek = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
//        let stepsThisWeek = HKSamplePredicate.quantitySample(type: stepType, predicate:thisWeek)
//        
//        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: stepsThisWeek, options: .cumulativeSum, anchorDate: endDate, intervalComponents: everyDay)
//        
//        let stepsCount = try await sumOfStepsQuery.result(for: healthStore)
//        
//        guard let startDate = startDate else { return }
//        
//        stepsCount.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
//            let count = statistics.sumQuantity()?.doubleValue(for: .count())
//            let step = StepData(count: Int(count ?? 0), goal: 6000)
//            if step.count > 0 {
//                // add the step in steps collection
//                self.steps.append(step)
//            }
//        }
//        
//    }



