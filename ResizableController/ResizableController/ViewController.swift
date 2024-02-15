//

import UIKit

class ViewController: UIViewController {

    private lazy var presentButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(presentPopover), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(presentButton)
        presentButton.translatesAutoresizingMaskIntoConstraints = false

        presentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc 
    private func presentPopover(_ sender: Any) {
        let button = sender as? UIButton
        let buttonFrame = button?.frame ?? CGRect.zero

        let popoverContentController = PopoverContentController()
        popoverContentController.modalPresentationStyle = .popover

        if let popoverPresentationController = popoverContentController.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            present(popoverContentController, animated: true, completion: nil)
        }
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

