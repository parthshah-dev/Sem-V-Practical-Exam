// =====================================================
// MongoDB Order Information Example
// =====================================================

// Step 1: Use or Create Database
use SalesDB;

// Step 2: Drop Old Collection (Optional)
db.orderinfo.drop();

// Step 3: Insert Sample Documents
db.orderinfo.insertMany([
  { cust_id: 101, cust_name: "abc", status: "A", price: 250 },
  { cust_id: 102, cust_name: "xyz", status: "B", price: 450 },
  { cust_id: 103, cust_name: "pqr", status: "A", price: 300 },
  { cust_id: 104, cust_name: "lmn", status: "A", price: 800 },
  { cust_id: 105, cust_name: "def", status: "C", price: 1200 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// (i) Find average price for each customer having status 'A'
// =====================================================
print("🔹 Average price for customers with status 'A':");
db.orderinfo.aggregate([
  { $match: { status: "A" } },
  { $group: { _id: "$cust_name", avgPrice: { $avg: "$price" } } },
  { $sort: { avgPrice: 1 } }
]).forEach(printjson);

// =====================================================
// (ii) Display status of customers whose price is between 100 and 1000
// =====================================================
print("\n🔹 Customers with price between 100 and 1000:");
db.orderinfo.find(
  { price: { $gte: 100, $lte: 1000 } },
  { cust_name: 1, status: 1, price: 1, _id: 0 }
).pretty();

// =====================================================
// (iii) Display all customers' information without “_id”
// =====================================================
print("\n🔹 Customers information without _id:");
db.orderinfo.find({}, { _id: 0 }).pretty();

// =====================================================
// (iv) Create an index and check its impact
// =====================================================
print("\n🔹 Creating index on 'price' field:");
db.orderinfo.createIndex({ price: 1 });

// Check indexes created
print("\n🔹 Current Indexes:");
printjson(db.orderinfo.getIndexes());

// Example query using index
print("\n🔹 Query using indexed field (price > 300):");
db.orderinfo.find({ price: { $gt: 300 } }).explain("executionStats");

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB Orderinfo Example Completed Successfully ===\n");


/*

Practical: MongoDB Order Information Example

Theory:
This program demonstrates how to perform key MongoDB operations like filtering, aggregation, and indexing on a collection. The $match stage filters documents based on a condition (here, status: "A"), while $group with $avg computes the average price for each customer. The find() queries are used for filtering and displaying data with projections, and indexes are created using createIndex() to improve query performance on large datasets. Indexing allows MongoDB to locate data faster without scanning the entire collection, significantly improving read efficiency.

Syntax Used
// Aggregation with match and average
db.collection.aggregate([
  { $match: { condition } },
  { $group: { _id: "$field", avgValue: { $avg: "$numericField" } } }
]);

// Range query
db.collection.find({ field: { $gte: value1, $lte: value2 } });

// Create index
db.collection.createIndex({ field: 1 });

Input Collection
db.orderinfo.insertMany([
  { cust_id: 101, cust_name: "abc", status: "A", price: 250 },
  { cust_id: 102, cust_name: "xyz", status: "B", price: 450 },
  { cust_id: 103, cust_name: "pqr", status: "A", price: 300 },
  { cust_id: 104, cust_name: "lmn", status: "A", price: 800 },
  { cust_id: 105, cust_name: "def", status: "C", price: 1200 }
]);

(i) Find average price for each customer having status 'A'
Input Query
db.orderinfo.aggregate([
  { $match: { status: "A" } },
  { $group: { _id: "$cust_name", avgPrice: { $avg: "$price" } } },
  { $sort: { avgPrice: 1 } }
]);

Output
{ "_id": "abc", "avgPrice": 250 }
{ "_id": "pqr", "avgPrice": 300 }
{ "_id": "lmn", "avgPrice": 800 }

(ii) Display status of customers whose price is between 100 and 1000
Input Query
db.orderinfo.find(
  { price: { $gte: 100, $lte: 1000 } },
  { cust_name: 1, status: 1, price: 1, _id: 0 }
);

Output
{ "cust_name": "abc", "status": "A", "price": 250 }
{ "cust_name": "xyz", "status": "B", "price": 450 }
{ "cust_name": "pqr", "status": "A", "price": 300 }
{ "cust_name": "lmn", "status": "A", "price": 800 }

(iii) Display all customers' information without “_id”
Input Query
db.orderinfo.find({}, { _id: 0 });

Output
{ "cust_id": 101, "cust_name": "abc", "status": "A", "price": 250 }
{ "cust_id": 102, "cust_name": "xyz", "status": "B", "price": 450 }
{ "cust_id": 103, "cust_name": "pqr", "status": "A", "price": 300 }
{ "cust_id": 104, "cust_name": "lmn", "status": "A", "price": 800 }
{ "cust_id": 105, "cust_name": "def", "status": "C", "price": 1200 }

(iv) Create an index and check its impact
Input Query
db.orderinfo.createIndex({ price: 1 });
db.orderinfo.getIndexes();
db.orderinfo.find({ price: { $gt: 300 } }).explain("executionStats");

Output (Sample)
{
  "createdCollectionAutomatically": false,
  "numIndexesBefore": 1,
  "numIndexesAfter": 2,
  "ok": 1
}
[
  { "v": 2, "key": { "_id": 1 }, "name": "_id_" },
  { "v": 2, "key": { "price": 1 }, "name": "price_1" }
]


The explain("executionStats") result shows query execution details like index used, keys examined, and execution time, confirming the performance improvement after indexing.

*/