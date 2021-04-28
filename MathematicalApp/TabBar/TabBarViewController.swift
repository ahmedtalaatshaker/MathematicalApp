//
//  TabBarViewController.swift
//  MathematicalApp
//
//  Created by ahmed talaat on 27/04/2021.
//

import UIKit
import ESTabBarController_swift

class TabBarViewController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let NowPlayingStoryboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        let TopRatedStoryboard = UIStoryboard(name: "ResultsViewController", bundle: nil)
        let SearchStoryboard = UIStoryboard(name: "MapViewController", bundle: nil)
        
        let v1 = NowPlayingStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        let v2 = TopRatedStoryboard.instantiateViewController(withIdentifier: "ResultsViewController")
        let v3 = SearchStoryboard.instantiateViewController(withIdentifier: "GoogleMapViewController")
        
        v1.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Calculator", image: UIImage(named: "calculator"), selectedImage: UIImage(named: "calculator"))
        v2.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Results", image: UIImage(named: "accounting"), selectedImage: UIImage(named: "accounting"))
        v3.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Map", image: UIImage(named: "map"), selectedImage: UIImage(named: "map"))

        ResultsViewController.resultsController = v2 as! ResultsViewController
        var _ = v2.viewDidLoad()
        
        viewControllers = [v1, v2, v3]
        
        // Do any additional setup after loading the view.
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
