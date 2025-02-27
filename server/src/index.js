import path from "path";
import { fileURLToPath } from "url";
import dotenv from "dotenv";
import express from "express";

// Eğer Coolify ortam değişkenleri yoksa, .env dosyasını yükle
if (!process.env.MONGODB_URI) {
  dotenv.config({ path: "../.env" });
}

import app from "./app.js";
import { logInfo, logError } from "./util/logging.js";
import { connectDBWithRetry } from "./db/connectDB.js";

// The environment should set the port
const port = process.env.PORT || 4000;

// __dirname benzeri kullanım (ES module olduğumuz için)
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

if (process.env.NODE_ENV === "production") {
  app.use(express.static(path.join(__dirname, "../dist")));

  app.get("*", (req, res) =>
    res.sendFile(path.join(__dirname, "../dist", "index.html")),
  );
}

const startServer = async () => {
  try {
    await connectDBWithRetry();
    app.listen(port, () => {
      logInfo(`Server started on port ${port}`);
    });
  } catch (error) {
    logError(error);
  }
};

// Start the server
startServer();
