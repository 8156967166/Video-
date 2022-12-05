//
//  VideoTableViewCellModel.swift
//  VideoPrjct
//
//  Created by Bimal@AppStation on 28/10/22.
//

import Foundation
import AVFoundation

enum VideoCelltype {
    case videoCell
   
}

class VideoTableViewCellModel {
    
    var identifier: String = "video.cell"
    var cellType: VideoCelltype = .videoCell
//    var player : AVPlayer
    var currentTimeSecond: Float!
    var url: URL
    var isSelected: Bool = false
  
    
    init(url: URL, celltype: VideoCelltype) {
        self.cellType = celltype
        self.url = url
//        self.player = avplayer
        switch celltype {
        case .videoCell:
            identifier = "video.cell"
        }
    }
}
