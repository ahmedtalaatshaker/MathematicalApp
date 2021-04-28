//
//  ResultView.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import UIKit

class ResultView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var equation: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var res: UILabel!
    
    @IBInspectable var setViewForPendingEquations: String? {
        didSet {
            result.text = ""
            res.text = ""
        }
    }
    
    @IBInspectable var setEquation: String? {
        didSet {
            equation.text = setEquation
        }
    }
    
    @IBInspectable var getEquation: String? {
        get {
            return equation.text
        }
    }
    
    @IBInspectable var setResult: String? {
        didSet {
            result.text = setResult
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    func commonInit() {
        
        guard let view = Bundle(for: type(of: self)).loadNibNamed("ResultView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        frame = view.bounds
        
        self.addSubview(view)
        
        initUi()
    }
    
    
    fileprivate func initUi() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 8
        containerView.layer.cornerRadius = 10
    }
    
    
}
