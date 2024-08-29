//
//  UIViewController+Routing.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 14.04.2021.
//

import Foundation
import UIKit

public extension UIViewController {
    @discardableResult func unwindTo<UnwindVCType> (_ unwindedType: UnwindVCType.Type, completion: ((UnwindVCType) -> Void)? = nil ) -> UnwindVCType? where UnwindVCType: UIViewController {
        guard let wanted = findInAncestors(unwindedType) else { return nil }
        wanted.navigationController?.popToViewController(wanted, animated: true)
        
        if wanted.presentedViewController != nil {
            wanted.dismiss(animated: true, completion:  { completion?(wanted) })
        }
        return wanted
    }
    
    func findInAncestors<UnwindVCType> (_ unwindedType: UnwindVCType.Type) -> UnwindVCType? where UnwindVCType: UIViewController {
        
        let wantedPresenting = { self.presentingViewController as? UnwindVCType }
        let wantedInPresenting = { self.presentingViewController?.findInAncestors(unwindedType) }
        let wantedInNavigation = { self.navigationController?.viewControllers.find(ofType: UnwindVCType.self) }
        let wantedParent = { self.parent as? UnwindVCType }
        let wantedInChild = { self.findInChilds(UnwindVCType.self) }
        
        return wantedPresenting() ?? wantedParent() ?? wantedInNavigation() ?? wantedInPresenting() ?? wantedInChild()
    }
    
    func findInChilds<UnwindVCType> (_ unwindedType: UnwindVCType.Type) -> UnwindVCType? where UnwindVCType: UIViewController {
        return  self as? UnwindVCType
            ??
            children.find { $0.findInChilds(UnwindVCType.self) }
    }
    
}
public extension UIViewController {
    public func showAlertWithTitle(_ title: String, message: String, isError: Bool = false, okCompletion: (() -> ())? = nil, presentingCompletion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let style: UIAlertAction.Style = isError ? .destructive : .cancel
        let ok = UIAlertAction(title: "OK", style: style) { (action) in
            okCompletion?()
        }
        alert.addAction(ok)
        OperationQueue.main.addOperation {
            self.present(alert, animated: true, completion: presentingCompletion)
        }
    }
    
    func showConfirmationAlert(title: String?, message: String?, isError: Bool = false, okActionTitle: String = "Да", cancelActionTitle: String = "Отменить", onCancel: (() -> Void)? = nil, onAccept: (() -> Void)?) {
        let style: UIAlertAction.Style = isError ? .destructive : .cancel
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: style) { (_) in
            onAccept?()
        }
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { _ in
            onCancel?()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func showResultAlert(title: String?, message: String?, isError: Bool = false, okActionTitle: String = "Ok") {
        let style: UIAlertAction.Style = isError ? .destructive : .cancel
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: style) { (_) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func showConfirmationErrorAlert(message: String, action: (() -> Void)?) {
        showConfirmationAlert(title: "",
                              message: message,
                              isError: true,
                              okActionTitle: "Да",
                              onAccept: action)
    }
    
    func present(_ next: UIViewController, style: UIModalPresentationStyle? = .fullScreen, transition: UIModalTransitionStyle? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        style.map { next.modalPresentationStyle = $0 }
        transition.map { next.modalTransitionStyle = $0 }
        
        self.present(next, animated: animated) {
            completion?()
        }
    }
    
    func push(_ next: UIViewController) {
        navigationController?.show(next, sender: nil)
    }
    
    func presentFrom(_ last: UIViewController?, style: UIModalPresentationStyle? = .fullScreen, transition: UIModalTransitionStyle? = nil, completion: (() -> Void)? = nil) {
        style.map { self.modalPresentationStyle = $0 }
        transition.map { self.modalTransitionStyle = $0 }
        
        last?.present(self, animated: true) {
            completion?()
        }
    }

    func dismissVC(completion: @escaping(() -> Void)) {
        self.dismiss(animated: true) {
            completion()
        }
    }

    func dismissVC() {
        self.dismiss(animated: true)
    }
}

public func present(_ next: UIViewController, style: UIModalPresentationStyle? = .fullScreen, transition: UIModalTransitionStyle? = nil, completion: (() -> Void)? = nil) {
    UIViewController.lastPresented?.present(next, style: style, transition: transition, completion: completion)
}

public extension UIViewController {
    var lastPresented: UIViewController {
        var iterator: UIViewController = self
        while let presented = iterator.presentedViewController { iterator = presented }
        return iterator
    }

    static var lastPresented: UIViewController? {
        guard var iterator: UIViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let presented = iterator.presentedViewController { iterator = presented }
        return iterator
    }
}


func lastInNavigation(navigation: UINavigationController) -> UIViewController {
    if let navigationVC = navigation.topViewController as? UINavigationController {
        return lastInNavigation(navigation: navigationVC)
    } else {
        return navigation.topViewController ?? navigation
    }
}

public var topVC: UIViewController? {

    if let navigationVC = UIViewController.lastPresented as? UINavigationController {
        return lastInNavigation(navigation: navigationVC)
    } else {
        return .lastPresented
    }

}





public var keyWindow: UIWindow? {
    UIApplication.shared.keyWindow
}
