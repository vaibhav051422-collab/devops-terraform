const express = require("express");
const app = express();

app.use(express.json());

let users = ["Vibhu", "Vaibhav"];

// Health check
app.get("/", (req, res) => {
  res.send("Server is running hehe congratulations");
});

// Get users
app.get("/users", (req, res) => {
  res.json(users);
});

// Add user
app.post("/users", (req, res) => {
  const { name } = req.body;
  users.push(name);
  res.send("User added");
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});