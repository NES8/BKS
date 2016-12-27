
import Foundation

enum ErrorToShow : Error {
    case messageError(message: String)
}

@objc protocol BasePresenter {
    @objc optional func viewDidLoad()
    @objc optional func viewWillAppear()
    @objc optional func viewDidAppear()
    @objc optional func viewWillDisappear()
    @objc optional func retry()
}
