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
  { cust_id: 101, cust_name: "abc", status: "A", price: 150 },
  { cust_id: 102, cust_name: "xyz", status: "C", price: 350 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// (i) Find total price for each customer and display in order of total price
// =====================================================
print("🔹 Total price for each customer (sorted by total):");
db.orderinfo.aggregate([
  { $group: { _id: "$cust_name", totalPrice: { $sum: "$price" } } },
  { $sort: { totalPrice: 1 } } // ascending order
]).forEach(printjson);

// =====================================================
// (ii) Find distinct customer names
// =====================================================
print("\n🔹 Distinct Customer Names:");
db.orderinfo.distinct("cust_name");

// =====================================================
// (iii) Display price of customers whose status is 'A'
// =====================================================
print("\n🔹 Price of customers with status 'A':");
db.orderinfo.find(
  { status: "A" },
  { cust_name: 1, price: 1, _id: 0 }
).pretty();

// =====================================================
// (iv) Delete customers whose status is 'A'
// =====================================================
print("\n🔹 Deleting customers with status 'A':");
db.orderinfo.deleteMany({ status: "A" });
print("✅ Deleted Successfully!");

// =====================================================
// View Remaining Records
// =====================================================
print("\n🔹 Remaining Documents:");
db.orderinfo.find().pretty();

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB Order Information Example Completed Successfully ===\n");


/*

Practical: MongoDB Order Information Example

Theory:
This program demonstrates common MongoDB operations such as aggregation, filtering, distinct value extraction, and deletion using an order information collection. It performs data analysis and manipulation using MongoDB’s aggregation framework and CRUD commands. The $group stage is used to calculate the total price for each customer, $sort arranges them by total amount, distinct() finds unique customer names, and find() filters documents based on conditions like status. Finally, deleteMany() removes multiple documents that match a given condition. This example helps in understanding practical business data handling and reporting in MongoDB.

Syntax Used
// Aggregation
db.collection.aggregate([{ $group: { _id: "$field", total: { $sum: "$value" } } }, { $sort: { total: 1 } }]);

// Distinct values
db.collection.distinct("fieldName");

// Conditional find
db.collection.find({ condition }, { projection });

// Delete multiple documents
db.collection.deleteMany({ condition });

Input Collection
db.orderinfo.insertMany([
  { cust_id: 101, cust_name: "abc", status: "A", price: 250 },
  { cust_id: 102, cust_name: "xyz", status: "B", price: 450 },
  { cust_id: 103, cust_name: "pqr", status: "A", price: 300 },
  { cust_id: 101, cust_name: "abc", status: "A", price: 150 },
  { cust_id: 102, cust_name: "xyz", status: "C", price: 350 }
]);

(i) Find total price for each customer and display in order of total price
Input Query
db.orderinfo.aggregate([
  { $group: { _id: "$cust_name", totalPrice: { $sum: "$price" } } },
  { $sort: { totalPrice: 1 } }
]);

Output
{ "_id": "pqr", "totalPrice": 300 }
{ "_id": "abc", "totalPrice": 400 }
{ "_id": "xyz", "totalPrice": 800 }

(ii) Find distinct customer names
Input Query
db.orderinfo.distinct("cust_name");

Output
["abc", "xyz", "pqr"]

(iii) Display price of customers whose status is 'A'
Input Query
db.orderinfo.find(
  { status: "A" },
  { cust_name: 1, price: 1, _id: 0 }
);

Output
{ "cust_name": "abc", "price": 250 }
{ "cust_name": "pqr", "price": 300 }
{ "cust_name": "abc", "price": 150 }

(iv) Delete customers whose status is 'A'
Input Query
db.orderinfo.deleteMany({ status: "A" });

Output
{ "acknowledged": true, "deletedCount": 3 }

Remaining Records After Deletion
{ "cust_id": 102, "cust_name": "xyz", "status": "B", "price": 450 }
{ "cust_id": 102, "cust_name": "xyz", "status": "C", "price": 350 }


*/