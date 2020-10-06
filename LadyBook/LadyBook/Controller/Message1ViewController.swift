import UIKit

class Message1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        //グラデーションさせるカラーの設定
        //今回は、徐々に色を濃くしていく
        let color1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor     //白
        let color3 = UIColor(red: 256.0/256.0, green: 150/256.0, blue: 256/256.0, alpha: 1).cgColor   //水色
        
        
        
        //CAGradientLayerにグラデーションさせるカラーをセット
        gradientLayer.colors = [color1, color3]
        
        
        //左上が白で右下が水色
        gradientLayer.startPoint = CGPoint.init(x: 0.3, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y:0.5)
        
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
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

