import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var imegeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleLabel: UILabel!
    
    //@IBOutlet weak var Category: UILabel!
    //@IBOutlet weak var Style: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
