import UIKit
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //グラデーションをつける
               let gradientLayer = CAGradientLayer()
               gradientLayer.frame = self.view.bounds
               
               //グラデーションさせるカラーの設定
               //今回は、徐々に色を濃くしていく
               let color1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor     //白
               let color2 = UIColor(red: 120/256.0, green: 200/256.0, blue: 230/256.0, alpha: 1).cgColor   //水色
               let color3 = UIColor(red: 200/256.0, green: 150/256.0, blue: 256/256.0, alpha: 1).cgColor   //水色
        
        
        
               //CAGradientLayerにグラデーションさせるカラーをセット
               gradientLayer.colors = [color1, color2, color3]
               
               //グラデーションの開始地点・終了地点の設定
               //上が白で下が水色
               //gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
               //gradientLayer.endPoint = CGPoint.init(x: 0.5 , y:1 )
               
               //左が白で右が水色
               //gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
               //gradientLayer.endPoint = CGPoint.init(x: 1 , y:0.5)
               
               //左上が白で右下が水色
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.8, y:0.8)
               
               //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
               self.view.layer.insertSublayer(gradientLayer,at:0)
        
        //　2秒後に MainViewControllerに画面遷移
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            let vc = MessageViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil) }*/

            
        }
        
    }
    
