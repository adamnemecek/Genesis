//
//  ViewController.swift
//  Genesis
//
//  Created by Gerard Iglesias on 27/08/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

  lazy var container = {return (UIApplication.shared.delegate as? BoardAppDelegate)?.boardContainer}()
  @IBOutlet weak var infoView: UIView!
  @IBOutlet weak var infoController: UIViewController!
  
  required init?(coder aDecoder: NSCoder) {
    infoController = BoardInfoViewController(nibName: nil, bundle: nil)
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if let model = container?.managedObjectModel {
      // here extract some features
      NSLog("managed object: %@", model)
    }
    infoView.alpha = 0
    view.bringSubview(toFront: infoView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func showInfoView(_ sender: UITapGestureRecognizer) {
    UIViewPropertyAnimator(duration: 0.6, curve: UIViewAnimationCurve.easeIn) {
      self.infoView.alpha = 1 - self.infoView.alpha
    }.startAnimation()
  }
    
}
