import XCTest
@testable import Comfyfeet

@MainActor
final class ComfyfeetTests: XCTestCase {
    func testStoreSeedsBelowFreeLimit() {
        let store = Store()
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.items.count
        let added = store.add(NightLog())
        XCTAssertTrue(added)
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testAddRespectsFreeLimit() {
        let store = Store()
        while store.items.count < Store.freeLimit {
            _ = store.add(NightLog())
        }
        let added = store.add(NightLog())
        XCTAssertFalse(added)
        XCTAssertEqual(store.items.count, Store.freeLimit)
    }

    func testProBypassesFreeLimit() {
        let store = Store()
        store.isPro = true
        while store.items.count < Store.freeLimit {
            _ = store.add(NightLog())
        }
        let added = store.add(NightLog())
        XCTAssertTrue(added)
    }

    func testDeleteRemovesItem() {
        let store = Store()
        let item = NightLog()
        _ = store.add(item)
        store.delete(item)
        XCTAssertFalse(store.items.contains(item))
    }

    func testDeleteAtOffsetsRemovesItem() {
        let store = Store()
        let before = store.items.count
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.items.count, before - 1)
    }

    func testIsAtFreeLimitReflectsState() {
        let store = Store()
        XCTAssertFalse(store.isAtFreeLimit)
        while store.items.count < Store.freeLimit {
            _ = store.add(NightLog())
        }
        XCTAssertTrue(store.isAtFreeLimit)
    }
}
