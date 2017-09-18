/*
 MIT License

 Copyright (c) 2017 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import MapKit

open class LocationMessageCell: MessageCollectionViewCell<UIImageView> {

    lazy var mapSnapshotOptions: MKMapSnapshotOptions = {
        let options = MKMapSnapshotOptions()
        options.showsBuildings = true
        options.showsPointsOfInterest = true
        options.scale = UIScreen.main.scale
        return options
    }()

    override open func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        switch message.data {
        case .location(let location):
            let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0)
            mapSnapshotOptions.region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapSnapshotOptions.size = messageContainerView.frame.size
            let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
            snapShotter.start(completionHandler: { (snapshot: MKMapSnapshot?, error: Error?) in
                self.messageContentView.image = snapshot?.image
            })
        default:
            break
        }
    }

}
