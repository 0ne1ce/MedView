//
//  SleepTimestampsExtension.swift
//  MedView
//
//  Created by Алексей on 27.04.2025.
//

extension SleepTimestamp: TimestampData {
    var timestampValue: String {
        get { 
            return self.time ?? ""
        }
        set {
            self.time = newValue
        }
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
