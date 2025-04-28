//
//  SleepTimestampsExtension.swift
//  MedView
//
//  Created by Алексей on 27.04.2025.
//

extension SleepTimestamp: TimestampData {
    var timestampValue: String {
        return self.time ?? ""
    }
    
    var repeatStatusEnabled: Bool {
        get {
            return self.repeatStatus
        }
        set {
            self.repeatStatus = newValue
        }
    }
}
