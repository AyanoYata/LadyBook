import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var imegeView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var Category: UILabel!
    //@IBOutlet weak var Style: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}