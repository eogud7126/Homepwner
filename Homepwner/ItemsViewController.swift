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
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            itemStore.removeItem(item: item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 기본 모양을 가진 UITableViewCell 인스턴스 생성
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        //재사용 셀이나 새로운 셀을 얻는다
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //물품 배열의 n번째에 있는 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다.
        //이 셀은 테이블 뷰의 n번째 행에 나타난다.
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
}
