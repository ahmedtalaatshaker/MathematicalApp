//
//  MathematicalAppTests.swift
//  MathematicalAppTests
//
//  Created by ahmed talaat on 27/04/2021.
//

import XCTest
@testable import MathematicalApp

class MathematicalAppTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = true
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    let showCases_Data = showCases().allCases

    lazy var homeScreen : HomeViewController = {
        let storeboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        var viewCon = storeboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let _ = viewCon.view
        let _ = viewCon.viewDidLoad()

        return viewCon
    }()
    
    lazy var resultScreen : ResultsViewController = {
        let storeboard = UIStoryboard(name: "ResultsViewController", bundle: nil)
        var viewCon = storeboard.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        let _ = viewCon.view
        let _ = viewCon.viewDidLoad()
        let _ = viewCon.viewWillAppear(true)

        return viewCon
    }()

    lazy var pendingScreen : PendingViewController = {
        let storeboard = UIStoryboard(name: "PendingViewController", bundle: nil)
        var viewCon = storeboard.instantiateViewController(withIdentifier: "PendingViewController") as! PendingViewController
        let _ = viewCon.view
        let _ = viewCon.viewDidLoad()
        let _ = viewCon.viewWillAppear(true)

        return viewCon
    }()
    
    
    func testHomeScreen(){
        let testResult = tryCalculate()
        XCTAssertTrue(testResult == "",testResult)
    }
    
    func tryCalculate() -> String{
        let calculationParams = showCases_Data["MakeCalculations"]! as NSArray
        var allFailed = ""
        for _case in calculationParams {
            let caseDict = _case as! [String:Any]
            homeScreen.delayCount.text = caseDict["delayTime"] as? String
            homeScreen.equationField.text = caseDict["equation"] as? String
            homeScreen.mathOperator = caseDict["operator"] as! String

            if !homeScreen.makeCalculations(){
                allFailed += "\n❌" + caseDict.debugDescription
            }
        }
        return allFailed
    }
    
    func testResultsScreen(){
        checkForPendingExcutionEquations()
        checkResultsRecords()
    }
    
    func checkResultsRecords(){

        realmDB.shared.readFinishedEquations()
        if realmDB.shared.allEquations.count > 0{
            resultScreen.setResults()
            XCTAssertTrue(resultScreen.stack.subviews.count > 0 ,"stach is empty")
        }else{
            XCTAssertTrue(resultScreen.stack.subviews.count == 0 ,"stach contain ciews")

        }
    }
    
    func checkForPendingExcutionEquations(){
        let _ = tryCalculate() // to add pending equations

        
        if realmDB.shared.allPendingEquations.count > 0 {
            resultScreen.setCountLab(count:realmDB.shared.allPendingEquations.count)
            XCTAssertTrue(!resultScreen.countLab.isHidden, "counter lable hidden")

            pendingScreen.setResults()
            XCTAssertTrue(pendingScreen.stack.subviews.count > 0 ,"stach is empty")
        }else{
            XCTAssertTrue(resultScreen.countLab.isHidden, "counter lable not hidden")

            XCTAssertTrue(pendingScreen.stack.subviews.count == 0 ,"stach contain views")

        }
        
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
