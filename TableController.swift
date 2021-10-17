//
//  TableController.swift
//  test
//
//  Created by niu on 2021/9/29.
//  Copyright © 2021 niu. All rights reserved.
//

import UIKit

struct contestData: Decodable {
	 var name: String
	 var score: String
 }

class ViewCell: UITableViewCell {
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var score: UILabel!
}

class TableController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		getContestData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	var shopName:[String] = []
	var shopScore:[String] = []

	func getContestData() {
			 let address = "http://120.101.8.95:5000/users"
			 if let url = URL(string: address) {
				 // GET
				 URLSession.shared.dataTask(with: url) { (data, response, error) in
					// 假如錯誤存在，則印出錯誤訊息（ 例如：網路斷線等等... ）
					 if let error = error {
						 print("Error: \(error.localizedDescription)")
						// 取得 response 和 data
					 } else if let response = response as? HTTPURLResponse,let data = data {
						// 將 response 轉乘 HTTPURLResponse 可以查看 statusCode 檢查錯誤（ ex: 404 可能是網址錯誤等等... ）
						 print("Status code: \(response.statusCode)")
						// 創建 JSONDecoder 實例來解析我們的 json 檔
						 let decoder = JSONDecoder()
						// decode 從 json 解碼，返回一個指定類型的值，這個類型必須符合 Decodable 協議
						 if let contestData = try? decoder.decode([contestData].self, from: data) {
							print("=====Data======")
							
							// 改變 UI 的動作必須在主線程完成，所以將下面的 code 包在 DispatchQueue.main.async 的大括號裡面
							DispatchQueue.main.async{
							 for contest in contestData {                   self.shopName.append(contest.name)
								 self.shopScore.append(contest.score)
								//print("名字: \(contest.name)")
								//print("分數: \(contest.score)")
							 }
								 print(contestData)
							}
						 }
					 }
				 }.resume()
			 } else {
				 print("Invalid URL.")
			 }
		 }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shopName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "view_cell", for: indexPath) as! ViewCell
		cell.name.text = shopName[indexPath.row]
		cell.score.text = shopScore[indexPath.row]


        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
