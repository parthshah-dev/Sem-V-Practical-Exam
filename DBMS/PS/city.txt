// =====================================================
// MongoDB MapReduce Example: City Collection
// =====================================================

// Step 1: Use or Create Database
use CityDB;

// Step 2: Drop existing collection (optional)
db.city.drop();

// Step 3: Insert Sample Documents
db.city.insertMany([
  { city: "pune",       type: "urban",   state: "MH", population: 5600000 },
  { city: "mumbai",     type: "urban",   state: "MH", population: 12400000 },
  { city: "nagpur",     type: "urban",   state: "MH", population: 2400000 },
  { city: "nashik",     type: "semi-urban", state: "MH", population: 1800000 },
  { city: "delhi",      type: "urban",   state: "DL", population: 19000000 },
  { city: "gurgaon",    type: "urban",   state: "HR", population: 870000 },
  { city: "hisar",      type: "rural",   state: "HR", population: 300000 },
  { city: "kanpur",     type: "urban",   state: "UP", population: 2900000 },
  { city: "lucknow",    type: "urban",   state: "UP", population: 3400000 },
  { city: "meerut",     type: "semi-urban", state: "UP", population: 1500000 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// Step 4: Map Function
// (emits key-value pairs of field and population)
// =====================================================
var mapFunction = function() {
  emit(this.keyField, this.population);
};

// Step 5: Reduce Function
var reduceFunction = function(key, values) {
  return Array.sum(values);
};

// =====================================================
// (i) Statewise Total Population
// =====================================================
print("🔹 STATEWISE POPULATION:");
db.city.mapReduce(
  function() { emit(this.state, this.population); },
  reduceFunction,
  { out: "statewise_population" }
);
db.statewise_population.find().pretty();

// =====================================================
// (ii) Citywise Total Population
// =====================================================
print("\n🔹 CITYWISE POPULATION:");
db.city.mapReduce(
  function() { emit(this.city, this.population); },
  reduceFunction,
  { out: "citywise_population" }
);
db.citywise_population.find().pretty();

// =====================================================
// (iii) Typewise Total Population
// =====================================================
print("\n🔹 TYPEWISE POPULATION:");
db.city.mapReduce(
  function() { emit(this.type, this.population); },
  reduceFunction,
  { out: "typewise_population" }
);
db.typewise_population.find().pretty();

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB MapReduce Population Example Executed Successfully ===\n");


/*


Practical: MongoDB MapReduce Example – City Collection

Theory:
MapReduce in MongoDB is used to perform aggregation operations over a collection by dividing the work into two steps — map and reduce. The map function processes each document and emits key-value pairs, while the reduce function combines all values that share the same key. This helps in performing operations like summing, counting, or averaging data across different categories such as state, city, or type. Though MongoDB’s aggregate() method is more efficient now, MapReduce remains a useful concept for handling large-scale data and custom aggregation logic.

Syntax
db.collection.mapReduce(
   mapFunction,
   reduceFunction,
   {
     out: "output_collection_name"
   }
)

Input Collection
db.city.insertMany([
  { city: "pune", type: "urban", state: "MH", population: 5600000 },
  { city: "mumbai", type: "urban", state: "MH", population: 12400000 },
  { city: "nagpur", type: "urban", state: "MH", population: 2400000 },
  { city: "nashik", type: "semi-urban", state: "MH", population: 1800000 },
  { city: "delhi", type: "urban", state: "DL", population: 19000000 },
  { city: "gurgaon", type: "urban", state: "HR", population: 870000 },
  { city: "hisar", type: "rural", state: "HR", population: 300000 },
  { city: "kanpur", type: "urban", state: "UP", population: 2900000 },
  { city: "lucknow", type: "urban", state: "UP", population: 3400000 },
  { city: "meerut", type: "semi-urban", state: "UP", population: 1500000 }
]);

(i) Statewise Total Population
Input Query
db.city.mapReduce(
  function() { emit(this.state, this.population); },
  function(key, values) { return Array.sum(values); },
  { out: "statewise_population" }
);
db.statewise_population.find().pretty();

Output
{ "_id": "DL", "value": 19000000 }
{ "_id": "HR", "value": 1170000 }
{ "_id": "MH", "value": 22200000 }
{ "_id": "UP", "value": 7800000 }

(ii) Citywise Total Population
Input Query
db.city.mapReduce(
  function() { emit(this.city, this.population); },
  function(key, values) { return Array.sum(values); },
  { out: "citywise_population" }
);
db.citywise_population.find().pretty();

Output
{ "_id": "pune", "value": 5600000 }
{ "_id": "mumbai", "value": 12400000 }
{ "_id": "nagpur", "value": 2400000 }
{ "_id": "nashik", "value": 1800000 }
{ "_id": "delhi", "value": 19000000 }
{ "_id": "gurgaon", "value": 870000 }
{ "_id": "hisar", "value": 300000 }
{ "_id": "kanpur", "value": 2900000 }
{ "_id": "lucknow", "value": 3400000 }
{ "_id": "meerut", "value": 1500000 }

(iii) Typewise Total Population
Input Query
db.city.mapReduce(
  function() { emit(this.type, this.population); },
  function(key, values) { return Array.sum(values); },
  { out: "typewise_population" }
);
db.typewise_population.find().pretty();

Output
{ "_id": "urban", "value": 44670000 }
{ "_id": "semi-urban", "value": 3300000 }
{ "_id": "rural", "value": 300000 }

*/



// =====================================================
// MongoDB Aggregation Example: Citywise, Statewise, Typewise Population
// =====================================================

// Step 1: Select or Create Database
use CityDB;

// Step 2: Drop Old Collection (Optional)
db.city.drop();

// Step 3: Insert Sample Documents
db.city.insertMany([
  { city: "pune", type: "urban", state: "MH", population: 5600000 },
  { city: "nagpur", type: "urban", state: "MH", population: 2400000 },
  { city: "nashik", type: "semi-urban", state: "MH", population: 1800000 },
  { city: "ahmedabad", type: "urban", state: "GJ", population: 7200000 },
  { city: "surat", type: "urban", state: "GJ", population: 6000000 },
  { city: "rajkot", type: "semi-urban", state: "GJ", population: 1600000 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// 1️⃣ Statewise Population
// =====================================================
print("🔹 Statewise Population:");
db.city.aggregate([
  { $group: { _id: "$state", totalPopulation: { $sum: "$population" } } },
  { $sort: { _id: 1 } }
])

// =====================================================
// 2️⃣ Citywise Population
// =====================================================
print("\n🔹 Citywise Population:");
db.city.aggregate([
  { $group: { _id: "$city", totalPopulation: { $sum: "$population" } } },
  { $sort: { _id: 1 } }
])

// =====================================================
// 3️⃣ Typewise Population
// =====================================================
print("\n🔹 Typewise Population:");
db.city.aggregate([
  { $group: { _id: "$type", totalPopulation: { $sum: "$population" } } },
  { $sort: { _id: 1 } }
])

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB Aggregation Example (City Collection) Completed Successfully ===\n");


/*

Using Aggregation Framework

Practical: MongoDB Aggregation Example – Citywise, Statewise, and Typewise Population

Theory:
The MongoDB Aggregation Framework is a powerful feature used to process and analyze data in stages, transforming documents into meaningful summarized results. It allows you to perform operations like grouping, filtering, sorting, and calculating totals directly within the database. The $group stage is used to group documents by a specific field and apply aggregate functions like $sum, $avg, $max, etc. The $sort stage then arranges the output in a specified order. Compared to MapReduce, aggregation is faster, easier to use, and more efficient for real-time data processing.

Syntax
db.collection.aggregate([
  { $group: { _id: "$fieldName", aliasName: { $sum: "$numericField" } } },
  { $sort: { _id: 1 } }
])

Input Collection
db.city.insertMany([
  { city: "pune", type: "urban", state: "MH", population: 5600000 },
  { city: "nagpur", type: "urban", state: "MH", population: 2400000 },
  { city: "nashik", type: "semi-urban", state: "MH", population: 1800000 },
  { city: "ahmedabad", type: "urban", state: "GJ", population: 7200000 },
  { city: "surat", type: "urban", state: "GJ", population: 6000000 },
  { city: "rajkot", type: "semi-urban", state: "GJ", population: 1600000 }
]);

(i) Statewise Total Population
Input Query
db.city.aggregate([
  { $group: { _id: "$state", totalPopulation: { $sum: "$population" } } },
  { $sort: { _id: 1 } }
]);

Output
{ "_id": "GJ", "totalPopulation": 14800000 }
{ "_id": "MH", "totalPopulation": 9800000 }

(ii) Citywise Total Population
Input Query
db.city.aggregate([
  { $group: { _id: "$city", totalPopulation: { $sum: "$population" } } },
  { $sort: { _id: 1 } }
]);

Output
{ "_id": "ahmedabad", "totalPopulation": 7200000 }
{ "_id": "nagpur", "totalPopulation": 2400000 }
{ "_id": "nashik", "totalPopulation": 1800000 }
{ "_id": "pune", "totalPopulation": 5600000 }
{ "_id": "rajkot", "totalPopulation": 1600000 }
{ "_id": "surat", "totalPopulation": 6000000 }

(iii) Typewise Total Population
Input Query
db.city.aggregate([
  { $group: { _id: "$type", totalPopulation: { $sum: "$population" } } },
  { $sort: { _id: 1 } }
]);

Output
{ "_id": "semi-urban", "totalPopulation": 3400000 }
{ "_id": "urban", "totalPopulation": 21200000 }

*/