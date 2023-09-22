//
//  CustomInputValidationController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.09.23.
//

import Foundation

class CustomInputValidationController {
    
    static func validate(type: CustomInputType, value: Double, units: String) -> (Bool, String?) {
        var result: (Bool, String?) = (false, nil)
        
        let metricUnits: Bool = {return units == "metric"}()
        switch type {
        case .age:
            if value < 16 {
                result =  (true, "Insert a valid age value")
            }
        case .height:
            if value < (metricUnits ? 120 : 47) {
                result = (true, "Invalid height value")
            }
        case .weight:
            if value < (metricUnits ? 40 : 88) {
                result = (true, "Invalid weight value")
            }
        case .waist:
            if value < (metricUnits ? 85 : 34) {
                result = (true, "Invalid waist value")
            }
        case .hip:
            if value < (metricUnits ? 60 : 23) {
                result = (true, "Invalid hip value")
            }
        case .neck:
            if value < (metricUnits ? 36 : 14) {
                result = (true, "Invalid neck value")
            }
        default:
            result = (false, nil)
        }
        
        return result
    }
    
}
