//
//  ResultsViewController.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import UIKit

protocol pendingExecution {
    func set(count:Int)
}

class ResultsViewController: mainViewController {

    static var resultsController = ResultsViewController()
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var countLab: UILabel!
    var pendingCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        realmDB.shared.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countLab.layer.cornerRadius = 10
        setCountLab(count: pendingCount)
        setResults()
    }
    
    func setResults(){
        for view in stack.subviews{
            view.isHidden = true
            view.removeFromSuperview()
        }
        
        for equation in realmDB.shared.allEquations.reversed(){
            drawView(equation: equation.equation, value: equation.result, success: {equationView in
                self.stack.addArrangedSubview(equationView)
            })
        }
    }
    
    func drawView(equation:String,value:String,success:@escaping (ResultView) -> Void){
        let equationView = ResultView()
        equationView.setResult = value
        equationView.setEquation = equation
        
        equationView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        equationView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        success(equationView)
    }
    
    func setNewRecord(equation:String,value:String){
        print(equation,value)
        drawView(equation: equation, value: value, success: {equationView in
            
            UIView.animate(withDuration: 1,
                               delay: 0.0,
                               usingSpringWithDamping: 0.9,
                               initialSpringVelocity: 1,
                               options: [],
                               animations: {
                                self.stack.insertArrangedSubview(equationView, at: 0)
                                self.stack.layoutIfNeeded()
                                },
                               completion: nil)
            
        })
    }
    
    
    @IBAction func openPendingController(_ sender: Any) {
        if pendingCount > 0 {
            let target = UIStoryboard(name: "PendingViewController", bundle: nil).instantiateViewController(withIdentifier: "PendingViewController")
            present(target, animated: true, completion: nil)
        }else{
            alert(message: "No Pending Execution Equations", viewController: self)
        }
    }
    

    func setCountLab(count:Int){
        pendingCount = count
        if countLab != nil {
            if count > 0 {
                countLab.isHidden = false
                countLab.text = "\(count)"
            }else{
                countLab.isHidden = true
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ResultsViewController:pendingExecution{
    func set(count: Int) {
        setCountLab(count:count)
    }
}
