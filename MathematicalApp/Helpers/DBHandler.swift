//
//  DBHandler.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import Foundation
import RealmSwift


class equations :Object{
    @objc static let shared = equations()

    @objc dynamic var equation = ""
    @objc dynamic var result = ""

    static func create(equation: String,result: String) -> equations {
        let singleEquation = equations()
        singleEquation.equation = equation
        singleEquation.result = result
        
        return singleEquation
    }
}

class pendingEquations :Object{
    @objc static let shared = pendingEquations()

    @objc dynamic var equation = ""

    static func create(equation: String) -> pendingEquations {
        let singleEquation = pendingEquations()
        singleEquation.equation = equation
        
        return singleEquation
    }
}


class realmDB : NSObject{

    @objc static let shared = realmDB()
    let realm = try! Realm()
    var allEquations = [equations]()
    var allPendingEquations = [pendingEquations]()

    var delegate : pendingExecution?
    var delegateRemoved : removedEquation?

    func writeFinishedEquation(equation: String,result: String) {
        let singleEquation = equations.create(equation: equation, result: result)
        
        try? realm.write {
            realm.add(singleEquation)
            allEquations.append(singleEquation)
        }
        deleteFromPendingEquations(equation: equation)
    }
    
    func writePendingEquation(equation: String) {
        let singleEquation = pendingEquations.create(equation: equation)
        try? realm.write {
            realm.add(singleEquation)
            print(singleEquation)
            allPendingEquations.append(singleEquation)
        }
        
        delegate?.set(count:allPendingEquations.count)

    }
    
    func readFinishedEquations() {
        let data = realm.objects(equations.self)
        allEquations = []
        for row in data {
            let singleEquation = equations.create(equation: row.equation, result: row.result)
            allEquations.append(singleEquation)
        }
        print(data)
    }
    
    func deleteFromPendingEquations(equation:String){
        for index in 0..<allPendingEquations.count{
            if allPendingEquations[index].equation == equation{
                allPendingEquations.remove(at: index)
                delegateRemoved?.removed(equation:equation)
                break
            }
        }
        print(allPendingEquations)
        
        delegate?.set(count:allPendingEquations.count)

    }
    
    
    func deleteAllPendingEquations(){
        let data = realm.objects(pendingEquations.self)
        for row in data {
            try! realm.write {
                print(row)
                realm.delete(row)
            }
        }
        allPendingEquations.removeAll()
        print(allPendingEquations)

    }
    
}

