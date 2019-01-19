//
//  ObjectTests.swift
//  ObjectTests
//
//  Created by iMAC on 04.09.17.
//  Copyright © 2017 OKO. All rights reserved.
//

import XCTest
@testable import OKO_Control

class ObjectTests: XCTestCase {

    var objectUnderTest: Object!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        objectUnderTest = Object(name: "Test name", description: "Test description", devicePhone: "+380671234567", devicePassword: "1234", deviceType: DeviceType(rawValue: 0)!,  objectIcon: ObjectIcon(rawValue: 0)!, extraSettings: [], events: [], deviceIMEI: "123456789054321", channel: 1)
    }

    override func tearDown() {
        objectUnderTest = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCommand5_oko_pro() {
        // given
        objectUnderTest.deviceType = DeviceType(rawValue: 0)!
        // then
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "012", "oko-pro SMS command5 is wrong")
    }
    func testCommand5_dom3() {
        objectUnderTest.deviceType = DeviceType(rawValue: 1)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "012", "dom3 SMS command5 is wrong")
    }
    func testCommand5_oko_u2() {
        objectUnderTest.deviceType = DeviceType(rawValue: 2)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "012", "oko_u2 SMS command5 is wrong")
    }
    func testCommand5_oko_7s() {
        objectUnderTest.deviceType = DeviceType(rawValue: 3)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "012", "oko_7s SMS command5 is wrong")
    }
    func testCommand5_dom2_r2() {
        objectUnderTest.deviceType = DeviceType(rawValue: 4)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "012", "dom2_r2 SMS command5 is wrong")
    }
    func testCommand5_oko_s2() {
        objectUnderTest.deviceType = DeviceType(rawValue: 5)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "08", "oko_s2 SMS command5 is wrong")
    }
    func testCommand5_oko_socket() {
        objectUnderTest.deviceType = DeviceType(rawValue: 6)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "08", "oko_socket SMS command5 is wrong")
    }
    func testCommand5_oko_avto() {
        objectUnderTest.deviceType = DeviceType(rawValue: 7)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "04", "oko_avto SMS command5 is wrong")
    }
    func testCommand5_oko_navi() {
        objectUnderTest.deviceType = DeviceType(rawValue: 8)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "04", "oko_navi SMS command5 is wrong")
    }
    func testCommand5_oko_u() {
        objectUnderTest.deviceType = DeviceType(rawValue: 9)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "09", "oko_u SMS command5 is wrong")
    }
    func testCommand5_dom2() {
        objectUnderTest.deviceType = DeviceType(rawValue: 10)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "09", "dom2 SMS command5 is wrong")
    }
    func testCommand5_blits() {
        objectUnderTest.deviceType = DeviceType(rawValue: 11)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "08", "blits SMS command5 is wrong")
    }
    func testCommand5_obereg() {
        objectUnderTest.deviceType = DeviceType(rawValue: 12)!
        XCTAssertEqual(objectUnderTest.command5.smsCommand, "08", "obereg SMS command5 is wrong")
    }

    func testCommand5_fail() {
        objectUnderTest.deviceType = DeviceType(rawValue: 12)!
        XCTAssertNotEqual(objectUnderTest.command5.smsCommand, "01", "Fail test for obereg SMS command5 is wrong")
    }
    
}
