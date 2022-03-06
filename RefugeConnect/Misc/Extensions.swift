//
//  Extensions.swift
//  RefugeConnect
//
//  Created by Christian Graver on 06/03/2022.
//

import Foundation
import MapKit

extension MKMapView {
		/// When calling this function, we just want all of the annotations to be displayed.
		func fitAllAnnotations() {
			var zoomRect            = MKMapRect.null;
				for annotation in annotations {
					let annotationPoint = MKMapPoint(annotation.coordinate)
					let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
					zoomRect            = zoomRect.union(pointRect);
				}
			setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
		}
}
