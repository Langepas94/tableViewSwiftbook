//
//  EmojiTableVIewControllerTableViewController.swift
//  tableViewSwiftbook
//
//  Created by Артём Тюрморезов on 28.09.2022.
//

import UIKit

class EmojiTableVIewControllerTableViewController: UITableViewController {
// MARK: - массив с объектами
var objects = [
Emoji(emoji: "👾", name: "Chubakka", description: "Is horror for you", isFavorite: false),
Emoji(emoji: "🎃", name: "Pumkin", description: "Its eating you from house", isFavorite: false),
Emoji(emoji: "🤖", name: "Robot", description: "Hello im robot", isFavorite: false),
Emoji(emoji: "😺", name: "Cat", description: "Meow meow", isFavorite: false)
]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - настройки навигейшн контроллера
        self.title = "Emoji Reader"
        navigationItem.leftBarButtonItem = editButtonItem
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    // MARK: - настройка перехода назад из кнопки сохранить
    @IBAction func unwidSegue(segue: UIStoryboardSegue){
        
        // MARK: - проверяем через гард идентификатор
        guard segue.identifier == "saveSegue" else {return}
        // MARK: - программно пишем код
        let sourceVC = segue.source as! NewEmojiTableViewController
        
        let emoji = sourceVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
        let newIP = IndexPath(row: objects.count, section: 0)
        objects.append(emoji)
        
        tableView.insertRows(at: [newIP], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let nvVC = segue.destination as! UINavigationController
        let newEmojiVC = nvVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiTablCell", for: indexPath) as! EmojiTableViewCell
        
        let obk = objects[indexPath.row]
        cell.set(obj: obk)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }



    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
  


    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favorite = favoriteAct(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favorite])
    }

    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let act = UIContextualAction(style: .destructive, title: "Done") { action, view, completion in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        act.backgroundColor = .systemGreen
        act.image = UIImage(systemName: "checkmark.circle")
        return act
    }
    
    func favoriteAct(at indexpath: IndexPath) -> UIContextualAction {
        var obj = objects[indexpath.row]
        let act = UIContextualAction(style: .normal, title: "Favorite") { action, view, completion in
            obj.isFavorite = !obj.isFavorite
            self.objects[indexpath.row] = obj
            completion(true)
        }
        act.backgroundColor = obj.isFavorite ? .systemRed : .gray
        act.image = UIImage(systemName: "heart")
        return act
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
