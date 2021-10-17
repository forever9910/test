//
//  TableViewController.swift
//  test
//
//  Created by niu on 2021/8/19.
//  Copyright © 2021 niu. All rights reserved.
//

import UIKit

struct CoffeeData: Decodable {
	 var name: String
	 var city: String
 }

class Cell: UITableViewCell {
	@IBOutlet weak var product: UILabel!
	@IBOutlet weak var price: UILabel!
}

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		getCoffeeData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	var shopName:[String] = []
	var shopCity:[String] = []

	func getCoffeeData() {
			 let address = "https://cafenomad.tw/api/v1.2/cafes/taipei"
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
						 if let coffeeData = try? decoder.decode([CoffeeData].self, from: data) {
							print("=====Data======")
							
							// 改變 UI 的動作必須在主線程完成，所以將下面的 code 包在 DispatchQueue.main.async 的大括號裡面
							DispatchQueue.main.async{
							 for coffee in coffeeData {                   self.shopName.append(coffee.name)
								 self.shopCity.append(coffee.city)
								//print("店名: \(coffee.name)")
								//print("城市: \(coffee.city)")
							 }
								 //print(coffeeData)
								self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table_cell", for: indexPath)as! Cell
		cell.product.text = shopName[indexPath.row]
		cell.price.text = shopCity[indexPath.row]

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
