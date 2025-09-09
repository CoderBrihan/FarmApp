import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import authRoutes from "./routes/auth.route.js";
import { connectDB } from "./lib/db.js";

dotenv.config();
const PORT = process.env.PORT;

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(cors());

app.use("/api/auth", authRoutes);
app.get("/", (req, res) => {
	res.status(200).json({ message: "Hello World!" });
});

app.listen(PORT, () => {
	connectDB();
	console.log(`Example app listening on port ${PORT}`);
});
