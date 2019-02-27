// Copyright © 2019 Square1.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
@testable import Square1Tools

class TableViewTestCell: UITableViewCell, ReusableView {}

class TableViewTests: XCTestCase {

    private var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        tableView = UITableView()
        tableView.dataSource = self
    }

    func test01_TableViewRegister() {
        tableView.register(TableViewTestCell.self)
        XCTAssertTrue(true)
    }
    
    func test02_TableViewDequeue() {
        tableView.register(TableViewTestCell.self)
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TableViewTestCell)
    }
    
    func test03_NumberOfRows() {
        tableView.register(TableViewTestCell.self)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows, 1)
    }
    
    func test04_LastSection() {
        tableView.register(TableViewTestCell.self)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.lastSection, 0)
    }
    
    func test05_IndexPathForLastRow() {
        tableView.register(TableViewTestCell.self)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.indexPathForLastRow, IndexPath(row: 0, section: 0))
    }

}

extension TableViewTests: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewTestCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    
}
