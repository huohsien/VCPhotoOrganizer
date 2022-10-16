//
//  ViewController.swift
//  VCPhotoOrganizer
//
//  Created by victor on 2022/10/3.
//

import UIKit
import Photos
import AVKit

class ViewController: UIViewController {

    var albums:[PHAssetCollection] = [PHAssetCollection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let authStatus = PHPhotoLibrary.authorizationStatus()

        if (authStatus != .authorized) {
            print("no authorization for photo library")
            PHPhotoLibrary.requestAuthorization { (authStatus) in
                if (authStatus == .authorized) {
                    print("photo library authorized")
                } else {
                    print("unknown error")
                    return
                }
            }
        }
        while (authStatus != .authorized) {}
        getAllAlbumCollections()
        print("albums[0]=\(albums[0])")
    }

    func getAllAlbumCollections() {
        
        let albumsOptions = PHFetchOptions()
//        albumsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")
        albumsOptions.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]

        let fetchedResultAlbums = PHAssetCollection.fetchAssetCollections(with:.album, subtype: .any, options: albumsOptions)
        var albums = [PHAssetCollection]()
        fetchedResultAlbums.enumerateObjects { (collection, idx, stop) in
            albums.append(collection)
        }
    }
}

