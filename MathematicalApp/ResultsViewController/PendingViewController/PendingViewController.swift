//
//  PendingViewController.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import UIKit


protocol removedEquation {
    func removed(equation:String)
}


class PendingViewController: mainViewController {

    @IBOutlet weak var stack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        realmDB.shared.delegateRemoved = self
        setResults()
        // Do any additional setup after loading the view.
    }
    
    func setResults(){
        for view in stack.subviews{
            view.isHidden = true
            view.removeFromSuperview()
        }
        
        for equation in realmDB.shared.allPendingEquations.reversed(){
            drawView(equation: equation.equation, success: {equationView in
                self.stack.addArrangedSubview(equationView)
            })
        }
    }
    
    func drawView(equation:String,success:@escaping (ResultView) -> Void){
        let equationView = ResultView()
        equationView.setEquation = equation
        equationView.setViewForPendingEquations = ""
        
        equationView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        equationView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        success(equationView)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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


extension PendingViewController:removedEquation{
    func removed(equation: String) {
        for view in stack.subviews{
            if let vi = view as? ResultView {
                if vi.getEquation == equation {
                    UIView.animate(withDuration: 1,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.9,
                                       initialSpringVelocity: 1,
                                       options: [],
                                       animations: {
                                        view.isHidden = true
                                        view.removeFromSuperview()
                                        self.stack.layoutIfNeeded()
                                        },
                                       completion: nil)
                    
                    break
                }
            }
        }
    }
    
    
}
