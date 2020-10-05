import UIKit
import XLPagerTabStrip

class First2ViewController: UIViewController, IndicatorInfoProvider {
    
    
    @IBOutlet weak var writtingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    @IBAction func tapWrittingButton(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(identifier: "WritingView") as! WritingViewController
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Top")

    
    }
    

}
