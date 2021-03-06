//
//  ID3AttachedPicturesFrameCreatorsTest.swift
//
//  Created by Fabrizio Duroni on 27/02/2018.
//  2018 Fabrizio Duroni.
//

import XCTest
@testable import ID3TagEditor

class ID3AttachedPicturesFramesCreatorTest: XCTestCase {
    func testNoFrameCreationWhenThereIsNoImage() {
        let tagBytes: [UInt8] = [1, 1, 1]
        let id3AttachedPictureFrameCreator = ID3AttachedPicturesFramesCreator(
                attachedPictureFrameCreator: ID3AttachedPictureFrameCreator(
                        id3FrameConfiguration: ID3FrameConfiguration(),
                        id3AttachedPictureFrameConfiguration: ID3AttachedPictureFrameConfiguration(),
                        frameContentSizeCalculator: MockFrameContentSizeCalculator(),
                        frameFlagsCreator: MockFrameFlagsCreator()
                )
        )

        let newTagBytes = id3AttachedPictureFrameCreator.createFrames(
                id3Tag: ID3Tag(version: .version3, size: 0),
                tag: tagBytes
        )

        XCTAssertEqual(newTagBytes, tagBytes)
    }

    func testFrameCreationWithJpgForVersion2() {
        let id3Tag = ID3Tag(version: .version2, size: 0)
        id3Tag.attachedPictures = [AttachedPicture(picture: Data(bytes: [0x10, 0x10]), type: .FrontCover, format: .Jpeg)]
        let id3AttachedPictureFrameCreator = ID3AttachedPicturesFramesCreator(
                attachedPictureFrameCreator: ID3AttachedPictureFrameCreator(
                        id3FrameConfiguration: ID3FrameConfiguration(),
                        id3AttachedPictureFrameConfiguration: ID3AttachedPictureFrameConfiguration(),
                        frameContentSizeCalculator: MockFrameContentSizeCalculator(),
                        frameFlagsCreator: MockFrameFlagsCreator()
                )
        )

        let newTagBytes = id3AttachedPictureFrameCreator.createFrames(
                id3Tag: id3Tag,
                tag: [0x01, 0x01, 0x01]
        )

        XCTAssertEqual(
                newTagBytes,
                [0x01, 0x01, 0x01, 0x50, 0x49, 0x43, 0x11, 0x00, 0x00, 0x4A, 0x50, 0x47, 0x03, 0x00, 0x10, 0x10]
        )
    }

    func testFrameCreationWithPngForVersion2() {
        let id3Tag = ID3Tag(version: .version2, size: 0)
        id3Tag.attachedPictures = [AttachedPicture(picture: Data(bytes: [0x10, 0x10]), type: .FrontCover, format: .Png)]
        let id3AttachedPictureFrameCreator = ID3AttachedPicturesFramesCreator(
                attachedPictureFrameCreator: ID3AttachedPictureFrameCreator(
                        id3FrameConfiguration: ID3FrameConfiguration(),
                        id3AttachedPictureFrameConfiguration: ID3AttachedPictureFrameConfiguration(),
                        frameContentSizeCalculator: MockFrameContentSizeCalculator(),
                        frameFlagsCreator: MockFrameFlagsCreator()
                )
        )

        let newTagBytes = id3AttachedPictureFrameCreator.createFrames(
                id3Tag: id3Tag,
                tag: [0x01, 0x01, 0x01]
        )

        XCTAssertEqual(
                newTagBytes,
                [0x01, 0x01, 0x01, 0x50, 0x49, 0x43, 0x11, 0x00, 0x00, 0x50, 0x4E, 0x47, 0x03, 0x00, 0x10, 0x10]
        )
    }

