//
//  EmojiTableViewCell.swift
//  tableViewSwiftbook
//
//  Created by Артём Тюрморезов on 28.09.2022.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(obj: Emoji) {
        self.emojiLabel.text = obj.emoji
        self.nameLabel.text = obj.name
        self.descriptionLabel.text = obj.description
    }

}
