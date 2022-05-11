import UIKit
import PassKit
import SnapKit

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    

    let payButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10.0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 0
        btn.backgroundColor = .lightGray
        return btn}()
    
    let premiumPayButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10.0)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 15
        btn.layer.borderWidth = 0
        btn.backgroundColor = .lightGray
        return btn}()
    
    private var paymentRequest : PKPaymentRequest = {
           let request = PKPaymentRequest()
           request.merchantIdentifier = "merchant.com.pushpendra.pay"
           request.supportedNetworks = [.quicPay, .masterCard, .visa]
           request.supportedCountries = ["US"]
           request.merchantCapabilities = .capability3DS
           request.countryCode = "US"
           request.currencyCode = "USD"
           return request
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        super.view.addSubview(payButton)
        payButton.setTitle("Basic Subscribe", for: .normal)
        payButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(400)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(100)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-100)
        }
        
        super.view.addSubview(premiumPayButton)
        premiumPayButton.setTitle("Premium Subscribe", for: .normal)
        premiumPayButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(350)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(100)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-100)
        }
        
        payButton.addTarget(self, action: #selector(tapForPay), for: .touchUpInside)
        premiumPayButton.addTarget(self, action: #selector(tapForPreimumPay), for: .touchUpInside)
    }
    
    @objc func tapForPay(payButton: UIButton, sender : Any){
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Basic Subscribe", amount: 30)]
                if controller != nil {
                    controller!.delegate = self
                    present(controller!, animated: true, completion: nil)
                }
    }
    
    @objc func tapForPreimumPay(premiumPayButton: UIButton, sender : Any){
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Premium Subscribe", amount: 50)]
                if controller != nil {
                    controller!.delegate = self
                    present(controller!, animated: true, completion: nil)
                }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
}

    

