//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by USER on 12/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    var itemStore: ItemStore!
    
    @IBAction func addItem(sender: AnyObject){
//        //0번 섹션, 마지막 행의 인덱스 패스를 만든다
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = NSIndexPath(row: lastRow, section: 0)
//        //테이블에 새로운 행을 삽입
//        tableView.insertRows(at: [(indexPath as IndexPath)], with: .automatic)
        
        //새 물품을 만들고 그것을 저장소에 추가
        let newItem = itemStore.createItem()
        //배열 안에서 이 항목의 위치를 계산
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = NSIndexPath(row: index, section: 0)
            
            //테이블에 새로운 행 삽입
            tableView.insertRows(at: [(indexPath as IndexPath)], with: .automatic)
        }
    }
    @IBAction func toggleEditingMode(sender: AnyObject){
        if isEditing{
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else{
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //상태 바의 높이를 얻는다
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        //inset: 스크롤 뷰의 네 변을 위한 패딩
        let inset = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0 )
        tableView.contentInset = inset
        tableView.scrollIndicatorInsets = inset
        
//        tableView.rowHeight = 65
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            let title = "Delete \(item.name)?"
            let message = "Are you sure to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item: item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            //알림창 컨트롤러를 표시한다.
            present(ac,animated: true,completion: nil)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 기본 모양을 가진 UITableViewCell 인스턴스 생성
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        //재사용 셀이나 새로운 셀을 얻는다
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        
        //물품 배열의 n번째에 있는 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다.
        //이 셀은 테이블 뷰의 n번째 행에 나타난다.
        let item = itemStore.allItems[indexPath.row]
        
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        //Item을 가지고 셀을 지정한다.
        cell.nameLabel.text = item.name
        cell.serialLabel.text = item.serialNumber
        cell.valueLabel.text = "\(item.valueInDollars)"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //모델을 업데이트
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
}
