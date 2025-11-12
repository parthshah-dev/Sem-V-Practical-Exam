// =====================================================
// MongoDB Movies Collection Example
// =====================================================

// Step 1: Use or Create Database
use MovieDB;

// Step 2: Drop Old Collection (Optional)
db.movies.drop();

// Step 3: Insert Sample Documents
db.movies.insertMany([
  {
    name: "Movie1",
    type: "action",
    budget: 1000000,
    producer: { name: "producer1", address: "PUNE" }
  },
  {
    name: "Movie2",
    type: "drama",
    budget: 80000,
    producer: { name: "producer2", address: "MUMBAI" }
  },
  {
    name: "Movie3",
    type: "action",
    budget: 120000,
    producer: { name: "producer1", address: "DELHI" }
  }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// (i) Find the name of movies having budget greater than 1,00,000
// =====================================================
print("🔹 Movies with budget greater than 1,00,000:");
db.movies.find(
  { budget: { $gt: 100000 } },
  { name: 1, _id: 0 }
).pretty();

// =====================================================
// (ii) Find the name of producer who lives in PUNE
// =====================================================
print("\n🔹 Producers living in PUNE:");
db.movies.find(
  { "producer.address": "PUNE" },
  { "producer.name": 1, _id: 0 }
).pretty();

// =====================================================
// (iii) Update the type of movie “action” to “horror”
// =====================================================
print("\n🔹 Updating type 'action' → 'horror':");
db.movies.updateMany(
  { type: "action" },
  { $set: { type: "horror" } }
);
print("✅ Update Successful!\n");

// =====================================================
// (iv) Find all the documents produced by “producer1” with their address
// =====================================================
print("🔹 Movies produced by 'producer1':");
db.movies.find(
  { "producer.name": "producer1" },
  { name: 1, "producer.address": 1, _id: 0 }
).pretty();

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB Movies Collection Example Executed Successfully ===\n");


/*

Practical: MongoDB Movies Collection Example

Theory:
This program shows how to perform basic CRUD (Create, Read, Update, Delete) operations and nested document queries in MongoDB using a movie collection. MongoDB stores data in a flexible, JSON-like format called BSON, allowing documents to contain embedded objects. Here, operations include inserting documents, filtering based on conditions ($gt, equality match), updating records ($set), and querying nested fields (like producer.address). These commands are fundamental to database management and help in retrieving, updating, and managing hierarchical data efficiently.

Syntax Used
// Find with condition
db.collection.find({ condition }, { projection });

// Update records
db.collection.updateMany({ condition }, { $set: { field: value } });

Input Collection
db.movies.insertMany([
  {
    name: "Movie1",
    type: "action",
    budget: 1000000,
    producer: { name: "producer1", address: "PUNE" }
  },
  {
    name: "Movie2",
    type: "drama",
    budget: 80000,
    producer: { name: "producer2", address: "MUMBAI" }
  },
  {
    name: "Movie3",
    type: "action",
    budget: 120000,
    producer: { name: "producer1", address: "DELHI" }
  }
]);

(i) Find the name of movies having budget greater than 1,00,000
Input Query
db.movies.find(
  { budget: { $gt: 100000 } },
  { name: 1, _id: 0 }
);

Output
{ "name": "Movie1" }
{ "name": "Movie3" }

(ii) Find the name of producers who live in PUNE
Input Query
db.movies.find(
  { "producer.address": "PUNE" },
  { "producer.name": 1, _id: 0 }
);

Output
{ "producer": { "name": "producer1" } }

(iii) Update the type of movie “action” to “horror”
Input Query
db.movies.updateMany(
  { type: "action" },
  { $set: { type: "horror" } }
);

Output
{ "acknowledged": true, "matchedCount": 2, "modifiedCount": 2 }

(iv) Find all the documents produced by “producer1” with their address
Input Query
db.movies.find(
  { "producer.name": "producer1" },
  { name: 1, "producer.address": 1, _id: 0 }
);

Output
{ "name": "Movie1", "producer": { "address": "PUNE" } }
{ "name": "Movie3", "producer": { "address": "DELHI" } }


*/