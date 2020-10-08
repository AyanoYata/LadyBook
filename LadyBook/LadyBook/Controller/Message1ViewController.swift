import UIKit

class Message1ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        //グラデーションカラー
        let color1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor     //白
        let color2 = UIColor(red: 256.0/256.0, green: 100/256.0, blue: 256/256.0, alpha: 1).cgColor   //ピンク
        
        
        //CAGradientLayerにグラデーションさせるカラーをセット
        gradientLayer.colors = [color1, color2]
        
        //左上が白で右下がピンク
        gradientLayer.startPoint = CGPoint.init(x: 0.3, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y:0.5)
        
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
}

