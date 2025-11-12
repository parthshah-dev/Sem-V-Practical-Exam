// =====================================================
// MongoDB Order Information Example
// =====================================================

// Step 1: Use or Create Database
use SalesDB;

// Step 2: Drop Old Collection (Optional)
db.orderinfo.drop();

// Step 3: Insert Sample Documents
db.orderinfo.insertMany([
  { cust_id: 123, cust_name: "abc", status: "A", price: 250 },
  { cust_id: 124, cust_name: "xyz", status: "B", price: 400 },
  { cust_id: 125, cust_name: "pqr", status: "A", price: 500 },
  { cust_id: 126, cust_name: "lmn", status: "C", price: 300 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// (i) Display name of customers having price between 250 and 450
// =====================================================
print("🔹 Customers with price between 250 and 450:");
db.orderinfo.find(
  { price: { $gte: 250, $lte: 450 } },
  { cust_name: 1, price: 1, _id: 0 }
).pretty();

// =====================================================
// (ii) Increment and Decrement price based on cust_id
// =====================================================
print("\n🔹 Increment price by 10 for cust_id: 123 and decrement by 5 for cust_id: 124:");
db.orderinfo.updateOne(
  { cust_id: 123 },
  { $inc: { price: 10 } }
);

db.orderinfo.updateOne(
  { cust_id: 124 },
  { $inc: { price: -5 } }
);

print("✅ Prices Updated Successfully!\n");

// Verify the updates
db.orderinfo.find({}, { cust_id: 1, cust_name: 1, price: 1, _id: 0 }).pretty();

// =====================================================
// (iii) Remove any one field from the orderinfo collection
// =====================================================
print("\n🔹 Removing 'status' field from all documents...");
db.orderinfo.updateMany({}, { $unset: { status: 1 } });
print("✅ 'status' field removed successfully!\n");

// Verify
db.orderinfo.find().pretty();

// =====================================================
// (iv) Find customers whose status is 'A' OR price = 250 OR both
// =====================================================
print("\n🔹 Customers whose status is 'A' or price = 250:");
db.orderinfo.find(
  { $or: [ { status: "A" }, { price: 250 } ] },
  { cust_name: 1, price: 1, status: 1, _id: 0 }
).pretty();

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB Orderinfo Query Example Completed Successfully ===\n");



/*

Practical: MongoDB Order Information Example (Query, Update, and Field Operations)

Theory:
This program illustrates how to perform querying, updating, and field manipulation in MongoDB using various operators. The $gte and $lte operators filter documents within a range, while $inc modifies numeric fields by increasing or decreasing their values. The $unset operator removes an existing field from all documents. Logical operators like $or are used to match documents satisfying one or more conditions. Together, these commands show MongoDB’s flexibility in managing and transforming data without rigid table structures as seen in traditional relational databases.

Syntax Used
// Find documents with range
db.collection.find({ field: { $gte: value1, $lte: value2 } });

// Increment or decrement field value
db.collection.updateOne({ condition }, { $inc: { field: value } });

// Remove field
db.collection.updateMany({}, { $unset: { field: 1 } });

// Logical OR condition
db.collection.find({ $or: [ { condition1 }, { condition2 } ] });

Input Collection
db.orderinfo.insertMany([
  { cust_id: 123, cust_name: "abc", status: "A", price: 250 },
  { cust_id: 124, cust_name: "xyz", status: "B", price: 400 },
  { cust_id: 125, cust_name: "pqr", status: "A", price: 500 },
  { cust_id: 126, cust_name: "lmn", status: "C", price: 300 }
]);

(i) Display name of customers having price between 250 and 450
Input Query
db.orderinfo.find(
  { price: { $gte: 250, $lte: 450 } },
  { cust_name: 1, price: 1, _id: 0 }
);

Output
{ "cust_name": "abc", "price": 250 }
{ "cust_name": "xyz", "price": 400 }
{ "cust_name": "lmn", "price": 300 }

(ii) Increment and Decrement price based on cust_id
Input Query
db.orderinfo.updateOne({ cust_id: 123 }, { $inc: { price: 10 } });
db.orderinfo.updateOne({ cust_id: 124 }, { $inc: { price: -5 } });

Output
{ "acknowledged": true, "matchedCount": 2, "modifiedCount": 2 }


Updated Records:

{ "cust_id": 123, "cust_name": "abc", "price": 260 }
{ "cust_id": 124, "cust_name": "xyz", "price": 395 }

(iii) Remove any one field from the orderinfo collection
Input Query
db.orderinfo.updateMany({}, { $unset: { status: 1 } });

Output
{ "acknowledged": true, "matchedCount": 4, "modifiedCount": 4 }


Resulting Documents:

{ "cust_id": 123, "cust_name": "abc", "price": 260 }
{ "cust_id": 124, "cust_name": "xyz", "price": 395 }
{ "cust_id": 125, "cust_name": "pqr", "price": 500 }
{ "cust_id": 126, "cust_name": "lmn", "price": 300 }

(iv) Find customers whose status is 'A' OR price = 250 OR both

Note: Since the status field was removed, this query will return only those matching the price condition.

Input Query
db.orderinfo.find(
  { $or: [ { status: "A" }, { price: 250 } ] },
  { cust_name: 1, price: 1, status: 1, _id: 0 }
);

Output
{ "cust_name": "abc", "price": 250 }


*/