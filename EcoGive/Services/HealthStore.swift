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
    
    @Published var userStat: UserStat
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
        userStat = UserStat(Level: "1", StepCount: totalSteps.formatted(), UserId: "1",Goal: "6000",Score: "1000") // Assuming UserStat has properties like level, stepCount, userId
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
        // Update both total and daily step counts
        updateStepCount()
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
                self.userStat.StepCount = steps.formatted()
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
                self.userStat.StepCount = "\(steps.formatted())"

                self.dailyStepCount = steps
                self.calculateStats()
                UserDefaults.standard.set(steps, forKey: "totalSteps")
            }
        }

        // Execute the query
        healthStore.execute(query)
    }

    private func calculateStats() {
        // the Level Increases by 1 each time the user Achieves the Goal
        //The Goal Increases each time the user Achieves the Goal
        //Score increments when Goal increments
        if  let goal = Double(userStat.Goal) {
                goalPercentage = CGFloat(dailyStepCount) / CGFloat(goal)
            } else {
                // Handle conversion failure, perhaps log an error or set default values.
                goalPercentage = 0.0
            }
        print(userStat)
        }
   
}