    func testFrameCreationWithJpgForVersion3() {
        let id3Tag = ID3Tag(version: .version3, size: 0)
        id3Tag.attachedPictures = [AttachedPicture(picture: Data(bytes: [0x10, 0x10]), type: .FrontCover, format: .Jpeg)]
        let id3AttachedPictureFrameCreator = ID3AttachedPicturesFramesCreator(
                attachedPictureFrameCreator: ID3AttachedPictureFrameCreator(
                        id3FrameConfiguration: ID3FrameConfiguration(),
                        id3AttachedPictureFrameConfiguration: ID3AttachedPictureFrameConfiguration(),
                        frameContentSizeCalculator: MockFrameContentSizeCalculator(),
                        frameFlagsCreator: MockFrameFlagsCreator()
                )
        )

        let newTagBytes = id3AttachedPictureFrameCreator.createFrames(
                id3Tag: id3Tag,
                tag: [0x01, 0x01, 0x01]
        )

        XCTAssertEqual(
                newTagBytes,
                [0x01, 0x01, 0x01, 0x41, 0x50, 0x49, 0x43, 0x11,
                 0x00, 0x00, 0x69, 0x6D, 0x61, 0x67, 0x65, 0x2F,
                 0x6A, 0x70, 0x65, 0x67, 0x00, 0x03, 0x00, 0x10,
                 0x10]
        )
    }

    func testFrameCreationWithPngForVersion3() {
        let id3Tag = ID3Tag(version: .version3, size: 0)
        id3Tag.attachedPictures = [AttachedPicture(picture: Data(bytes: [0x10, 0x10]), type: .FrontCover, format: .Png)]
        let id3AttachedPictureFrameCreator = ID3AttachedPicturesFramesCreator(
                attachedPictureFrameCreator: ID3AttachedPictureFrameCreator(
                        id3FrameConfiguration: ID3FrameConfiguration(),
                        id3AttachedPictureFrameConfiguration: ID3AttachedPictureFrameConfiguration(),
                        frameContentSizeCalculator: MockFrameContentSizeCalculator(),
                        frameFlagsCreator: MockFrameFlagsCreator()
                )
        )

        let newTagBytes = id3AttachedPictureFrameCreator.createFrames(
                id3Tag: id3Tag,
                tag: [0x01, 0x01, 0x01]
        )

        XCTAssertEqual(
                newTagBytes,
                [0x01, 0x01, 0x01, 0x41, 0x50, 0x49, 0x43, 0x11,
                 0x00, 0x00, 0x69, 0x6D, 0x61, 0x67, 0x65, 0x2F,
                 0x70, 0x6E, 0x67, 0x00, 0x03, 0x00, 0x10, 0x10]
        )
    }

    func testFrameCreationWithPngForAnotherTypeOfCover() {
        let id3Tag = ID3Tag(version: .version3, size: 0)
        id3Tag.attachedPictures = [
            AttachedPicture(picture: Data(bytes: [0x10, 0x10]), type: .FrontCover, format: .Png),
            AttachedPicture(picture: Data(bytes: [0x10, 0x10]), type: .BackCover, format: .Png)
        ]
        let id3AttachedPictureFrameCreator = ID3AttachedPicturesFramesCreator(
                attachedPictureFrameCreator: ID3AttachedPictureFrameCreator(
                        id3FrameConfiguration: ID3FrameConfiguration(),
                        id3AttachedPictureFrameConfiguration: ID3AttachedPictureFrameConfiguration(),
                        frameContentSizeCalculator: MockFrameContentSizeCalculator(),
                        frameFlagsCreator: MockFrameFlagsCreator()
                )
        )

        let newTagBytes = id3AttachedPictureFrameCreator.createFrames(
                id3Tag: id3Tag,
                tag: [0x01, 0x01, 0x01]
        )

        XCTAssertEqual(
                newTagBytes,
                [0x01, 0x01, 0x01, 0x41, 0x50, 0x49, 0x43, 0x11,
                 0x00, 0x00, 0x69, 0x6D, 0x61, 0x67, 0x65, 0x2F,
                 0x70, 0x6E, 0x67, 0x00, 0x03, 0x00, 0x10, 0x10,
                 0x41, 0x50, 0x49, 0x43, 0x11, 0x00, 0x00, 0x69,
                 0x6D, 0x61, 0x67, 0x65, 0x2F, 0x70, 0x6E, 0x67,
                 0x00, 0x04, 0x00, 0x10, 0x10]
        )
    }
}
