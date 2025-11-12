// =====================================================
// MongoDB MapReduce Example: Categorize Books by Pages
// =====================================================

// Step 1: Use or Create Database
use LibraryDB;

// Step 2: Drop old collection (optional)
db.books.drop();

// Step 3: Insert Sample Documents
db.books.insertMany([
  { name: "Understanding JAVA", pages: 400 },
  { name: "Database Systems", pages: 550 },
  { name: "C Programming", pages: 300 },
  { name: "Operating Systems", pages: 600 },
  { name: "Python Basics", pages: 280 },
  { name: "Advanced DBMS", pages: 700 },
  { name: "Machine Learning", pages: 800 },
  { name: "Data Structures", pages: 350 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// Step 4: Define Map Function
// =====================================================
var mapFunction = function() {
  if (this.pages >= 500)
    emit("Big Books", 1);    // books with 500 or more pages
  else
    emit("Small Books", 1);  // books with less than 500 pages
};

// =====================================================
// Step 5: Define Reduce Function
// =====================================================
var reduceFunction = function(key, values) {
  return Array.sum(values); // count total books in each category
};

// =====================================================
// Step 6: Execute MapReduce
// =====================================================
print("🔹 Categorizing books as Small or Big based on page count...\n");

db.books.mapReduce(
  mapFunction,
  reduceFunction,
  {
    out: "books_category"  // output collection name
  }
);

print("✅ MapReduce Executed Successfully!\n");

// =====================================================
// Step 7: View Results
// =====================================================
print("🔹 Total Books by Category:");
db.books_category.find().pretty();

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB MapReduce: Book Categorization Completed Successfully ===\n");



/*

Practical: MongoDB MapReduce Example – Categorize Books by Pages

Theory:
This program demonstrates the use of MapReduce in MongoDB to categorize books based on their page count. MapReduce is a data processing model that works in two stages: the Map phase and the Reduce phase. In the map phase, each document is processed, and a key-value pair is emitted depending on a condition (for example, whether the book is "Big" or "Small"). In the reduce phase, the emitted values with the same key are aggregated using operations like summing or averaging. This technique is useful for analytical tasks like counting, categorization, or summarization of large datasets.

Syntax
db.collection.mapReduce(
   mapFunction,
   reduceFunction,
   { out: "output_collection" }
)


mapFunction: Defines how data is emitted as key-value pairs.

reduceFunction: Aggregates the values for each key.

out: Specifies where to store the result.

Input Collection
db.books.insertMany([
  { name: "Understanding JAVA", pages: 400 },
  { name: "Database Systems", pages: 550 },
  { name: "C Programming", pages: 300 },
  { name: "Operating Systems", pages: 600 },
  { name: "Python Basics", pages: 280 },
  { name: "Advanced DBMS", pages: 700 },
  { name: "Machine Learning", pages: 800 },
  { name: "Data Structures", pages: 350 }
]);

(i) Categorize Books by Pages
Input Query
db.books.mapReduce(
  function() {
    if (this.pages >= 500)
      emit("Big Books", 1);
    else
      emit("Small Books", 1);
  },
  function(key, values) {
    return Array.sum(values);
  },
  { out: "books_category" }
);
db.books_category.find().pretty();

Output
{ "_id": "Big Books", "value": 4 }
{ "_id": "Small Books", "value": 4 }

*/








// =====================================================
// MongoDB Aggregation Example: Categorize Books by Pages
// =====================================================

// Step 1: Select or Create Database
use LibraryDB;

// Step 2: Drop Old Collection (Optional)
db.books.drop();

// Step 3: Insert Sample Documents
db.books.insertMany([
  { name: "Understanding JAVA", pages: 400 },
  { name: "C Programming", pages: 250 },
  { name: "Operating Systems", pages: 350 },
  { name: "Database Systems", pages: 500 },
  { name: "HTML & CSS", pages: 200 },
  { name: "Python Basics", pages: 150 }
]);

print("\n✅ Documents Inserted Successfully!\n");

// =====================================================
// Step 4: Aggregation to Categorize and Count Books
// =====================================================

db.books.aggregate([
  // Step 4.1: Project a new field "category" based on number of pages
  {
    $project: {
      name: 1,
      pages: 1,
      category: {
        $cond: {
          if: { $lte: ["$pages", 300] },    // If pages <= 300
          then: "Small Books",
          else: "Big Books"
        }
      }
    }
  },

  // Step 4.2: Group by category and count total books in each
  {
    $group: {
      _id: "$category",
      totalBooks: { $sum: 1 }
    }
  }
]).forEach(printjson);

// =====================================================
// ✅ END OF PROGRAM
// =====================================================
print("\n=== ✅ MongoDB Aggregation (Book Categorization) Example Completed Successfully ===\n");


/*

Practical: MongoDB Aggregation Example – Categorize Books by Pages

Theory:
This program demonstrates the use of the MongoDB Aggregation Framework to categorize and count books based on the number of pages. Aggregation pipelines allow multiple data-processing stages to be executed in sequence. Here, the $project stage is used to create a new field called category using the $cond operator, which applies conditional logic similar to an “if-else” statement. Books with 300 pages or fewer are labeled as Small Books, while those with more than 300 pages are labeled as Big Books. The $group stage then counts the total books in each category, and $sort arranges the results in ascending order.

Syntax
db.collection.aggregate([
  { $project: { fieldName: 1, newField: { $cond: { if: <condition>, then: <value1>, else: <value2> } } } },
  { $group: { _id: "$newField", count: { $sum: 1 } } },
  { $sort: { _id: 1 } }
])

Input Collection
db.books.insertMany([
  { name: "Understanding JAVA", pages: 400 },
  { name: "C Programming", pages: 250 },
  { name: "Operating Systems", pages: 350 },
  { name: "Database Systems", pages: 500 },
  { name: "HTML & CSS", pages: 200 },
  { name: "Python Basics", pages: 150 }
]);

(i) Categorize and Count Books
Input Query
db.books.aggregate([
  {
    $project: {
      name: 1,
      pages: 1,
      category: {
        $cond: {
          if: { $lte: ["$pages", 300] },
          then: "Small Books",
          else: "Big Books"
        }
      }
    }
  },
  {
    $group: {
      _id: "$category",
      totalBooks: { $sum: 1 }
    }
  },
  { $sort: { _id: 1 } }
]);

Output
{ "_id": "Big Books", "totalBooks": 3 }
{ "_id": "Small Books", "totalBooks": 3 }


*/