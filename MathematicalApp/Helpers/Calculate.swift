//
//  Calculate.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import Foundation

class calculator :NSObject{
    @objc static let shared = calculator()

    private override init(){
        
    }

    func makeCalculations(text:String,equationOperator:String,delay:Int,
                          sucess:@escaping(_ equation:String,_ value:String) -> Void) {

        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + Double(delay)) {
            let values = text.split(separator: Character(equationOperator))
            switch equationOperator {
            case Mathoperations.ADD.rawValue:
                let result = (Double(values[0]) ?? 0.0) + (Double(values[1]) ?? 0.0)
                sucess(text,"\(result)")

            case Mathoperations.SUP.rawValue:
                let result = (Double(values[0]) ?? 0.0) - (Double(values[1]) ?? 0.0)
                sucess(text,"\(result)")

            case Mathoperations.MUL.rawValue:
                let result = (Double(values[0]) ?? 0.0) * (Double(values[1]) ?? 0.0)
                sucess(text,"\(result)")

            case Mathoperations.DIV.rawValue:
                print(values)
                let result = (Double(values[0]) ?? 0.0) / (Double(values[1]) ?? 0.0)
                sucess(text,String(format: "%0.2f", result))

            default:
                sucess(text,"")
            }
        }
    }
}
