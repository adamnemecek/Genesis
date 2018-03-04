//
//  BoardInfoViewController.swift
//  Genesis
//
//  Created by Gerard Iglesias on 16/10/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit

fileprivate let cacheId = "InfoViewCell"

class BoardInfoViewController: UIViewController {
  
  var messages = [String]()
  @IBOutlet weak var messageTable: UITableView!
  
  func addMessage(msg: String) {
    messages.append(msg)
    messageTable?.reloadData()
    messageTable.scrollToRow(at: [0,messages.count-1], at: .bottom, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //
    NotificationCenter.default.addObserver(forName: InfoEventGeneric, object: nil, queue: OperationQueue.main){ (notif) in
      self.addMessage(msg: notif.userInfo?["message"] as? String ?? "Bad Info Notification")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}

extension BoardInfoViewController: UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let text = messages[indexPath[1]]
    if let cell = tableView.dequeueReusableCell(withIdentifier: cacheId), let label = cell.textLabel {
      label.text = text
      return cell
    }
    let cell = UITableViewCell(style: .value1, reuseIdentifier: cacheId)
    cell.textLabel?.text = text
    return cell
  }
}

extension BoardInfoViewController: UITableViewDelegate {
  
}
