import UIKit
import XLPagerTabStrip

class First2ViewController: UIViewController {
    
    
    @IBOutlet weak var writtingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    @IBAction func tapWrittingButton(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(identifier: "WritingView") as! WritingViewController
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
